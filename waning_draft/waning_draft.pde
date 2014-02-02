PGraphics surface;

final int MOON_SIDE = 654;
void setup()
{
  size(screenWidth,screenHeight, P3D);
  initLPD8();
  surface = createGraphics(MOON_SIDE, MOON_SIDE, P3D);
  initDrips();
  initFireCircle();
}

void draw()
{
  background(0);
  surface.beginDraw();
  if(debug)
    surface.background(0,255,0);
  else
    surface.background(0);
  surface.noStroke();
  
  surface.pushMatrix();
  
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
    case FIRE_MODE:
      renderFireCircle();
      break;
    case RAIN_MODE:
    renderRain();
      break;
     default: 
  }
  surface.popMatrix();
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

