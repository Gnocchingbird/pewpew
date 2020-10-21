//import processing.sound.*;
//SoundFile music;
//SoundFile killsnd;
int counter= 0;// zum Bewegen der Sterne
int pX=955,pY=540;//player position
int pVX=10,pVY=6;//player velocity in X and Y directions
int score=0;//player score
int maxENum = 1;
float[] eX=new float[maxENum];
float[] eY=new float[maxENum];//enemy position
int eV = 3;

int maxPBullet = 21;// max number of player bullets
int maxEBullet = maxENum * 20;// max number of enemy bullets
int currentBullet = 0;
int currentEBullet = 0;
float[] pBX = new float[maxPBullet]; //player bullet locations
float[] pBY = new float[maxPBullet];
boolean[] pBExists = new boolean[maxPBullet]; // lets used bullets vanish
float[][] eBX = new float[maxENum][maxEBullet];//enemy bullet locations
float[][] eBY = new float[maxENum][maxEBullet];
boolean[][] eBExists = new boolean[maxENum][maxEBullet];
float[] eRepulsion = new float[maxENum]; // puffer zw. enemies
float[] eBRepulsion = new float[maxENum];
int[] leastYDiff = new int[maxENum]; // notes closest bullet to enemy
int fireRate = 100; // time between shots (only multiples of 5)
int eventCounter, prevEventCounter; // makes various events occur (shot fired, fire animation...)
int[] starX = new int[20];
int[] starY = new int[20];
int dodge = 40;

int playerLives = 3;
int[] enemyLives = new int[maxENum];
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
  
  score = 0;
  playerLives = 3;
  
  for(int i=0; i < starX.length; i++){
    starX[i] = int(random(0, 1921));
    starY[i] = int(random(0, 1081));
  }
  //music=new SoundFile(this,"background_music.mp3");
  //music.loop();
  for(int i = 0; i < maxENum; i++){
    int border = int(1920 / maxENum);
    eX[i] = int(random(i* border + 20, (i + 1) * border - 20));
    eY[i] = 150;
    enemyLives[i] = 1000;
    leastYDiff[i] = 20;
  }
  pBY[20] = 1000; // needed for leastYDiff
}

