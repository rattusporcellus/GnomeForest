class BlindGnome extends Gnome {
  
  BlindGnome(ForestSpace s) {
    super(s);
  }
  
  void gnomeStats() {
    contents = new Material(MaterialType.FOOD,0);
    grabAmount = 20;
    capacity = 250;
  }
  
  void updateAppearance() {
    if(red==-1) red = int(random(200))+0;
    if(contents!=null) {
      if(contents.type==MaterialType.FOOD) green=contents.quantity;
    }
    if(blue == -1) blue = int(random(160))+60;
  }

  void jiggle() {
    HashSet<ForestSpace> neighbours = forest.getNeighbours(position);
    HashSet<ForestSpace> open = new HashSet<ForestSpace>();
    for(ForestSpace neighbour : neighbours) {
      if(neighbour.occupant==null) open.add(neighbour);
      else {
        if(neighbour.occupant instanceof House) giveMaterial(neighbour.occupant);
      }
    }
    int i = 0;
    int target = int(random(open.size()));
    for(ForestSpace neighbour : open) {
      if(i==target) {
        moveTo(neighbour);
      }
      i++;
    }
    if(position.contents!=null) {
      grabContents();
      if(contents.type==MaterialType.FOOD) {
        updateAppearance();
      }
    }
  }
}
