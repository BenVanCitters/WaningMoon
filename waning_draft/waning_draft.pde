import processing.opengl.*;

XMLElement xml;
PGraphics surface;
void setup()
{
  size(screenWidth,screenHeight, OPENGL);
  //load a font?
  textFont(loadFont("Univers-66.vlw"), 1.0);
  initLPD8();
}

void draw()
{
  background(100);
  noStroke();
  float angle = gMoonPhase;///-mouseX*TWO_PI/width;
  directionalLight(255,255,255,-sin(angle),0,cos(angle));
  pushMatrix();
  translate(width/2,height/2);
  switch(gCurrentGraphicMode)
  {
    case NO_GRAPHIC_MODE:
      break;
    case RED_MOON_MODE:
      renderRedMoon();
      break;
    case BLUE_MOON_MODE:
      break;
    case RAIN_MODE:
      break;
     default: 
  }
  
  
  popMatrix();
  
  if(debug)
  {
    stroke(255);
    fill(255);
    scale(75.0);
    text("word", 150, 300); 
    println("frameRate:" + frameRate);
  }
//  println("frameRate:" + frameRate);
}