void draw() {
   
  counter += 300 / frameRate;
  background (30, 30, 50);
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
 if(eventCounter != prevEventCounter){ // triggers on change of eventCounter
    pBX[currentBullet] = pX; // bullet location definition (relative to player location)
    pBY[currentBullet] = pY - 30;
    pBExists[currentBullet] = true; // makes current bullet visible
    currentBullet++;
    pBExists[currentBullet] = true;
    if (currentBullet == maxPBullet - 1){ // resets counter to the first bullet (prevents out of bounds)
      currentBullet = 0;
    }
  }
  for(int i = 0; i < maxPBullet; i++){ // loops through current bullets
    for(int j = 0; j < maxENum; j++){ // loops through existing enemies for every bullet
      if(eX[j] - 15<=pBX[i] + 2 && eX[j]+15>=pBX[i]-2 && eY[j] + 15>=pBY[i]-2 && eY[j] < pBY[i] + 2){ // hitbox shenanigans
        pBExists[i] = false;
        pBX[i] = - 50; // bullet moved out of view
        enemyLives[j]--; // deals damage to enemy
        if(enemyLives[j] == 0){ // triggers on kill
          score += 100;
          for(int k = j + 1; k < maxENum; k++){ // loops from killed enemy to end of array, pushing the values together (necessary for loops that compare between adjacent entries)
            eX[k - 1] = eX[k];
            eY[k - 1] = eY[k];
            enemyLives[k - 1] = enemyLives[k];
          }
          enemyLives[maxENum - 1] = 0; // sets the last enemy to be the recently dead one
        }
      }
      
      //bullet repulsion
        if(pBY[i] > 135 && abs(pBY[i] - eY[j]) < pBY[leastYDiff[j]] - eY[j]){
          leastYDiff[j] = i;
        }
      
    }
    if(pBExists[i] == true){ // draws bullet if it exists
      ellipse(pBX[i], pBY[i], 5, 5);
    }
    
    if(i != 20){
      pBY[i] -= 5; // moves every bullet upward
    }
}
println(leastYDiff[0]);
println(pBY[20]);

  for(int i = 0; i < maxENum; i++){
    if(pBY[leastYDiff[i]] > 135){
      if(eX[i] < pBX[leastYDiff[i]]){
        eBRepulsion[i] = -40 / (pBX[leastYDiff[i]] - eX[i]);
      }
      if(pBX[leastYDiff[i]] < eX[i]){
        eBRepulsion[i] = 40 / (eX [i] - pBX[leastYDiff[i]]);
      }
      if(eX[i] < pBX[leastYDiff[i]] && pBX[leastYDiff[i]] < eX[i] + 20){
        eBRepulsion[i] = -2 - (pBX[leastYDiff[i]] - eX[i]) / 20;
      }
      if(pBX[leastYDiff[i]] < eX[i] && eX[i] < pBX[leastYDiff[i]] + 20){
        eBRepulsion[i] = 2 + (eX[i] - pBX[leastYDiff[i]]) / 20;
      }
    }
    leastYDiff[i] = 20;
  }
    
  
  //enemies
  for(int i = 0; i < maxENum; i++){ // loops through every enemy in array
    if(enemyLives[i] > 0){ // triggers for live enemies only
      stroke (200,0,0);
      fill (100,30,75);
      triangle (eX[i] - 15, eY[i], eX[i] + 15, eY[i], eX[i], eY[i] + 15);
      text(enemyLives[i], eX[i] - 5, eY[i] - 5); // test, displays lives above each enemy
      text(eX[i] - pX, eX[i] - 5, eY[i] - 45);
      
      // enemy movement
      println("Before movement: " + eBRepulsion[i]);
      if(pX < eX[i]){ // player right of enemy
        if(i != 0){
          eRepulsion[i] = 160 / (eX[i] - eX[i - 1]); // repulsion between enemies to prevent stacking
          eRepulsion[i] = 0;
        eX[i] += -eV - eRepulsion[i] + eBRepulsion[i]; // calculation of enemy position
        }
        else{ // handling i == 0
          eRepulsion[i] = 160 / eX[i];
          eRepulsion[i] = 0;
          eX[i] += -eV - eRepulsion[i] + eBRepulsion[i];
        }
      }
      if(pX > eX[i]){ // player left of enemy, rinse and repeat
        if(i + 1 != maxENum && eX[i + 1] != eX[i]){
          eRepulsion[i] = 160 / (eX[i + 1] - eX[i]);
          eRepulsion[i] = 0;
        eX[i] += eV - eRepulsion[i] + eBRepulsion[i];
        }
        else{
          eRepulsion[i] = 160 / (width - eX[i]);
          eRepulsion[i] = 0;
          eX[i] += eV - eRepulsion[i] + eBRepulsion[i];
        }
      }
      if(pX == eX[i]){
        eX[i] = pX;
      }
      println("At movement: " + eBRepulsion[i]);
      eBRepulsion[i] = 0;
    }
  }
  
  //enemy bullet
  fill(255,0,0);
   if((eventCounter %4==0) && eventCounter !=prevEventCounter){ // triggers every fourth eventCounter change (reduced fire rate compared to player)
    if (currentEBullet == maxEBullet - maxENum){ // wraps over to first bullet, prevents oob
      currentEBullet = 0;
    }
    for(int i = 0; i < maxENum; i++){ // loops through enemies
      eBX[i][currentEBullet] = eX[i]; // bullet location definition
      eBY[i][currentEBullet] = eY[i] + 20;
      eBExists[i][currentEBullet] = true;
      currentEBullet++;
      eBExists[i][currentEBullet] = true;
    }
  }
  for(int i = 0; i < maxEBullet; i++){ // loops through bullets
    for(int j = 0; j < maxENum; j++){ // loops through enemies
      if(enemyLives[j] > 0){ // only triggers for live enemies v2
        if(eBX[j][i] + 2 >= pX-12 && eBX[j][i] - 2 <= pX + 12 && eBY[j][i] + 2 >= pY - 25 && eBY[j][i] - 2 <= pY + 25){ // hitbox things
          eBExists[j][i] = false; // makes used enemy bullets disappear
          eBX[j][i] = -50;
          playerLives--; // player takes damage
        }
        if(eBExists[j][i]){
          ellipse(eBX[j][i], eBY[j][i], 5, 5); // draws bullet if it exists
        }  
        eBY[j][i] += 5; // moves bullets
      }
    }
  }
  prevEventCounter = eventCounter; // sets the prev. counter to the current one
  
  //bullet collision
    //hitbox
    /*stroke(255,255,0);
    noFill();
    //player
    rect(pX-12,pY-25,24,55);
    //enemy
    for(int i = 0; i < maxENum; i++){
      rect(eX[i]-15,eY[i],30,15);
    }*/
    
   
  
  //devstats
  fill(255);
  textSize(15);
  text("stats",900,20);
  text(frameRate, 900, 30);
  text(counter, 900, 40);
  text(pX,900,50);
  text(pY,900,60);
  text(playerLives, 900, 70);
  text(currentEBullet, 900, 80);
  
  //player score
  textSize(40);
  text("score:"+score,30,50);
  
  if (wPressed) { // keyboard controls
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
  
  if(pY<32) { // player movement limit
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

void keyPressed(){ // keyboard input
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
  if(key == 'r' || key == 'R'){
    setup();
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
