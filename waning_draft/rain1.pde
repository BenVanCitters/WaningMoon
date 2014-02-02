ArrayList<drop> drips;

void renderRain()
{
    drawBack(color(0,0,100));
  drawDrips();
}

void renderRain2()
{
    drawBack(color(0));
  drawDrips();
}

void renderRain3()
{
    drawBack(color(100,100,100,2));
  drawDrips();
}

void initDrips()
{
  drips = new ArrayList<drop>();

  for(int i = 0; i< 5000; i++)
  {
    makeNewDrip(false);
  }
}

//global drop stuff
void drawDrips()
{
  // update drips
  int removeCount = 0; //how many drips fell offscreen  
  float[] grav = {0.0,.70};
  Iterator<drop> it = drips.iterator();  
  while(it.hasNext())
  {
    drop tmp = it.next();
    tmp.move(grav); 
    tmp.setSparkScaling(5);
    if(tmp.isOffScreen())
    {
      removeCount++;
      it.remove();      
    }
  }
  
  //draw stuff

  int clr = color(220,220,255);
  fill(clr);
  stroke(clr);
  //line(0,height*(1-runningMaxAmp),width,height*(1-runningMaxAmp));
  float pct = 1.f;//mouseX*1.0f/width;
  for(drop d : drips)
  {
    d.drawMe();        
  }
  
  //refresh offscreen drips
  for(int i=0; i < removeCount;i++)
  {
    makeNewDrip(true);
  }  
//  println("rain - Framerate: " + frameRate + " pct: " + (mouseY * 1.0f / height));
}
void makeNewDrip(boolean top)
{
  float yCoord = 0.0;
  if(top) 
    yCoord =  -5;
  else
    yCoord = random(surface.height);
    
  drips.add(new drop(new float[]{random(surface.width),yCoord},//random(height)}, //pos
                     new float[]{ 0.05-random(0.10), 1.0 + random(3.0)}, //vel
                     random(0.01),//threshold
                     random(3.0) //time
                    )); 
}

void drawBack(int clr)
{
  float pct = 1.f;//mouseY * 1.0f / height;
//  int clr = color(30,30,40,20*(1.2-amp));
  
//  int clr = color(30,30,40,20*(1.2-amp));
  surface.stroke(clr);
  surface.fill(clr);
  surface.rect(0,0,width,height);
  //background(clr);
}
///drop class
class drop
{
  public drop(float[] pos, float[] vel, float sparkLikelyhood,float tm) 
  {
    this.tm = tm;
    this.pos = pos;
    this.lastPos = new float[]{ pos[0], pos[1]};
    this.vel = vel;
    this.sparkLikelyhood = sparkLikelyhood;
    removeSelf = false;
    maxFlashDur = (long)random(200);
    sparkScale = 1.0;
    sparkScaleMinMax = new float[]{.1,5.0};
  }
  
  public void move(float[] accel)
  {
    lastPos[0] = this.pos[0];
    lastPos[1] = this.pos[1];
    tm += 0.1;
    //move!
    pos[0] += accel[0]*tm; 
    pos[1] += accel[1]*tm;     
    
    //if it goes off the sides
    if(pos[0] > surface.width || pos[0] < 0)
      removeSelf = true;
      
    //if it falls off the bottom
    if( pos[1] > surface.height)
      removeSelf = true;
      
    if(random(1.0) < sparkLikelyhood*sparkScale)
    {
      startFlash();
    }
  }
  
  public void drawMe()
  {    
    if(isFlashing())
    {
      int clr = color(100,180,255);;
      surface.stroke(clr);
      surface.strokeWeight(2);
      surface.strokeCap(ROUND);
      surface.line(lastPos[0],lastPos[1],pos[0], pos[1]);
      //ellipse(pos[0], pos[1], 5,5);
//      noFill();
//      stroke(255,0,0);
//      if(pos[1]== lastPos[1])
//      ellipse(lastPos[0],lastPos[1], 15,15);

    }
  }
  
  private boolean isFlashing()
  {
    return millis()- flashStart < curFlashDur;
  }
  
  private void startFlash()
  {
    if(random(1.0) < .01)
    {
      float r = random(TWO_PI);
      float w = random(20);
      float h = random(20);     
//      stroke(255);
//      fill(255);
//      ellipse(pos[0],pos[1],10*w,10*w);
//      line(pos[0] -w*cos(r), 
//           pos[1]+w*sin(r),
//           pos[0]+w*cos(r),
//           pos[1]-w*sin(r));
//      line(pos[0]+h*cos(r+HALF_PI), 
//           pos[1] -h*sin(r+HALF_PI), 
//           pos[0]-h*cos(r+HALF_PI),
//           pos[1]+h*sin(r+HALF_PI));
    }
    curFlashDur = (long)random(maxFlashDur*sparkScale);
    flashStart = millis();
  }
  
  public long getCurVal()
  {
    return System.currentTimeMillis();//cos((System.currentTimeMillis()/1000.0)*frequency);
  }
  
  public void setMaxFlashDur(long val)
  {
    maxFlashDur = val;
  }
  
  public float getMaxFlashDur()
 {
   return maxFlashDur;
 }
 
 public void setSparkScaling(float scale)
 {
   sparkScale = max(min(scale,sparkScaleMinMax[1]),sparkScaleMinMax[0]);
   
 }
  
  public boolean isOffScreen(){return removeSelf;}
  
  private float[] pos;
  private float[] lastPos;
  private float[] vel;
  private float tm;
  private float sparkLikelyhood;
  private float sparkScale;
  private float sparkScaleMinMax[];
  private long flashStart;
  private long maxFlashDur;
  private long curFlashDur;
  private boolean removeSelf; 
}
