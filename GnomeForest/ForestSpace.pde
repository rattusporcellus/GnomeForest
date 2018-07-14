class ForestSpace {
  
  //  A ForestSpace is a single cell of the map.  It can have an occupant and/or a material.
  
  Occupier occupant = null;  // An animal, a gnome, a building, etc.
  Material contents = null;  // Food or other  
  
  int xPos;  // x index on Forest.spaces, so varies from 0 to the width of the map minus one.
  int yPos;  // ditto
  
  public ForestSpace(int x, int y) {
    xPos = x;
    yPos =  y;
  }
  
}
