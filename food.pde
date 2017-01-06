class Food{
  int rows, cols;
  int baseSize;
  int x = 0;
  int y = 0;
  color clr;
  boolean isMoving = false;
  int stamina = 10;
  int sense = 2;
  int overGrow = 1;
  
  Food(){}
  
  Food(int size, int rows, int cols, int level){
    this.baseSize = size;
    this.rows = rows;
    this.cols = cols;
    this.respawn(level);
  }
  
  void respawn(int level){
    if(level > 3){
      //this.isMoving = (int)random(2) > 0 ? true : false;
      this.isMoving = true;
      if((int)random(2) > 0) this.overGrow = (int)random(2, 3);
      //this.stamina = (int)random(5, hardness);
      //this.sense = (int)random(3, hardness);
    }
    this.updateLocation();
  }
  
  void zoomOut(int size, int rows, int cols){
    int rowsDif = floor((rows - this.rows)/2);
    int colsDif = floor((cols - this.cols)/2);
    this.x = this.x + rowsDif;
    this.y = this.y + colsDif;
    this.baseSize = size;
    this.rows = rows;
    this.cols = cols;
  }
  
  void move(int xSnakeSpeed, int ySnakeSpeed){
    if(this.isMoving){
      if(ySnakeSpeed != 0 || xSnakeSpeed != 0) { stamina--; }
      int moveState = (int)random(4);
      //println(moveState);
      switch(moveState){
        case 1:
          int xMove = (int)random(2) * 2 - 1;
          this.x += xMove;
          if(this.x < 0){
            this.x = this.x * -1;
          } else if(this.x > cols){
            this.x--;
          }
        break;
        case 2:
          int yMove = (int)random(2) * 2 - 1;
          this.y += yMove;
          if(this.y < 0){
            this.y = this.y * -1;
          } else if(this.y > rows){
            this.y--;
          }
          
        break;
        default:
        break;
      }
      
    }
  }
  
  void updateLocation(){
    this.x = (int)random(0, this.rows);
    this.y = (int)random(0, this.cols);
    this.clr = color(random(100,255),random(100,255),random(100,255));
  }
  
  void show(){
    fill(this.clr, 100);
    rect(this.x * this.baseSize, this.y * this.baseSize, this.baseSize * this.overGrow, this.baseSize * this.overGrow);
  }
}