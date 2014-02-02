void renderRedMoon()
{
  float angle = gMoonPhase;///-mouseX*TWO_PI/width;
  surface.directionalLight(150,100,35,-sin(angle),0,cos(angle));

//rotateX(mouseX/330.f);
//rotateZ(mouseX/100.f);
//scale(.5,1,1);
  surface.sphereDetail(73);
  surface.sphere(height/3.f);
//  fill(255);
//  renderMoonGeo();
}

void renderMoonGeo()
{
  surface.noStroke();
  surface.shininess(.2);
  int vertDivs = 100;
  int horzDivs = 250;
  float rad = height/3.f;
  surface.fill(255);
  for(int i = 0; i < vertDivs; i++)
  {
//    flj*PI/horzDivs
    surface.beginShape(TRIANGLE_STRIP);
    for(int j = 0; j < horzDivs; j++)
    {
      float curTht = i*PI/vertDivs;//mouseY*TWO_PI/height + 
      float curPhi = j*PI/horzDivs;
      float[] pos = new float[]{rad*cos(curPhi)*sin(curTht),
                                rad*cos(curTht),
                              rad*sin(curPhi)*sin(curTht)};
      surface.vertex(pos[0],pos[1],pos[2]);
      
      curTht = (i+1)*PI/vertDivs;
      pos[0]= rad*cos(curPhi)*sin(curTht);
      pos[1]= rad*cos(curTht);
      pos[2]= rad*sin(curPhi)*sin(curTht);
      surface.vertex(pos[0],pos[1],pos[2]);
    }
    surface.endShape();
  }
}
