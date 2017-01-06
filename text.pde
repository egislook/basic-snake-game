class Txt{
  float x, y, size;
  String str;
  int alpha = 255;
  color clr;
  PFont zigBlack;
  
  Txt(float x, float y, int size, String str, color clr){
    this.x = x;
    this.y = y;
    this.str = str;
    this.clr = clr;
    this.size = size;
  }
  
  Txt(int x, int y, int gridSize, String str, color clr){
    this.x = x * gridSize + gridSize/3;
    this.y = y * gridSize + gridSize/1.5;
    this.size = gridSize;
    this.str = str;
    this.clr = clr;
    zigBlack = createFont("Ziggurat-Black", 40);
    textFont(zigBlack);
  }
  
  boolean isDone(){
    return this.alpha <= 0;
  }
  
  void show(){
    fill(color(this.clr), alpha);
    textSize(this.size);
    textAlign(CENTER, CENTER);
    text(this.str, this.x, this.y);
    this.y -= 0.75;
    this.alpha -= 2;
    this.size += 0.2;
  }
}