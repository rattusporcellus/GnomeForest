abstract class Occupier {
  
  ForestSpace position;
  Material contents;
  int capacity;
  int red = -1;
  int green = -1;
  int blue = -1;


  boolean spawn() {
    if(position==null) return false;
    if(position.occupant==null||position.occupant==this) {
      position.occupant=this;
      updateAppearance();
      return true;
    }
    else {
      position = null;
      return false;
    }
  }
  
  abstract void updateAppearance();
  
}
