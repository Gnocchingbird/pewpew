int starPosition = 0; // zum Bewegen der Sterne
PImage bg;            //
PImage pl;            //

void setup() {
  size(1024,700);
  bg = loadImage("paint.png");  // Load the image into the program  
  pl = loadImage("pew.png");
  

}

void draw() {
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
  stroke (0,0,200);
  fill (13,57,96);
  ellipse (mouseX+12,mouseY,24,30);
  rect (mouseX,mouseY,24,40);
  triangle (mouseX,mouseY+30, mouseX,mouseY+10, mouseX-20, mouseY+30);
  triangle (mouseX+24,mouseY+30, mouseX+24,mouseY+10, mouseX+44, mouseY+30);
  
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
