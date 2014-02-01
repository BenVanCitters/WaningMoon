import processing.opengl.*;

XMLElement xml;
PGraphics surface;
void setup()
{
  size(screenWidth,screenHeight, OPENGL);
  initLPD8();
}

void draw()
{
  background(100);
  noStroke();
  
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
    fill(0);
    rect(0,0,350,80);
    hint(DISABLE_DEPTH_TEST);
    textSize(22);    
    String s = "frameRate: " + frameRate;
    fill(255,0,0);
    stroke(255);
    text(s, 10,30);
    hint(ENABLE_DEPTH_TEST);
  }
//  println("frameRate:" + frameRate);
}


