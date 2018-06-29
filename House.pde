class House extends Occupier { //<>//

  public House(int x, int y) {
    ForestSpace target = forest.getSpace(x, y);
    if (target==null) {
      houseList.remove(this);
    } else if (target.occupant!=null&&target.occupant!=this) {
      houseList.remove(this);
    } else {
      target.occupant=this;
      position=target;
      contents = new Material(MaterialType.FOOD, 0);
      capacity = 500;
      red = 0;
      updateAppearance();
      blue = 0;
    }
  }

  void updateAppearance() {
    green=int(255*contents.quantity/capacity);
  }

  int counter=0;
  void shudder() {
    if(gnomeList.size() < GF.gnomeLimit) {
    counter++;
    if (counter==5) {
      HashSet<ForestSpace> neighbours = forest.getNeighbours(position);
      int target = int(random(neighbours.size()));
      int i=0;
      for (ForestSpace neighbour : neighbours) {
        if (i==target&&neighbour.occupant==null) {
          gnomeList.add(new BlindGnome(neighbour));
        }
        i++;
      }
      counter=0;
    }
    }
  }
}
