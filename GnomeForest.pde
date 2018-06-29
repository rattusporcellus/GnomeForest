import java.util.LinkedList;

public static GnomeForest GF;

Forest forest;
private LinkedList<Gnome> gnomeList;
private LinkedList<House> houseList;

// Configuration
int frameDelay = 20;         //  How long a delay to put between frames
int speedIncrement = 20;     //  How many miliseconds the speed is adjusted by per key press
final int gridSpacing = 40;  //  How widely spaced the map spaces are
final int gnomeCirc = 30;    //  Diameter of a gnome on the map
final int foodCirc = 8;      //  Diameter of a food particle
final int forestWidth = 9;   //  Number of columns  (Note: highest array index will be forestWidth-1)
final int forestHeight = 9;  //  Number of rows

int startingFood = 50;
int gnomeLimit = 4;

void setup() {
  // Initialising the instance
  GF = this;
  forest = new Forest(forestWidth,forestHeight);
  gnomeList = new LinkedList<Gnome>();
  houseList = new LinkedList<House>();
  
  // Drawing the map
  houseList.add(new House(int(forestWidth/2),int(forestHeight/2)));
  //houseList.add(new House(int(floor(width/2)),int(floor(height/2))));
  int c = 0;
  while(c<startingFood) {
    ForestSpace x = forest.randomPosition();
    if(x.occupant==null) x.contents = new Material(MaterialType.FOOD,100);
    c++;
  }
}

void settings() {
    size(forestWidth*gridSpacing+2,forestHeight*gridSpacing+2);
}

boolean laterOn = false;

void draw() {
  
  //
  // Activate the Gnomes!  Ideally this would be moved to a separate thread.
  //

  for(Gnome g: gnomeList) g.jiggle();
  for(House h: houseList) h.shudder();  
  
  //
  // Drawing
  //
  
  background(0,0,0);
  for(int a = 0; a < forestWidth; a++) {
    for(int b = 0; b < forestHeight; b++) {
      ForestSpace drawing = forest.spaces[a][b];
      if(drawing == null) fill(255,0,0);
      else {
        int offsetX = drawing.xPos*gridSpacing;
        int offsetY = drawing.yPos*gridSpacing;
        
        fill(206,202,80);
        stroke(200,220,180);
        rect(offsetX,
          offsetY,
          gridSpacing,
          gridSpacing);
          
        if(drawing.contents!=null) {
          if(drawing.contents.type.equals(MaterialType.FOOD)) {
            fill(10,180,60);
            stroke(0,0,0);
            ellipse(offsetX+0.25*gridSpacing,offsetY+0.25*gridSpacing,foodCirc,foodCirc);
            if(drawing.contents.quantity>20) ellipse(offsetX+0.75*gridSpacing,offsetY+0.25*gridSpacing,foodCirc,foodCirc);
            if(drawing.contents.quantity>40) ellipse(offsetX+0.25*gridSpacing,offsetY+0.75*gridSpacing,foodCirc,foodCirc);
            if(drawing.contents.quantity>60) ellipse(offsetX+0.75*gridSpacing,offsetY+0.75*gridSpacing,foodCirc,foodCirc);
            if(drawing.contents.quantity>80) ellipse(offsetX+0.5*gridSpacing,offsetY+0.5*gridSpacing,foodCirc,foodCirc);
          }
        }
        if(drawing.occupant!=null) {
          if(drawing.occupant instanceof Gnome) {
            fill(drawing.occupant.red,drawing.occupant.green,drawing.occupant.blue);
            stroke(0,0,0); 
            ellipse(offsetX+gridSpacing/2,
                  offsetY+gridSpacing/2,
                  gnomeCirc,
                  gnomeCirc);
          }
          else if(drawing.occupant instanceof House) {
            fill(drawing.occupant.red,drawing.occupant.green,drawing.occupant.blue);
            stroke(0,0,0,0);
            rect(offsetX+gridSpacing*.2,offsetY+gridSpacing*.2,gridSpacing*.6,gridSpacing*.6);
          }
        }
      }
    }
  }
  if(laterOn) delay(frameDelay);
  else laterOn = true;
}

void keyPressed() {
  switch(key) {
    case '+':
      increaseSpeed();
      break;
    case '-':
      decreaseSpeed();
      break;
  }
}

void increaseSpeed() {
  if(frameDelay>0) {
    
  }
}

void decreaseSpeed() {
  if(frameDelay) {
  }
}
boolean addGnome(Gnome gnome) {
  gnomeList.add(gnome);
  return(gnomeList.contains(gnome));
}
