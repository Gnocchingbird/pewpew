int starPosition = 0; // zum Bewegen der Sterne
int pX;  //player position
int pY;
PImage flame1;         // visual element
PImage flame2;
boolean flame_mode = false; //visual perk

void setup() {
  size(1024,700);
  flame1 = loadImage("flame.png");  // Load the image into the program  
  flame2 = loadImage("flame_rev.png");
  

}

void draw() {
  if(starPosition % 100 == 0){
    if(flame_mode){
      flame_mode = false;
    }
    else{
      flame_mode = true;
    }
  }
  starPosition += 5;
  background (30);
   
  //stars
  stroke(240);
  fill(255);
  ellipse(266, (starPosition + 75) % 700, 3, 3);
  ellipse(965, (starPosition + 483) % 700, 3, 3);
  ellipse(685, (starPosition + 473) % 700, 3, 3);
  ellipse(356, (starPosition + 119) % 700, 3, 3);
  ellipse(928, (starPosition + 91) % 700, 3, 3);
  ellipse(430, (starPosition + 349) % 700, 3, 3);
  ellipse(85, (starPosition + 293) % 700, 3, 3);
  ellipse(33, (starPosition + 645) % 700, 3, 3);
  ellipse(866, (starPosition + 583) % 700, 3, 3);
  ellipse(175, (starPosition + 587) % 700, 3, 3);
  ellipse(838, (starPosition + 400) % 700, 3, 3);
  ellipse(31, (starPosition + 8) % 700, 3, 3);
  ellipse(925, (starPosition + 275) % 700, 3, 3);
  ellipse(582, (starPosition + 215) % 700, 3, 3);
  ellipse(827, (starPosition + 462) % 700, 3, 3);
  ellipse(782, (starPosition + 585) % 700, 3, 3);
  ellipse(124, (starPosition + 526) % 700, 3, 3);
  ellipse(291, (starPosition + 11) % 700, 3, 3);
  ellipse(916, (starPosition + 25) % 700, 3, 3);
  ellipse(744, (starPosition + 135) % 700, 3, 3);
  
  //player
  pX = mouseX;
  pY = mouseY;
  stroke (0,0,200);
  fill (13,57,96);
  ellipse (pX,pY- 10,24,30);
  rect (pX - 12,pY - 10,24,40);
  triangle (pX - 12,pY + 20, pX - 12, pY, pX-32, pY + 20);
  triangle (pX + 12,pY + 20, pX + 12, pY, pX+32, pY + 20);
  if(flame_mode){
    image(flame2, pX - 12, pY + 30);
    image(flame1, pX, pY + 30);
  }
  else{
    image(flame1, pX - 12, pY + 30);
    image(flame2, pX, pY + 30);
  }
  
  //player bullet
  fill (100,100,230);
  ellipse (5,300,5,10);
  
  //enemy
  stroke (200,0,0);
  fill (100,30,75);
  triangle (800,100,830,100, 815, 115);
  
  //enemy bullet
  fill(255,0,0);
  ellipse (0,300,5,10);
  
  
  
}
