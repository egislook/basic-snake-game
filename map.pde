class Engine{
  
  int rows, cols, baseSize;
  
  Engine(int baseSize){
    this.baseSize = baseSize;
    this.rows = floor(width/this.baseSize);
    this.cols = floor(height/this.baseSize);
  }
  
}