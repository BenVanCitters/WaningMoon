import codeanticode.gsvideo.*;
GSMovie myMovie;

void initFireCircle()
{
  //  videosfire1-landscape.mp4
  String fileName = "videos/fire1-landscape.mp4";
  fileName = "videos/fireplace-log.MOV";
  myMovie = new GSMovie(this,fileName);
  myMovie.loop();
  myMovie.volume(0);
  println("successfully loaded " + fileName + "...");
}

void renderFireSquare()
{
  
  surface.pushMatrix();
//  surface.beginShape(TRIANGLE_STRIP);
//  surface.texture(myMovie);
//  surface.vertex(0,0);
//  surface.vertex(0,surface.height);
//  surface.vertex(surface.width,0);  
//  surface.vertex(surface.);
//  surface.endShape();
  
//  surface.image(myMovie, 
//                0,0,surface.width,surface.height);

int vertCount = 60;//(int)(mouseY*100.f/height);
//  println("vertcount: " + vertCount);
  surface.translate(surface.width/2,
                    surface.height/2);
  
  surface.beginShape(TRIANGLE_FAN);                
  surface.texture(myMovie);
  surface.vertex(0,0,.5,1);
  float[] p = new float[]{0,0};
  float[] t = new float[]{0,0};
  float radi = surface.height/2.f;
  println("mouseY*TWO_PI/height: " + mouseY*TWO_PI/height);
  for(int i = 0; i < vertCount; i++)
  {
    float curTht =i*TWO_PI/(vertCount-1);
    p[0] = cos(curTht);
    p[1] = sin(curTht);
    t[0] = cos(HALF_PI+i*TWO_PI/height+curTht);
    t[1] = sin(HALF_PI+i*TWO_PI/height+curTht);    
    surface.vertex(p[0]*radi,p[1]*radi,
                   t[0]*radi/surface.width,t[1]*radi/surface.height);
  }
  surface.endShape();
  surface.popMatrix();
}

void renderFireCircle()
{
  int vertCount = 60;//(int)(mouseY*100.f/height);
//  println("vertcount: " + vertCount);
  surface.textureMode(NORMALIZED);
  surface.pushMatrix();
  surface.translate(surface.width/2,
                    surface.height/2);
  
  surface.beginShape(TRIANGLE_FAN);                
  surface.texture(myMovie);
  surface.vertex(0,0,.5,1);
  float[] p = new float[]{0,0};
  float radi = surface.height/2.f;
  for(int i = 0; i < vertCount/2; i++)
  {
    float curTht = 2*i*TWO_PI/(vertCount-1);
    p[0] = cos(curTht);
    p[1] = sin(curTht);
    surface.vertex(p[0]*radi,p[1]*radi,
                   0,0);
    curTht = (2*i+1)*TWO_PI/(vertCount-1);
    p[0] = cos(curTht);
    p[1] = sin(curTht);
    surface.vertex(p[0]*radi,p[1]*radi,
                   1,0);                   
  }
  surface.endShape();                
  surface.popMatrix();
}

void movieEvent(GSMovie myMovie) 
{
  myMovie.read();
//  lastFrameDur = (millis() - gotLastFrameTm)/1000.0;
//  gotLastFrameTm = millis();
}
