class BlindGnome extends Gnome {
  

  
  BlindGnome() {
    super();
  }
  
  BlindGnome(int x, int y) {
    super(x,y);
  }
  
  BlindGnome(ForestSpace s) {
    super(s);
  }
  
  void gnomeStats() {
    contents = new Material(MaterialType.FOOD,0);
    grabAmount = 20;
    capacity = 250;
  }
  
  void gnomeColour() {
    red = int(random(100))+0;
    updateAppearance();
    blue = int(random(100))+60;
  }
  
  void updateAppearance() {
    green = 20;
    if(contents!=null) {
      if(contents.type==MaterialType.FOOD) {
        green+=contents.quantity;
      }
    }
  }

  void jiggle() {
    if(position==null) gnomeList.remove(this);
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
      if(i==target && neighbour.occupant==null) {
        position.occupant = null;
        position = neighbour;
        position.occupant = this;
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
