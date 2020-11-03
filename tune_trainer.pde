boolean IS_RENDER = false;  // show all bars at the end if outputting for video
int X_OFFSET = 150;
int Y_OFFSET = 100;
long FADE_DURATION = 500;
long BAR_DURATION = 6000;

String[] songFiles;
int songIndex = 0;
String title; 
String[] bars;
PFont font, titleFont;

long timerLast;

int lastBar;
int bar;

void setup() {
  //print(join(PFont.list(), "\n"));
  size(960, 540, P2D);
  frameRate(30);
  titleFont = createFont("DejaVu Serif Italic", 40, true);
  font = createFont("DejaVu Serif", 36, true);
  textAlign(CENTER, TOP);

  songFiles = new File(sketchPath() + "/data").list();

  reset();
}

void reset() {
  timerLast = millis() + BAR_DURATION / 2;
  lastBar = -1;
  bar = 0;
  readSong(songFiles[songIndex]);
}

void draw() {
  background(255, 0.5);
  fill(0);

  long t = millis();

  textFont(titleFont);
  textSize(40);
  text(title, width/2, 20);

  textFont(font);
  textSize(36);

  // update fade
  int fade = round(min(255, 255.0 * (t - timerLast) / FADE_DURATION));

  Pos lastBarPos = getBarPosition(lastBar);
  Pos currentBarPos = getBarPosition(bar);

  // fade the last bar out
  if (lastBarPos != null) {
    drawBar(0, 0, 0, 255 - fade, lastBar, lastBarPos);
  }

  // fade the current bar in
  if (currentBarPos != null) {
    drawBar(255, 0, 0, fade, bar, currentBarPos);
  } else {
    // we reached the end, so reveal all the bars
    for (int i = 0; i < bars.length; i++)
      drawBar(0, 0, 0, 255, i, getBarPosition(i));
  }

  drawBarLines();

  // update bar if timer expires
  if (t >= timerLast + BAR_DURATION && bar < bars.length) {
    //print("fade: " + fade + ", raw: " + ((timerLast + t) / (timerLast + FADE_DURATION)) + ", bar: " + bar + ", lastBar: " + lastBar +
    //  ", lastBarPos pos: " + lastBarPos + ", currentBarPos pos: " + currentBarPos + "\n");
    timerLast = t;

    // keep track of previous bar
    lastBar = bar;
    // seek to the next bar, skipping empty ones
    do {
      bar++;
    } while (bar < bars.length && bars[bar].trim().equals(""));
  }

  if (IS_RENDER)
    saveFrame("frames/####.png");
}

Pos getBarPosition(int n) {
  if (n < 0 || n >= bars.length)
    return null;

  int x = 0;

  if (n % 3 == 0)
    x = X_OFFSET / 2;
  else
    x = X_OFFSET + (n % 3 * 2 - 1) * (width-X_OFFSET)/4;

  return new Pos(x, Y_OFFSET + n / 3 * height / 16);
}

void drawBarLines() {
  fill(0);
  int x = X_OFFSET;
  int x2 = X_OFFSET + (width - X_OFFSET) / 2;

  line(x, Y_OFFSET, x, height - 10);
  line(x2, Y_OFFSET, x2, height - 10);
}

void drawBar(int r, int g, int b, int a, int bar, Pos pos) {
  fill(r, g, b, a);
  text(bars[bar].trim(), pos.x, pos.y);
}

void readSong(String path) {
  String[] lines = loadStrings(path);
  title = lines[0];

  // this would be easier with a functional language, but...
  StringBuilder sb = new StringBuilder();

  for (int i = 1; i < lines.length; i++) {
    sb.append(lines[i]);
    sb.append("|");
  }

  bars = split(sb.toString(), "|");
}

// restart when key pressed
void keyPressed() {
  int numSongs = songFiles.length;

  if (key == 'n') {
    songIndex = (songIndex + 1) % numSongs;
    reset();
  } else if (key == 'p') {
    songIndex = (songIndex + numSongs - 1) % numSongs;
    reset();
  } else if (key == 'q' || key == ESC)
    exit();
  else if (key == ENTER) {
    bar = bars.length;
  } else
    reset();
}

class Pos {
  int x;
  int y;

  public Pos(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public String toString() {
    return "(x: " + x + ", y: " + y + ")";
  }
}
