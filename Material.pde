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
  FOOD, FLAG
}
