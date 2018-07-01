import java.util.LinkedList;

// Display Configuration
int frameDelay = 500;       //  How long a delay to put between frames
int speedIncrement = 20;     //  How many miliseconds the speed is adjusted by per key press
final int gridSpacing = 20;  //  How widely spaced the map spaces are
final int gnomeCirc = 16;    //  Diameter of a gnome on the map
final int foodCirc = 3;      //  Diameter of a food particle

// Map setup and control
final int forestWidth = 60;   //  Number of columns  (Note: highest array index will be forestWidth-1)
final int forestHeight = 30;  //  Number of rows
int startingFood = 1000;
int gnomeLimit = 200;

// Program Initialisation
public static GnomeForest GF;
public final Forest forest = new Forest(int(forestWidth), int(forestHeight));

void setup() {
  // Initialising the instance
  GF = this;

  // Drawing the map
  forest.addHouse(new House(forest.getSpace(int(forestWidth/2), int(forestHeight/2))));
  int c = 0;
  while (c<startingFood) {
    ForestSpace x = forest.randomPosition();
    if (x.occupant==null) x.contents = new Material(MaterialType.FOOD, 100);
    c++;
  }
}

void settings() {
  size(forestWidth*gridSpacing+2, forestHeight*gridSpacing+2);
}

void draw() {

  //
  // Activate the Gnomes!  Ideally this would be moved to a separate thread.
  //

  forest.activate();

  //
  // Drawing
  //

  background(0, 0, 0);
  for (int a = 0; a < forestWidth; a++) {
    for (int b = 0; b < forestHeight; b++) {
      ForestSpace drawing = forest.getSpace(a, b);
      if (drawing !=null) {
        int offsetX = drawing.xPos*gridSpacing;
        int offsetY = drawing.yPos*gridSpacing;

        fill(206, 202, 80);
        stroke(200, 220, 180);
        rect(offsetX, 
          offsetY, 
          gridSpacing, 
          gridSpacing);

        if (drawing.contents!=null) {
          if (drawing.contents.type.equals(MaterialType.FOOD)) {
            fill(10, 180, 60);
            stroke(0, 0, 0);
            ellipse(offsetX+0.25*gridSpacing, offsetY+0.25*gridSpacing, foodCirc, foodCirc);
            if (drawing.contents.quantity>20) ellipse(offsetX+0.75*gridSpacing, offsetY+0.25*gridSpacing, foodCirc, foodCirc);
            if (drawing.contents.quantity>40) ellipse(offsetX+0.25*gridSpacing, offsetY+0.75*gridSpacing, foodCirc, foodCirc);
            if (drawing.contents.quantity>60) ellipse(offsetX+0.75*gridSpacing, offsetY+0.75*gridSpacing, foodCirc, foodCirc);
            if (drawing.contents.quantity>80) ellipse(offsetX+0.5*gridSpacing, offsetY+0.5*gridSpacing, foodCirc, foodCirc);
          }
        }
        if (drawing.occupant!=null) {
          if (drawing.occupant instanceof Gnome) {
            fill(drawing.occupant.red, drawing.occupant.green, drawing.occupant.blue);
            stroke(0, 0, 0);
            ellipse(offsetX+gridSpacing/2, 
              offsetY+gridSpacing/2, 
              gnomeCirc, 
              gnomeCirc);
          } else if (drawing.occupant instanceof House) {
            fill(drawing.occupant.red, drawing.occupant.green, drawing.occupant.blue);
            stroke(0, 0, 0);
            rect(offsetX+gridSpacing*.2, offsetY+gridSpacing*.2, gridSpacing*.6, gridSpacing*.6);
          }
        }
      }
    }
  }
  delay(frameDelay);
}

void keyPressed() {
  switch(key) {
  case '+':
    increaseSpeed();
    break;
  case '-':
    decreaseSpeed();
    break;
  default:
    println(key);
    break;
  }
}

void increaseSpeed() {
  frameDelay-=speedIncrement;
  if (frameDelay<0) frameDelay = 0;
  println("Frame delay is now "+frameDelay+" miliseconds per frame.");
}

void decreaseSpeed() {
  if (frameDelay<=2000) {
    frameDelay+=speedIncrement;
    println("Frame delay is now "+frameDelay+" miliseconds per frame.");
  }
}
