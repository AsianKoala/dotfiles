static const char norm_fg[] = "#e8ddd1";
static const char norm_bg[] = "#0b0822";
static const char norm_border[] = "#a29a92";

static const char sel_fg[] = "#e8ddd1";
static const char sel_bg[] = "#A9344D";
static const char sel_border[] = "#e8ddd1";

static const char urg_fg[] = "#e8ddd1";
static const char urg_bg[] = "#5F4A65";
static const char urg_border[] = "#5F4A65";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
