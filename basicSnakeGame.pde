Snake snake;
ArrayList<Food> foods = new ArrayList<Food>();
ArrayList<Txt> texts = new ArrayList<Txt>();

int level = 0;
int stage = 0;
int hardness = 0;
int upPick = 1;
int[] sizes = {80, 75, 70, 60, 50, 40, 30, 20, 18, 17, 15, 14, 13, 12, 11, 10};
int iniSize = sizes[0];
int iniSpeed = sizes.length - level;
int rows = width/iniSize;
int cols = height/iniSize;

void setup(){
  //size(600, 600, P2D);
  fullScreen(P2D);
  //smooth();
  texts.add(0, new Txt(width/2, height/2, iniSize, "Lets start!!!", color(255)));
  snake = new Snake(iniSize, rows, cols);
  zoomOut(level);
  for(int i = 0; i <= level+1; i++){
    foods.add(0, new Food(iniSize, rows, cols, level));
  }
}

void zoomOut(int lvl){
  iniSize = sizes[lvl];
  rows = floor(width/iniSize);
  cols = floor(height/iniSize);
  
  snake.zoomOut(iniSize, rows, cols);
  for(Food food : foods){
    food.zoomOut(iniSize, rows, cols);
  }
}

void draw(){
  
    background(50);
    //drawing grid
    stroke(40);
    for(int i = 0; i < rows; i++) line(i * iniSize, 0, i * iniSize, cols * iniSize);
    for(int i = 0; i < cols; i++) line(0, i * iniSize, rows * iniSize, i * iniSize);
    
    for(int i = 0; i < foods.size(); i++){
      Food food = foods.get(i);
      if(snake.eat(food)){
        levelUp();
        texts.add(0, new Txt(snake.x, snake.y, iniSize, str(hardness), food.clr));
        food.respawn(level);
      }
      if(frameCount % iniSpeed*3 == 0 && level > sizes.length-1){
        food.move(0, 0);
      }
      //food.move();
      food.show();
    }
    
    if(frameCount % iniSpeed == 0){
      snake.updateLocation();
    }
    
    snake.show();
    
    if(texts.size() > 0){
      for(int i = texts.size()-1; i >= 0; i--){
         Txt text = texts.get(i);
         text.show();
         
         if(text.isDone()){
           texts.remove(i);
         }
      }
    }
  
  
  //for(int i = 0; i < rows; i++){
  //  for(int j = 0; j < rows; j++){
  //    rect(i*iniSize, j*iniSize, i*iniSize + iniSize, j*iniSize + iniSize);
  //  }
  //}
  
}

void levelUp(){
  
  hardness++;
  upPick--;
  
  if(upPick == 0){
    level++;
    upPick = stage + 1;
    if(level / sizes.length == 1){
      level = stage < sizes.length ? stage : sizes.length-1;
      iniSpeed = ((sizes.length - level) / 2) + 1;
      stage++;
      upPick++;
    }
    
    if(level != sizes.length -1){
      for(int i = 0; i <= int(stage/3)+1; i++){
        foods.add(0, new Food(iniSize, rows, cols, level));
      }
    }
    zoomOut(level);
    
    if(iniSpeed > 1) iniSpeed -= 0.5;
    
    println("level =>", level, "stage =>", stage, "upPick =>", upPick, "speed =>", iniSpeed);
  }
}

void keyPressed(){
  levelUp();
}

void mousePressed(){
  snake.control(mouseX, mouseY);
}