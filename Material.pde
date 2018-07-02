class Material {
  MaterialType type;
  int quantity;
  
  public Material() {
    type = MaterialType.FOOD;
    quantity = 50;
  }
  
  public Material(MaterialType type, int quantity) {
    this.type = type;
    this.quantity = quantity;
  }

}

enum MaterialType {
  FLAG_NORTH(150,50,50),
  FLAG_NORTHEAST(150,50,50),
  FLAG_EAST(150,50,50),
  FLAG_SOUTHEAST(150,50,50),
  FLAG_SOUTH(150,50,50),
  FLAG_SOUTHWEST(150,50,50),
  FLAG_WEST(150,50,50),
  FLAG_NORTHWEST(150,50,50),
  FOOD(40,180,30);
  
  public final int red;
  public final int green;
  public final int blue;
  
  private MaterialType(int r, int g, int b) {
    red = r;
    green = g;
    blue = b;
  }
}
