const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0b0822", /* black   */
  [1] = "#5F4A65", /* red     */
  [2] = "#A9344D", /* green   */
  [3] = "#8B4865", /* yellow  */
  [4] = "#93518B", /* blue    */
  [5] = "#E4579B", /* magenta */
  [6] = "#698EA9", /* cyan    */
  [7] = "#e8ddd1", /* white   */

  /* 8 bright colors */
  [8]  = "#a29a92",  /* black   */
  [9]  = "#5F4A65",  /* red     */
  [10] = "#A9344D", /* green   */
  [11] = "#8B4865", /* yellow  */
  [12] = "#93518B", /* blue    */
  [13] = "#E4579B", /* magenta */
  [14] = "#698EA9", /* cyan    */
  [15] = "#e8ddd1", /* white   */

  /* special colors */
  [256] = "#0b0822", /* background */
  [257] = "#e8ddd1", /* foreground */
  [258] = "#e8ddd1",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
