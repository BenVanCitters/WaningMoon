PImage letterTex;
void initLetter()
{
  letterTex = loadImage("images/handwritten.jpg");
}

long gLetterStartTime = 0;
void renderLetter()
{
  float angle = -(millis()-gLetterStartTime)/4000.f;///-mouseX*TWO_PI/width;
  surface.directionalLight(255,255,255,-sin(angle),0,cos(angle));
  surface.translate(surface.width/2,
                    surface.height/2);
  renderLetterMoonGeo();
}

void renderLetterMoonGeo()
{
  surface.textureMode(NORMALIZED);
  surface.noStroke();
  surface.shininess(.2);
  int vertDivs = 50;
  int horzDivs = 50;
  float rad = 280;//mouseY*height*2.f/height;
//  println("rad: " + rad);
  surface.fill(255);
  for(int i = 0; i < vertDivs; i++)
  {
//    flj*PI/horzDivs
    surface.beginShape(TRIANGLE_STRIP);
    surface.texture(letterTex);
    for(int j = 0; j < horzDivs; j++)
    {
      float curTht = i*PI/vertDivs;//mouseY*TWO_PI/height + 
      float curPhi = j*PI/horzDivs;
      float[] pos = new float[]{rad*cos(curPhi)*sin(curTht),
                                rad*cos(curTht),
                              rad*sin(curPhi)*sin(curTht)};
      surface.vertex(pos[0],pos[1],pos[2]
      ,1-j*1.f/horzDivs,1-i*1.f/vertDivs
      );
      
      curTht = (i+1)*PI/vertDivs;
      pos[0]= rad*cos(curPhi)*sin(curTht);
      pos[1]= rad*cos(curTht);
      pos[2]= rad*sin(curPhi)*sin(curTht);
      surface.vertex(pos[0],pos[1],pos[2]
      ,1-j*1.f/horzDivs,1-(i+1)*1.f/vertDivs
      );
    }
    surface.endShape();
  }
}
