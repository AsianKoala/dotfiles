#!/usr/bin/env python
"""Replace pywal's auto palette with a kmeans-extracted, contrast-softened one.

Goal: reduce harsh white-on-black feel. We pick:
  - bg: tinted dark from the image (NOT absolute black) — adds purple/rose tint
  - fg: desaturated lightest tone — pink-cream, not neon pink
  - accents: mid-luminance, modestly saturated

usage: pywal-from-kmeans.py <wallpaper>
"""
from __future__ import annotations
import colorsys
import json
import subprocess
import sys
from pathlib import Path

import numpy as np
from PIL import Image


def kmeans(pixels: np.ndarray, k: int, iters: int = 30, seed: int = 42):
    rng = np.random.default_rng(seed)
    n = pixels.shape[0]
    centroids = np.empty((k, 3), dtype=np.float64)
    centroids[0] = pixels[rng.integers(0, n)]
    closest = np.full(n, np.inf)
    for i in range(1, k):
        diff = pixels - centroids[i - 1]
        closest = np.minimum(closest, np.einsum("ij,ij->i", diff, diff))
        s = closest.sum()
        probs = (closest / s) if s > 0 else None
        centroids[i] = pixels[rng.choice(n, p=probs)]
    for _ in range(iters):
        d2 = ((pixels[:, None, :] - centroids[None, :, :]) ** 2).sum(axis=2)
        labels = d2.argmin(axis=1)
        new_c = centroids.copy()
        for j in range(k):
            m = pixels[labels == j]
            if len(m):
                new_c[j] = m.mean(axis=0)
        if np.linalg.norm(new_c - centroids) < 1e-3:
            centroids = new_c
            break
        centroids = new_c
    return np.clip(centroids, 0, 255).astype(np.uint8)


def lum(rgb):
    r, g, b = (c / 255.0 for c in rgb)
    return 0.2126 * r + 0.7152 * g + 0.0722 * b


def sat(rgb):
    r, g, b = (c / 255.0 for c in rgb)
    _, _, s = colorsys.rgb_to_hls(r, g, b)
    return s


def adjust(rgb, *, lightness=None, saturation=None):
    r, g, b = (c / 255.0 for c in rgb)
    h, l, s = colorsys.rgb_to_hls(r, g, b)
    if lightness is not None:
        l = max(0.0, min(1.0, lightness))
    if saturation is not None:
        s = max(0.0, min(1.0, saturation))
    r, g, b = colorsys.hls_to_rgb(h, l, s)
    return (int(r * 255), int(g * 255), int(b * 255))


def mix(a, b, t):
    return tuple(int(a[i] * (1 - t) + b[i] * t) for i in range(3))


def hex_of(rgb):
    return "#{:02X}{:02X}{:02X}".format(*(int(c) for c in rgb))


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    wp = Path(sys.argv[1]).expanduser()
    if not wp.is_file():
        sys.exit(f"file not found: {wp}")

    img = Image.open(wp).convert("RGB")
    img.thumbnail((400, 400), Image.Resampling.LANCZOS)
    px = np.asarray(img, dtype=np.float64).reshape(-1, 3)

    centroids = kmeans(px, k=10, iters=30)
    cols = [tuple(int(x) for x in c) for c in centroids]
    cols.sort(key=lum)

    # --- BG: tinted dark, not absolute black ---
    candidates = [c for c in cols if 0.005 < lum(c) < 0.20 and sat(c) > 0.05]
    if not candidates:
        candidates = cols[1:4] if len(cols) > 3 else cols
    bg_seed = max(candidates, key=sat)
    bg = adjust(bg_seed, lightness=0.055)        # ~#1a0612 — softly tinted dark

    # --- FG: cream-pink, properly readable (NOT washed) ---
    fg_seed = cols[-1]
    fg = adjust(fg_seed, lightness=0.88, saturation=0.40)  # pink-cream that pops

    # --- accents: build an explicit luminance ramp from the image hue ---
    # This guarantees semantic distinction even with a monochromatic palette.
    # Pick the most-saturated cluster as our "hue donor" then synthesize a ramp.
    mids = sorted(cols[1:-1], key=lambda c: -sat(c))
    while len(mids) < 6:
        mids.append(cols[len(mids) % len(cols)])
    hue_donor = mids[0]

    # 6 accents: each gets a specific (luminance, saturation) target
    # so the colorscheme can map syntax groups to distinct visual roles.
    targets = [
        (0.25, 0.55),  # color1 — very dark accent, operators/borders
        (0.35, 0.65),  # color2 — dark accent
        (0.45, 0.70),  # color3 — types/raspberry
        (0.55, 0.70),  # color4 — functions/rose
        (0.50, 0.45),  # color5 — comments (mid lum, low sat = recedes)
        (0.68, 0.75),  # color6 — vivid pink, keywords (the loud one)
    ]
    accents = [adjust(hue_donor, lightness=L, saturation=S) for L, S in targets]

    dim = mix(bg, fg, 0.45)
    bright_fg = adjust(fg, lightness=0.94, saturation=0.50)

    palette = [bg] + accents + [fg] + [dim] + accents + [bright_fg]
    palette = palette[:16]

    special = {
        "background": hex_of(bg),
        "foreground": hex_of(fg),
        "cursor":     hex_of(fg),
    }
    colors_dict = {f"color{i}": hex_of(c) for i, c in enumerate(palette)}

    theme = {
        "wallpaper": str(wp),
        "alpha":     "100",
        "special":   special,
        "colors":    colors_dict,
    }

    theme_dir = Path.home() / ".config" / "wal" / "colorschemes" / "dark"
    theme_dir.mkdir(parents=True, exist_ok=True)
    theme_path = theme_dir / "kmeans-current.json"
    theme_path.write_text(json.dumps(theme, indent=2))

    print(f"theme: {theme_path}")
    print(f"bg: {special['background']}  fg: {special['foreground']}")
    for i in range(16):
        print(f"  color{i:>2}: {colors_dict[f'color{i}']}")

    subprocess.run(["wal", "--theme", str(theme_path), "-n", "-q"], check=False)
    # keep the actual wallpaper recorded in colors.sh
    colors_sh = Path.home() / ".cache" / "wal" / "colors.sh"
    if colors_sh.exists():
        text = colors_sh.read_text()
        text = text.replace(f"wallpaper='{theme_path}'", f"wallpaper='{wp}'")
        colors_sh.write_text(text)


if __name__ == "__main__":
    main()
