import codeanticode.gsvideo.*;
GSMovie myMovie;

void initFireMoon()
{
  //  videosfire1-landscape.mp4
  String fileName = "videos/fire1-landscape.mp4";
  myMovie = new GSMovie(this,fileName);
  myMovie.loop();
  myMovie.volume(0);
  println("successfully loaded " + fileName + "...");
}

void renderFireMoon()
{
  surface.image(myMovie, 0, 0,surface.width,surface.height);
}

void movieEvent(GSMovie myMovie) 
{
  myMovie.read();
//  lastFrameDur = (millis() - gotLastFrameTm)/1000.0;
//  gotLastFrameTm = millis();
}
