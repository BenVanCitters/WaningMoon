import processing.opengl.*;

XMLElement xml;
PGraphics surface;

void setup()
{
  size(screenWidth,screenHeight, P2D);
  initLPD8();
  surface = createGraphics(screenHeight, screenHeight, P3D);
}

void draw()
{
  background(0);
  surface.beginDraw();
  surface.background(100);
  surface.noStroke();
  
  surface.pushMatrix();
  surface.translate(surface.width/2,
                    surface.height/2);
  switch(gCurrentGraphicMode)
  {
    case NO_GRAPHIC_MODE:
      break;
    case RED_MOON_MODE:
      renderRedMoon();
      break;
    case BLUE_MOON_MODE:
      renderBlueMoon();
      break;
    case RAIN_MODE:
      break;
     default: 
  }
  surface.popMatrix();
  surface.endDraw();
  
  image(surface,0,0);
  
  if(debug)
  {
    noLights();
    fill(0);
    rect(0,0,350,80);
    hint(DISABLE_DEPTH_TEST);
    textSize(22);    
    fill(255);
    text("frameRate: " + frameRate, 10,30);
    hint(ENABLE_DEPTH_TEST);
  }
}


