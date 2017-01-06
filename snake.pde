class Snake {
  int baseSize, baseSpeed, xSpeed, ySpeed;
  int rows, cols;
  int x = 1;
  int y = 0;
  ArrayList<PVector> parts = new ArrayList<PVector>();
  
  Snake(int size, int rows, int cols) {
    this.baseSize = size;
    this.xSpeed = 1;
    this.baseSpeed = 1;
    this.ySpeed = 0;
    this.rows = rows;
    this.cols = cols;
    this.x = (int)random(0, this.rows);
    this.y = (int)random(0, this.cols);
    parts.add(0, new PVector(this.x-1, this.y));
    
  }
  
  void zoomOut(int size, int rows, int cols){
    int rowsDif = floor((rows - this.rows)/2);
    int colsDif = floor((cols - this.cols)/2);
    this.x = this.x + rowsDif;
    this.y = this.y + colsDif;
    for(PVector peace : parts){
      peace.x = peace.x + rowsDif;
      peace.y = peace.y + colsDif;
    }
    this.baseSize = size;
    this.rows = rows;
    this.cols = cols;
  }
  
  void control(float mx, float my){
    if(this.xSpeed == 0){
      this.xSpeed = mx > x * baseSize 
        ? 1 * this.baseSpeed 
        : -1 * this.baseSpeed;
      this.ySpeed = 0;
    } else if(this.ySpeed == 0){
      this.ySpeed = my > y * baseSize 
        ? 1 * this.baseSpeed 
        : -1 * this.baseSpeed;
      xSpeed = 0;
    }
  }
  
  boolean eat(Food food){
    float range = dist(food.x, food.y, this.x, this.y);
    if(range < 1 * food.overGrow){
      parts.add(new PVector(this.x, this.y));
      return true;
    } else if(range <= food.sense){
      //println(food.sense, food.stamina);
      food.move(xSpeed, ySpeed);
    }
    return false;
  }
  
  void updateLocation(){
    if(parts.size() > 0){
      parts.add(0, new PVector(this.x, this.y));
      parts.remove(parts.size()-1);
    }
    
    if(this.x + this.xSpeed >= this.rows){
      this.x = 0;
    } else if(this.x + this.xSpeed < 0){
      this.x = rows - this.baseSpeed;
    } else {
      this.x = this.x + this.xSpeed;
    }
    
    if(this.y + this.ySpeed >= this.cols){
      this.y = 0;
    } else if(this.y + this.ySpeed < 0){
      this.y = cols - this.baseSpeed;
    } else{
      this.y = this.y + this.ySpeed;
    }
    
  }
  
  void show(){
    fill(255, 255, 255, 100);
    for(PVector peace : parts){
      rect(peace.x * this.baseSize, peace.y * this.baseSize, this.baseSize, this.baseSize);
    }
    fill(255);
    rect(this.x * this.baseSize, this.y * this.baseSize, this.baseSize, this.baseSize);
  }
}