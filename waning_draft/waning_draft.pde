PGraphics surface;

final int MOON_SIDE = 654;


void setup()
{
  size(screenWidth,screenHeight, P3D);
  noCursor();
  initLPD8();
  surface = createGraphics(MOON_SIDE, MOON_SIDE, P3D);
  initDrips();
  initFireCircle();
  initLetter();
}

void defaultScreenClear()
{
  if(debug)
    surface.background(0,255,0);
  else
    surface.background(0);  
}

void draw()
{
  background(0);
  surface.beginDraw();

  surface.noStroke();

  
  surface.pushMatrix();
  
  switch(gCurrentGraphicMode)
  {
    case NO_GRAPHIC_MODE:
      break;
    case RED_MOON_MODE:
      defaultScreenClear();
      renderRedMoon();
      break;
    case BLUE_MOON_MODE:
      defaultScreenClear();
      renderBlueMoon();
      break;
    case FIRE_MODE:
      defaultScreenClear();
      renderFireCircle();
      break;
    case RAIN1_MODE:
      renderRain();
      break;
    case LETTER_MODE:
//      defaultScreenClear();
      renderLetter();
      break;
    case RAIN2_MODE:
      renderRain2();
      break;      
    case RAIN3_MODE:
      renderRain3();
      break;    
    case FIRE2_MODE:
      defaultScreenClear();
      renderFireSquare();
      break;
     default: 
  }
  surface.popMatrix();
  if(positioningMode)
  {
    renderPositioningHelp();
  }
  surface.endDraw();
  
  renderTextureToMain();

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
  if(gLastGraphicMode != gCurrentGraphicMode)
  {
    defaultScreenClear();
  }
  gLastGraphicMode = gCurrentGraphicMode;
}

void renderPositioningHelp()
{
  surface.hint(DISABLE_DEPTH_TEST);
  surface.strokeWeight(3);
  surface.pushMatrix();
  surface.fill(0);
  surface.stroke(0,255,0);
  surface.rect(1,1,surface.width-2,surface.height-2);
  surface.ellipse(surface.width/2,surface.height/2,surface.width,surface.height);
  surface.line(0,surface.height/3,surface.width,surface.height/3);
  surface.line(0,surface.height*2.f/3,surface.width,surface.height*2.f/3);
  surface.line(surface.width/3,0,surface.width/3,surface.height);
  surface.line(surface.width*2.f/3,0,surface.width*2.f/3,surface.height);

  surface.popMatrix();
}

//uses a 3D-Based approach to map to a wall 
//iteratively renders the surface to handle 
//distortion 
void renderTextureToMain()
{
  pushMatrix();
  translate(gMoonPos[0],gMoonPos[1],gMoonPos[2]);
  
  rotateX(gQuadRot[0]);
  rotateY(gQuadRot[1]);
  rotateZ(gQuadRot[2]);
  scale(gQuadScale);
  noStroke();
  textureMode(NORMALIZED);
tint(gBlackOut);
  //46 seems to be a reasonable tradeoff between performance and
  // appearance I'm getting ~13.9 fps worst case with P3D
  // openGL renders ~2fps if that.
  int iCount = 46;//(int)(mouseX*600.f/width);
//  println("iCount: " + iCount);

  
  //draws a normalized square mesh and textures it 
  // with our 'surface' graphics object
  float p[] = new float[]{0,0};
  for(int i =0; i < iCount-1; i++)
  {
    beginShape(TRIANGLE_STRIP);
    texture(surface);
    int jCount = iCount;
    for(int j = 0; j< jCount; j++)
    {
      //top vertex of strip
      p[0] = j*1.f/(jCount-1);
      p[1] = i*1.f/(iCount-1);
      vertex(p[0]-.5,p[1]-.5,
             p[0],p[1]);
      //bottom vertex of strip
      p[1] = (i+1)*1.f/(iCount-1);
      vertex(p[0]-.5,p[1]-.5,
             p[0],p[1]);        
    }    
    endShape();  
  }  
  popMatrix();
}

