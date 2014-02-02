import processing.opengl.*;

XMLElement xml;
PGraphics surface;

void setup()
{
  size(screenWidth,screenHeight, P3D);
  initLPD8();
  surface = createGraphics(height, width, P3D);
  
  initFireMoon();
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
    case FIRE_MODE:
      renderFireMoon();
      break;
    case RAIN_MODE:
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
  scale(gQuadScale*100);
  noStroke();
  textureMode(NORMALIZED);

  //46 seems to be a reasonable tradeoff between performance and
  // appearance I'm getting ~13.9 fps worst case with P3D
  // openGL renders ~2fps if that.
  int iCount = 46;//(int)(mouseX*600.f/width);
//  println("iCount: " + iCount);
    float p[] = new float[]{0,0};
  for(int i =0; i < iCount; i++)
  {
    beginShape(TRIANGLE_STRIP);
    texture(surface);
    int jCount = iCount;
    for(int j = 0; j< jCount; j++)
    {
      p[0] = j*1.f/(jCount-1);
      p[1] = i*1.f/(iCount-1);
      vertex(p[0]-.5,p[1]-.5,
             p[0],p[1]);

      p[1] = (i+1)*1.f/(iCount-1);
      vertex(p[0]-.5,p[1]-.5,
             p[0],p[1]);        
    }    
    endShape();  
  }  
  popMatrix();
}

//this method uses points all on a plane to approx a 3D transform
void oldrenderTextureToMain()
{
//  image(surface,0,0);
  float rad = PI*3.f/4.f;
  float UL[] = new float[]{gULRad*cos(rad),gULRad*sin(rad)};  
  rad = PI*5.f/4.f;
  float LL[] = new float[]{gLLRad*cos(rad),gLLRad*sin(rad)};
  rad = PI*1.f/4.f;
  float UR[] = new float[]{gURRad*cos(rad),gURRad*sin(rad)};
  rad = PI*7.f/4.f;
  float LR[] = new float[]{gLRRad*cos(rad),gLRRad*sin(rad)};


  pushMatrix();
  translate(gMoonPos[0],gMoonPos[1]);
  noStroke();
  textureMode(NORMALIZED);
  beginShape(TRIANGLE_STRIP);
  texture(surface);
  
  vertex(UL[0],UL[1],
         0,0);
  vertex(LL[0],LL[1],
         0,1);
  vertex(UR[0],UR[1],
         1,0);
  vertex(LR[0],LR[1],
        1,1);
  endShape();  
  popMatrix();
}

