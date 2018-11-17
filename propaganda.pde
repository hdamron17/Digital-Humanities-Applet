int i = 0;
int pos = 0;
PGraphics frame, bkground;
PFont fontA;

Snake s;
GravBox[] b;

color
  white = color(255),
  dark = color(40),
  lblue = color(224,236,255),
  blue = color(100, 150, 220);

void setup() {
//  size(0.9 * window.innerWidth, 0.9 * window.innerHeight);
  size(1200, 720);
  fill(white);
  fontA = loadFont("courier", 16);
  textFont(fontA);
  textAlign(CENTER, TOP);
  frameRate(10);

  bkground = createGraphics(width, height);
  drawBackground(bkground);

  frame = createGraphics(width, height);
  drawFrame(frame);

  s = new Snake();

  b = new GravBox[] {
    new GravBox(4, 200, 60, "The meeting point of math and language arts"),
    new GravBox(240, 160, 40, "Every program tells a story"),
    new GravBox(415, 200, 60, "Express yourself through computer programming"),
    new GravBox(650, 300, 40, "A modern means for creativity"),
    new GravBox(960, 200, 20, "Computing is cool!")
  };
}

void mousePressed() {
  link("https://github.com/hdamron17/Digital-Humanities-Applet", "_new"); 
}

void drawBackground(PGraphics bg) {
  bg.beginDraw();
  bg.fill(lblue);
  bg.rect(0, 0, width, height);
  bg.endDraw();
}

void drawFrame(PGraphics f) {
  f.beginDraw();
  f.textFont(fontA);
  f.textAlign(CENTER, TOP);
  f.fill(blue);
  pos = 0.08 * height;
  f.rect(0,0,width, pos + 80);
  f.fill(white);
  f.textFont(fontA, 30);
  f.text("Learn to Code - Learn to Think", width/2, pos);
  pos += 30;
  f.textFont(fontA, 18);
  f.text("Because computer programming isn't so different after all", width/2, pos);
  pos += 20;
  f.textFont(fontA, 14);
  f.text("Hunter Damron", width/2, pos);
  pos += 30;
  f.textFont(fontA, 16);
  f.textAlign(BOTTOM, RIGHT);
  f.text("Click anywhere to see program source code", 2, height-24);
  f.text("Created by Hunter Damron using Processing.js for ENGL 102 with Dr. Rule at the University of South Carolina", 2, height-6);
  f.endDraw();
}

void draw() {
  image(bkground, 0, 0);
  image(frame, 0, 0);
  fill(dark);
//  text("" + i, 0.5*width, pos + 10);
  ++i;
  s.drawSnake();
  s.incSnake();

  for (GravBox box : b) {
    box.drawBox();
    box.incBox();
    box.incColor();
  }
}

class GravBox {
  private static final double G = 0.8;
  private static final int FS = 16;
  private int x,y;
  private int sizex, sizey;
  private color c;
  private String t;
  private double v;
  private int ch;

  GravBox(int x, int sizex, int sizey, String t) {
    pushMatrix();
    textSize(FS);
    this.x = x;
    this.y = random(height - pos - sizey - 20) + sizey + 20;
    this.sizex = sizex;
    this.sizey = sizey;
    colorMode(HSB, 360, 100, 100);
    this.ch = random(360);
    this.c = color(this.ch, 100, 100, 255);
    this.t = t;
    this.v = 0;
    popMatrix();
  }

  void drawBox() {
    pushMatrix();
    textFont(fontA);
    textSize(FS);
    textAlign(CENTER, TOP);
    fill(c);
    rect(x, height - y, sizex, sizey);
    fill(dark);
    text(t, x, height - y, sizex, sizey);
    popMatrix();
  }

  void incBox() {
    double eloss = 0.96;
    if (mouseX >= x && mouseX <= x + sizex
        && mouseY >= height - y && mouseY <= height - y + sizey) {
      v = eloss * abs(v);
    } else if (y <= sizey) {
      v = eloss * abs(v);
    }
    y += v;
    v -= G;
  }

  void incColor() {
    this.ch = (this.ch + random(2)) % 360;
    this.c = color(this.ch, 100, 100, 255);
  }
}

class Snake {
  private static final int N = 10;
  private static final double SP = 0.6;
  private int[] x, y;
  private int size;
  private color c;

  Snake(int x, int y, int size, color col) {
    this.x = new int[N];
    this.y = new int[N];
    for (int i = 0; i < N; ++i) {
      this.x[i] = x;
      this.y[i] = y;
    }
    this.size = size;
    this.c = col;
  }

  Snake(int size) {
    this(mouseX, mouseY, size, color(random(255), random(255), random(255)));
  }

  Snake() {
    this(10);
  }

  void drawSnake() {
    pushMatrix();
    int alph = 255;
    for (int i = 0; i < N; ++i) {
      fill(color(c, alph));
      noStroke();
      ellipse(x[i], y[i], size, size);
      alph -= 255 / N;
    }
    popMatrix();
  }

  void incSnake() {
    for (int i = 1; i < N; ++i) {
      x[i] = x[i] + SP * (x[i-1] - x[i]);
      y[i] = y[i] + SP * (y[i-1] - y[i]);
    }
    x[0] = x[0] + SP * (mouseX - x[0]);
    y[0] = y[0] + SP * (mouseY - y[0]);
  }
}
