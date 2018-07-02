class BlindGnome extends Gnome {
  
  BlindGnome(ForestSpace s) {
    super(s);
  }
  
  // At the start, the BlindGnome picks a random shade of purple.
  // Over time, its green content depends on how much food it is carrying.
  
  void updateAppearance() {
    if(red==-1) red = int(random(200))+0;
    if(contents!=null) {
      if(contents.type==MaterialType.FOOD) green=contents.quantity;
    }
    if(blue == -1) blue = int(random(160))+60;
  }

  //  As everyone knows, gnomes jiggle()
  //  This is where the gnome's movement and interaction with the environment come from.
  
  void jiggle() {
    HashSet<ForestSpace> neighbours = forest.getNeighbours(position);  // Ask the forest for a list of valid neighbours.
    HashSet<ForestSpace> open = new HashSet<ForestSpace>();            // Create a list for open spaces
    for(ForestSpace neighbour : neighbours) {                          // Java "for every forestspace (called neighbour) in the set called neighbours:"
      if(neighbour.occupant==null) open.add(neighbour);
      else {
        if(neighbour.occupant instanceof House) giveMaterial(neighbour.occupant);
      }
    }
    // Pick a random number up to the length of the list of available spaces.
    int target = int(random(open.size()));    
    // Count through all of the open neighbours,
    // when you hit the lucky number, move to it.
    int i = 0;
    for(ForestSpace neighbour : open) {   
      if(i==target) {
        moveTo(neighbour);
      }
      i++;
    }
    if(position.contents!=null) {
      if(contents.type==MaterialType.FOOD) {
        grabContents();
        updateAppearance();
      }
    }
  }
}
