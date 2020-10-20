int counter = 0; // variable for tracking the time
int pX;  //player position
int pY;
int maxPBullet = 20; // max number of player bullets
int currentBullet = 0;
int[] pBX = new int[maxPBullet]; //player bullet locations
int[] pBY = new int[maxPBullet];
int fireRate = 100; // time between shots (only multiples of 5)
int eventCounter, prevEventCounter; // makes various events occur (shot fired, fire animation...)

PImage flame1;         // visual element
PImage flame2;
boolean flame_mode = false; //visual perk

void setup() {
  size(1024,700);
  flame1 = loadImage("flame.png");  // Load the image into the program  
  flame2 = loadImage("flame_rev.png");
  

}

void draw() {
  
  counter += 300 / frameRate;
  background (30);
  fill(255);
  text(frameRate, 500, 400);
  text(counter, 500, 500);
  if(counter / 100 > eventCounter){
    eventCounter = counter / 100;
  }
  
  if(eventCounter != prevEventCounter){ //change mode from true to false, vice versa
    if(flame_mode){
      flame_mode = false;
    }
    else{
      flame_mode = true;
    }
  }
   
  //stars
  stroke(240);
  fill(255);
  /*for(int i = 0; i < 20; i++){
    int eX = int(random(0, 1025));
    int eY = int(random(0, 701));
    ellipse(eX, (counter + eY) % 700, 3, 3);
  }*/
  ellipse(266, (counter + 75) % 700, 3, 3);
  ellipse(965, (counter + 483) % 700, 3, 3);
  ellipse(685, (counter + 473) % 700, 3, 3);
  ellipse(356, (counter + 119) % 700, 3, 3);
  ellipse(928, (counter + 91) % 700, 3, 3);
  ellipse(430, (counter + 349) % 700, 3, 3);
  ellipse(85, (counter + 293) % 700, 3, 3);
  ellipse(33, (counter + 645) % 700, 3, 3);
  ellipse(866, (counter + 583) % 700, 3, 3);
  ellipse(175, (counter + 587) % 700, 3, 3);
  ellipse(838, (counter + 400) % 700, 3, 3);
  ellipse(31, (counter + 8) % 700, 3, 3);
  ellipse(925, (counter + 275) % 700, 3, 3);
  ellipse(582, (counter + 215) % 700, 3, 3);
  ellipse(827, (counter + 462) % 700, 3, 3);
  ellipse(782, (counter + 585) % 700, 3, 3);
  ellipse(124, (counter + 526) % 700, 3, 3);
  ellipse(291, (counter + 11) % 700, 3, 3);
  ellipse(916, (counter + 25) % 700, 3, 3);
  ellipse(744, (counter + 135) % 700, 3, 3);
  
  //player, relative to mouse position
  pX = mouseX;
  pY = mouseY;
  stroke (0,0,200);
  fill (180,180,200);
  ellipse (pX,pY- 10,24,30);
  rect (pX - 12,pY - 10,24,40);
  triangle (pX - 12,pY + 20, pX - 12, pY, pX-32, pY + 20);
  triangle (pX + 12,pY + 20, pX + 12, pY, pX+32, pY + 20);
  if(flame_mode){  //change displayed flame-image depending on flame_mode
    image(flame2, pX - 12, pY + 30);
    image(flame1, pX, pY + 30);
  }
  else{
    image(flame1, pX - 12, pY + 30);
    image(flame2, pX, pY + 30);
  }
  
  //player bullet
  //fill (100,100,230);
  
  if(eventCounter != prevEventCounter){
    if (currentBullet == maxPBullet - 1){
      currentBullet = 0;
    }
    pBX[currentBullet] = pX;
    pBY[currentBullet] = pY - 30;
    currentBullet++;
  }
  for(int i = 0; i < maxPBullet; i++){
    ellipse(pBX[i], pBY[i], 5, 5);
    pBY[i] -= 5;
  }
  
  //enemy
  stroke (200,0,0);
  fill (100,30,75);
  triangle (800,100,830,100, 815, 115);
  
  //enemy bullet
  fill(255,0,0);
  ellipse (0,300,5,10);
  
  
  prevEventCounter = eventCounter;
}
