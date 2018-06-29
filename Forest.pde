import java.util.HashSet;

class Forest {
  
  private ForestSpace[][] spaces;
  private int height;
  private int width;
  
  public Forest(int x, int y) {
    width = x;
    height = y;
    spaces = new ForestSpace[width][height];
    for(int xScan = 0; xScan < width; xScan++) {
      for(int yScan = 0; yScan < height; yScan++) {
        spaces[xScan][yScan] = new ForestSpace(xScan,yScan);
      }
    }
  }
  
  ForestSpace randomPosition() {
    int x = int(random(width));
    int y = int(random(height));
    return spaces[x][y];
  }
  
  ForestSpace getSpace(int x, int y) {
    if(x<0||y<0||x>=width||y>=height) return null;
    else return spaces[x][y];
  }
  
  HashSet<ForestSpace> getNeighbours(ForestSpace position) {
    HashSet<ForestSpace> neighbours = new HashSet<ForestSpace>();
    // left
    if(position.xPos>0) neighbours.add(spaces[position.xPos-1][position.yPos]);
    // upper left
    if(position.xPos>0 && position.yPos>0) neighbours.add(spaces[position.xPos-1][position.yPos-1]);
    // top
    if(position.yPos>0) neighbours.add(spaces[position.xPos][position.yPos-1]);
    // top right
    if(position.yPos>0 && position.xPos < width-1) neighbours.add(spaces[position.xPos+1][position.yPos-1]);
    // right
    if(position.xPos < width-1) neighbours.add(spaces[position.xPos+1][position.yPos]);
    // bottom right
    if(position.xPos < width-1 && position.yPos < height-1) neighbours.add(spaces[position.xPos+1][position.yPos+1]);
    // bottom
    if(position.yPos < height-1) neighbours.add(spaces[position.xPos][position.yPos+1]);
    // bottom left
    if(position.xPos > 0 && position.yPos < height-1) neighbours.add(spaces[position.xPos-1][position.yPos+1]);
    return neighbours;
  }
  

}
