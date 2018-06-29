abstract class Occupier {
  
  int red;
  int green;
  int blue;

  int capacity;
  ForestSpace position;
  Material contents;
  abstract void updateAppearance();
}
