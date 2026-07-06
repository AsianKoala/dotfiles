#!/usr/bin/env python
"""Posterize an image to K colors via k-means — produces a flat 'kmeans wallpaper'.

Fits K centroids on a downscaled copy, then maps every full-res pixel to its
nearest centroid. Output goes next to the source as <name>-kmeans<K>.jpg.

usage: wallpaper-kmeans.py <image> [k]   (default k=6)
run with the pywal16 venv python (has numpy + Pillow):
  ~/.local/pipx/venvs/pywal16/bin/python wallpaper-kmeans.py <image> [k]
"""
from __future__ import annotations
import sys
from pathlib import Path

import numpy as np
from PIL import Image


def kmeans(px: np.ndarray, k: int, iters: int = 40, seed: int = 42) -> np.ndarray:
    rng = np.random.default_rng(seed)
    n = px.shape[0]
    c = np.empty((k, 3))
    c[0] = px[rng.integers(0, n)]
    closest = np.full(n, np.inf)
    for i in range(1, k):
        d = px - c[i - 1]
        closest = np.minimum(closest, np.einsum("ij,ij->i", d, d))
        s = closest.sum()
        c[i] = px[rng.choice(n, p=(closest / s if s > 0 else None))]
    for _ in range(iters):
        lbl = ((px[:, None, :] - c[None, :, :]) ** 2).sum(2).argmin(1)
        nc = c.copy()
        for j in range(k):
            m = px[lbl == j]
            if len(m):
                nc[j] = m.mean(0)
        if np.linalg.norm(nc - c) < 1e-3:
            c = nc
            break
        c = nc
    return c


def main() -> None:
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    src = Path(sys.argv[1]).expanduser()
    k = int(sys.argv[2]) if len(sys.argv) > 2 else 6
    if not src.is_file():
        sys.exit(f"file not found: {src}")

    img = Image.open(src).convert("RGB")
    full = np.asarray(img)
    h, w, _ = full.shape

    small = img.copy()
    small.thumbnail((300, 300), Image.Resampling.LANCZOS)
    cent = kmeans(np.asarray(small, dtype=np.float64).reshape(-1, 3), k)

    flat = full.reshape(-1, 3).astype(np.float64)
    lbl = np.empty(flat.shape[0], dtype=int)
    for i in range(0, flat.shape[0], 500_000):  # chunk to bound memory
        ch = flat[i : i + 500_000]
        lbl[i : i + 500_000] = ((ch[:, None, :] - cent[None, :, :]) ** 2).sum(2).argmin(1)

    out = cent[lbl].reshape(h, w, 3).clip(0, 255).astype(np.uint8)
    dst = src.with_name(f"{src.stem}-kmeans{k}.jpg")
    Image.fromarray(out).save(dst, quality=95)
    print(dst)


if __name__ == "__main__":
    main()
