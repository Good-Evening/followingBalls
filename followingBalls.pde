ArrayList<Circle> al;
int screenState = 0;  // 0 = start screen
                      // 1 = circles screen
                      // 2 = instructions

class Circle {
  float x;
  float y;
  float r;

  Circle(float sx, float sy, float sr) {
    x = sx;
    y = sy;
    r = sr;
  }
}

void setup() {
  size(600, 600);

  al = new ArrayList<Circle>();

  Circle firstCircle = new Circle(255, 77, 166);
  al.add(firstCircle);
}

void draw() {
  if (screenState == 0) {
    openingScreen();
  } else if (screenState == 1) {
    circleState();
  } else if (screenState == 2) {
    instructionsScreen();
  }
}

void openingScreen() {
  background(255);

  fill(0);
  textSize(25);
  textAlign(CENTER, CENTER); // centers text vertically and horizontally
  text("following ducks demo", width / 2, height / 2);
  // text 3 inputs:  String to display, x, y
}

void instructionsScreen() {
  background(255);
  fill(0);

  textSize(24);
  text("Press space to start and click to make circles.", width/2, 100);
}

void circleState() {
  background(51);

  moveCircles();
  drawCircles();
}

void moveCircles() {
  for (int i = 1; i < al.size(); i++) {
    Circle toFollow = al.get(i-1);
    Circle toMove = al.get(i);
    float dx = toFollow.x - toMove.x;
    float dy = toFollow.y - toMove.y;
    toMove.x += dx / 20;
    toMove.y += dy / 20;
  }
}

void drawCircles() {
  for (int i = 0; i < al.size(); i++) {
    Circle c = al.get(i);
    drawCircle(c);
  }
}

void drawCircle(Circle c) {
  ellipse(c.x, c.y, c.r, c.r);
}


void mousePressed() {
  if (screenState == 1) {
    noStroke();
    fill(255, 77, 166);
    Circle nextCircle = new Circle(mouseX, mouseY, 15);
    al.add(nextCircle);
  }
}

void keyPressed() {
  // single characters use single quotes
  // key is a built in char variable set equal to the last key
  // that was pressed OR released
  if (key == ' ' && screenState == 0) {
    screenState = 1; // switch from start scrn to circle scrn
  } else if (key == 'i' && screenState == 0) {
    screenState = 2;  // switch from start to instructions
  } else if (key == ' ' && screenState == 2) {
    screenState = 1; // switch from the instructions to circles
  }
}
