//import processing.sound.*;
//SoundFile music;
//SoundFile killsnd;
int counter= 0;// zum Bewegen der Sterne
int pX=955,pY=540;//player position
int pVX=10,pVY=6;//player velocity in X and Y directions
int score=0;//player score
int eX=800,eY=100;//enemy position

int maxPBullet = 20;// max number of player bullets
int maxEBullet = 200;// max number of enemy bullets
int currentBullet = 0;
int currentEBullet = 0;
int[] pBX = new int[maxPBullet]; //player bullet locations
int[] pBY = new int[maxPBullet];
boolean[] pBExists = new boolean[maxPBullet]; // lets used bullets vanish
int[] eBX = new int[maxEBullet];//enemy bullet locations
int[] eBY = new int[maxEBullet];
int fireRate = 100; // time between shots (only multiples of 5)
int eventCounter, prevEventCounter; // makes various events occur (shot fired, fire animation...)
int[] starX = new int[20];
int[] starY = new int[20];

int playerLives = 3;
PImage flame1,flame2;// visual element
PImage heart;
boolean flame_mode = false;//visual perk


boolean wPressed=false;
boolean aPressed=false;
boolean sPressed=false;
boolean dPressed=false;



void setup() {
  size(1920,1080);
  flame1 = loadImage("flame.png");  // Load the image into the program  
  flame2 = loadImage("flame_rev.png");
  heart  = loadImage("heart.png");
  
  for(int i=0; i < starX.length; i++){
    starX[i] = int(random(0, 1921));
    starY[i] = int(random(0, 1081));
  }
  //music=new SoundFile(this,"background_music.mp3");
  //music.loop();
}

void draw() {
   
  counter += 300 / frameRate;
  background (30);
  fill(255);

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
  
  for(int i = 0; i < starX.length; i++){
    ellipse(starX[i], (counter + starY[i]) % 1080, 3, 3);
  }
  
  //player
  stroke (0,0,200);
  fill (13,57,96);
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
  
  //player health
   for(int i = 0; i < playerLives; i++){
    image(heart, 30 * i + 20, height - 110);
  }

  //player bullet
 fill (200,200,130);
 if(eventCounter !=prevEventCounter){
    if (currentBullet == maxPBullet - 1){
      currentBullet = 0;
    }
    pBX[currentBullet] = pX;
    pBY[currentBullet] = pY - 30;
    currentBullet++;
    pBExists[currentBullet] = true;
  }
  for(int i = 0; i < maxPBullet; i++){
    
    if(eX-15<=pBX[i]+2 && eX+15>=pBX[i]-2 && eY+15>=pBY[i]-2 && eY < pBY[i] + 2){
      pBExists[i] = false;
    }
    
    if(pBExists[i] == false){
      stroke(30);
      fill(30);
    }
    else{
      stroke(0,0,200);
      fill(200,200,130);
    }
    
    ellipse(pBX[i], pBY[i], 5, 5);
    pBY[i] -= 5;
    
    
}
  
  //enemy
  stroke (200,0,0);
  fill (100,30,75);
  triangle (eX - 15, eY, eX + 15, eY, eX, eY+15);
  if(pX < eX){
    eX -= 3;
  }
  if(pX > eX){
    eX += 3;
  }
  
  //enemy bullet
  fill(255,0,0);
   if((eventCounter %4==0) && eventCounter !=prevEventCounter){
    if (currentEBullet == maxEBullet - 1){
      currentEBullet = 0;
    }
    eBX[currentEBullet] = eX+15;
    eBY[currentEBullet] = eY + 30;
    currentEBullet++;
  }
  for(int i = 0; i < maxEBullet; i++){
    ellipse(eBX[i], eBY[i], 5, 5);
    eBY[i] += 5;
  }  
  prevEventCounter = eventCounter;
  
  //bullet collision
    //hitbox
    stroke(255,255,0);
    noFill();
    //player
    rect(pX-12,pY-25,24,55);
    //enemy
    rect(eX-15,eY,30,15);
    
   
  
  //devstats
  fill(255);
  textSize(15);
  text("stats",900,20);
  text(frameRate, 900, 30);
  text(counter, 900, 40);
  text(pX,900,50);
  text(pY,900,60);
  
  //player score
  textSize(40);
  text("score:"+score,30,50);
  
  if (wPressed) {
      pY -= pVY;
  }
  if (aPressed) {
      pX -= pVX;
  }
  if (sPressed) {
      pY += pVY;
  }
  if (dPressed) {
      pX += pVX;
  }
  
  if(pY<32) {
    pY=32;
  }
  if(pY>height-32){
    pY=height-32;
  }
  if(pX<32) {
    pX=32;
  }
  if(pX>width-32) {
    pX=width-32;
  }
}

void keyPressed(){
  if(key == 'w' || key == 'W'){
    wPressed = true;
  }
  if(key == 'a' || key == 'A'){
    aPressed = true;
  }
  if(key == 's' || key == 'S'){
    sPressed = true;
  }
  if(key == 'd' || key == 'D'){
    dPressed = true;
  }
}

void keyReleased(){
  if(key == 'w' || key == 'W'){
    wPressed = false;
  }
  if(key == 'a' || key == 'A'){
    aPressed = false;
  }
  if(key == 's' || key == 'S'){
    sPressed = false;
  }
  if(key == 'd' || key == 'D'){
    dPressed = false;
  }
}
