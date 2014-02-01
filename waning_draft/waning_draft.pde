

void setup()
{
  size(500,500, P3D);
}

void draw()
{
  background(0);
  noStroke();
  float angle = -mouseX*TWO_PI/width;
  directionalLight(255,255,255,-sin(angle),0,cos(angle));
  translate(width/2,height/2);
  sphereDetail(mouseY / 4);
//  if(mouseY > height/2)
//    fill(0,0,100);
//  else
//    fill(150,80,0);
//rotateX(mouseX/330.f);
//rotateZ(mouseX/100.f);

scale(.5,1,1);

  sphere(200);
}
