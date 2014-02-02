void renderBlueMoon()
{
  surface.translate(surface.width/2,
                    surface.height/2);
  float angle = gMoonPhase;///-mouseX*TWO_PI/width;
  surface.directionalLight(0,0,255,-sin(angle),0,cos(angle));
  //  if(mouseY > height/2)
//    fill(0,0,100);
//  else
//    fill(150,80,0);
//rotateX(mouseX/330.f);
//rotateZ(mouseX/100.f);
//scale(.5,1,1);
  surface.sphereDetail(73);
    surface.sphere(surface.height*sphereRadMultiplier);
//  renderMoonGeo();
}

