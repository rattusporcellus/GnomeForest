class House extends Occupier { //<>//

  int foodForSpawn = 500;
  int spawnDelay = 15;

  public House(int x, int y) {
    this(forest.getSpace(x, y));
  }

  public House(ForestSpace target) {
    if (target!=null) {
      position = target;
      capacity=3000;
      contents = new Material(MaterialType.FOOD, 3000);
      spawn();
    }
  }

  void updateAppearance() {
    if (red == -1) red = 0;
    green = contents.quantity;
    green = int(255*contents.quantity/foodForSpawn);
    if (blue==-1) blue = 0;
  }

  int counter=0;

  void shudder() {
    counter++;
    if (counter==10) {
      if (forest.gnomeList.size() < GF.gnomeLimit) {
        if (contents.quantity>=foodForSpawn) {
          HashSet<ForestSpace> neighbours = forest.getNeighbours(position);
          int target = int(random(neighbours.size()));
          int i=0;
          for (ForestSpace neighbour : neighbours) {
            if (i==target&&neighbour.occupant==null) {
              if (forest.addGnome(neighbour)) {
                contents.quantity -= foodForSpawn;
                updateAppearance();
              }
            }
            i++;
          }
        }
      }
      counter = 0;
    }
  }
}
