import codeanticode.gsvideo.*;
GSMovie myMovie;

void initFireMoon()
{
  //  videosfire1-landscape.mp4
  myMovie = new GSMovie(this,"100_7017.MOV");
  myMovie.loop();
  myMovie.volume(0);
}

void renderFireMoon()
{
  image(myMovie, 0, 0,width,height);
}

void movieEvent(GSMovie myMovie) 
{
  myMovie.read();
//  lastFrameDur = (millis() - gotLastFrameTm)/1000.0;
//  gotLastFrameTm = millis();
}
