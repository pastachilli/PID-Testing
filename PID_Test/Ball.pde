class Ball {
  private int x;
  private int y;
  int mass;
  
  float xMomentum;
  float yMomentum;
  
  public Ball(int x, int y, int mass) {
    this.x = x;
    this.y = y;
    this.mass = mass;
    this.xMomentum = 0;
    this.yMomentum = 0;
  }
  
  public int[] move(float xForce, float yForce) {
    
    xMomentum = xMomentum + (xForce / mass);
    yMomentum = yMomentum + (yForce / mass);
    
    x = (int) (x + xMomentum);
    y = (int) (y + yMomentum);
    
    int[] output = {x, y};
    return output;
    
  }
  
  public int getX() {
    return x;
  }
  
  public int getY() {
    return y;
  }
  
}
