// http://www.openprocessing.org/visuals/?visualID=6268
// wrestled into VJ compatible MIDI form by Jay Silence
import themidibus.*;

// MIDI bus for parameter input via Akai LPD8
MidiBus myBus;
boolean debug=false;
boolean positioningMode=false;
void initLPD8()
{
   if (debug) MidiBus.list(); // List all available Midi devices on STDOUT. 
  // Create a new MidiBus with Akai input device and no output device.
  myBus = new MidiBus(this, "LPD8", -1);
}

// Handle keyboard input
void keyPressed()
{
  switch(key){
    case 'd':
      debug = !debug;
      println("Debug Output" + (debug?"enabled":"disabled"));
      break;
    case 's':
      saveFrame("sreenCaptures/img-######.png");
      break;
    case 'p':
      positioningMode= !positioningMode;
      println("positioning Mode " + (positioningMode?"enabled":"disabled"));
  }
}


final int NO_GRAPHIC_MODE=0;
final int RED_MOON_MODE=1;
final int BLUE_MOON_MODE=2;
final int FIRE_MODE=3;
final int RAIN_MODE=4;
final int LETTER_MODE=5;
int gCurrentGraphicMode = NO_GRAPHIC_MODE;
// MIDI Event handling
void noteOn(int channel, int pad, int velocity) {
  // Receive a noteOn
  if(debug) {
    print("Note On - ");
    print("Channel "+channel);
    print(" - Pad "+pad);
    println(" - Value: "+velocity);
  }
  switch(pad){
    case 36:
      gCurrentGraphicMode = NO_GRAPHIC_MODE;
      println("NO_GRAPHIC_MODE enabled");
      break;   
    case 37:
      gCurrentGraphicMode = RED_MOON_MODE;
      println("RED_MOON_MODE enabled");
      break;   
    case 38:
      gCurrentGraphicMode = BLUE_MOON_MODE;
      println("BLUE_MOON_MODE enabled");
      break;   
    case 39:
      gCurrentGraphicMode = FIRE_MODE;
      println("FIRE_MODE enabled");
      break;
    case 40:
      gCurrentGraphicMode = RAIN_MODE;     
      println("RAIN_MODE enabled"); 
      break;   
    case 41:
      gCurrentGraphicMode = LETTER_MODE;     
      println("LETTER_MODE enabled"); 
      break;   
    default:
      break;   
  }
}
 
 
// Right now we are doing nothing on pad release events
void noteOff(int channel, int pad, int velocity) {
    // Receive a noteOff
  if(debug) {
    print("Note Off - ");
    print(" Channel "+channel);
    print(" - Pad "+pad);
    println(" - Value "+velocity);
  }
}
float gBlackOut = 256.f;
float gMoonPhase = 0.f;
float gMoonPos[] = new float[]{521.15625f,378.09375f,372.0f};
float[] gQuadRot = new float[]{0.f,0.f,0.f};
float gQuadScale = 298.65625f;
final int MAX_DIAL_VAL = 127;
void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  if(debug) {
    print("Controller Change - ");
    print("Channel "+channel);
    print(" - Number "+number);
    println(" - Value "+value);
  }
  if(!positioningMode)
  {
    switch(number)
    {
      case 1:  // = K1 //.80-5.7 - used to be 
        gMoonPhase = .70f+value*(5.63f-.70f)/MAX_DIAL_VAL;
        println("gMoonPhase = " + gMoonPhase);
        break;
      case 8:
        gBlackOut = 256-value*256.f/MAX_DIAL_VAL;
        break;
      default:
        break;   
    } 
  }
  else
  { 
    //controls for positioning the moon
    switch(number)
    {
      case 2:  // = K2
        gQuadRot[0] = value*TWO_PI/MAX_DIAL_VAL;
        printProjectionDims();
        break;
      case 3:  // = K3
        gQuadRot[1] = value*TWO_PI/MAX_DIAL_VAL;
        printProjectionDims();
        break;      
      case 4:  // = K4
        gQuadRot[2] = value*TWO_PI/MAX_DIAL_VAL;
        printProjectionDims();
        break;  
        
      case 5:  // = K2
        gMoonPos[0] = value*surface.width/MAX_DIAL_VAL;
        printProjectionDims();
        break;
      case 6:  // = K3
        gMoonPos[1] = value*surface.height/MAX_DIAL_VAL;
        printProjectionDims();
        break;      
      case 7:  // = K3
        gMoonPos[2] = value*height/MAX_DIAL_VAL;
        printProjectionDims();
        break;
      case 8: // = K8
        gQuadScale = 1+value*300.f/MAX_DIAL_VAL;
        printProjectionDims();
        break;  
  
      default:
        break;   
    }
  } 
}

void printProjectionDims()
{
  println("\n===dims===");
  println("gMoonPos = [" + gMoonPos[0] + "," + gMoonPos[1]+ "," + gMoonPos[2] + "]");
  println("gQuadRot = [" + gQuadRot[0] +","+ gQuadRot[1] +","+ gQuadRot[2] +"]" );
  println("gQuadScale = " + gQuadScale); 
}
