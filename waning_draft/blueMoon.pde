void renderBlueMoon()
{
  float angle = gMoonPhase;///-mouseX*TWO_PI/width;
  surface.directionalLight(65,65,100,-sin(angle),0,cos(angle));
  //  if(mouseY > height/2)
//    fill(0,0,100);
//  else
//    fill(150,80,0);
//rotateX(mouseX/330.f);
//rotateZ(mouseX/100.f);
//scale(.5,1,1);
  surface.sphereDetail(73);
  surface.sphere(height/3.f);
//  renderMoonGeo();
}

