import java.util.LinkedList;

//
//  Configuration variables
//

// Display

int frameDelay = 100;         //  How long a delay to put between frames.  This is adjustable in-game.
int speedIncrement = 20;      //  How many miliseconds the speed is adjusted by per key press (+/-)
final int gridSpacing = 30;   //  How wide the map spaces are, in pixels.
final int gnomeCirc = 22;      //  Diameter of a gnome on the map
final int foodCirc = 4;       //  Diameter of a food particle

// Map setup and control

final int forestWidth = 20;    //  Number of columns  (Note: highest array index will be forestWidth-1)
final int forestHeight = 20;   //  Number of rows
int startingFood = 200;       //  How many times the program will try to spawn food on the map at startup
int gnomeLimit = 30;           //  The maximum number of gnomes that can be spawned

//
// Program variables
//

public static GnomeForest GF;
public Forest forest;
boolean running;

void setup() {
  // Initialising the instance
  GF = this;
  forest = new Forest(int(forestWidth), int(forestHeight));
  running = true;
  
  // Drawing the map
  forest.addHouse(forest.getSpace(int(forestWidth/2), int(forestHeight/2)));
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

  // Activate the Gnomes!  
  // Ideally this would be moved to a separate thread.
  // For now, it's handled through the Forest object.

  if(running) forest.activate();


  // Drawing

  background(0, 0, 0);
  for (int a = 0; a < forestWidth; a++) {
    for (int b = 0; b < forestHeight; b++) {
      ForestSpace drawing = forest.getSpace(a, b);
      if (drawing !=null) {
        int offsetX = drawing.xPos*gridSpacing;
        int offsetY = drawing.yPos*gridSpacing;
        //  Draw the actual grid space
        fill(206, 202, 80);
        stroke(200, 220, 180);
        rect(offsetX, 
          offsetY, 
          gridSpacing, 
          gridSpacing);
        // Draw any materials
        if (drawing.contents!=null) {
          fill(drawing.contents.type.red, drawing.contents.type.green, drawing.contents.type.blue);
          stroke(0, 0, 0);
          if (drawing.contents.type.equals(MaterialType.FOOD)) {
            ellipse(offsetX+0.25*gridSpacing, offsetY+0.25*gridSpacing, foodCirc, foodCirc);
            if (drawing.contents.quantity>20) {
              ellipse(offsetX+0.75*gridSpacing, offsetY+0.25*gridSpacing, foodCirc, foodCirc);
              if (drawing.contents.quantity>40) {
                ellipse(offsetX+0.25*gridSpacing, offsetY+0.75*gridSpacing, foodCirc, foodCirc);
                if (drawing.contents.quantity>60) {
                  ellipse(offsetX+0.75*gridSpacing, offsetY+0.75*gridSpacing, foodCirc, foodCirc);
                  if (drawing.contents.quantity>80) ellipse(offsetX+0.5*gridSpacing, offsetY+0.5*gridSpacing, foodCirc, foodCirc);
                }
              }
            }
          }
          if (drawing.contents.type.equals(MaterialType.FLAG_NORTHWEST)) {
            stroke(256,0,0);
            line(offsetX,offsetY,offsetX+0.5*gridSpacing,offsetY+0.5*gridSpacing);
          }
        }
        //  Draw any occupants
        if (drawing.occupant!=null) {
          fill(drawing.occupant.red, drawing.occupant.green, drawing.occupant.blue);
          stroke(0, 0, 0);
          if (drawing.occupant instanceof Gnome)
            ellipse(offsetX+gridSpacing/2, offsetY+gridSpacing/2, gnomeCirc, gnomeCirc);
          else if (drawing.occupant instanceof House)
            rect(offsetX+gridSpacing*.2, offsetY+gridSpacing*.2, gridSpacing*.6, gridSpacing*.6);
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
  case ' ':
    running = !running;
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
