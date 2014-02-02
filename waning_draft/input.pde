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
final int RAIN1_MODE=4;
final int LETTER_MODE=5;
final int RAIN2_MODE=6;
final int RAIN3_MODE=7;
final int FIRE2_MODE=8;
int gCurrentGraphicMode = NO_GRAPHIC_MODE;
int gLastGraphicMode = NO_GRAPHIC_MODE;
// MIDI Event handling
void noteOn(int channel, int pad, int velocity) {
  // Receive a noteOn
  if(debug) {
    print("Note On - ");
    print("Channel "+channel);
    print(" - Pad "+pad);
    println(" - Value: "+velocity);
  }
  defaultScreenClear();
  switch(pad){
    case 36:
      gCurrentGraphicMode = BLUE_MOON_MODE;
      println("BLUE_MOON_MODE enabled");
      break;
    case 37:
      gCurrentGraphicMode = RED_MOON_MODE;
      println("RED_MOON_MODE enabled");
      break;   
    case 38:
      gCurrentGraphicMode = LETTER_MODE;     
      println("LETTER_MODE enabled");
      gLetterStartTime = millis();
      break;      
    case 39:
      gCurrentGraphicMode = FIRE_MODE;
      println("Supernova/FIRE_MODE enabled");
      break;
    case 40:
      gCurrentGraphicMode = RAIN1_MODE;     
      println("blue rain/RAIN1_MODE enabled"); 
      break;            
    case 41:
       gCurrentGraphicMode = RAIN2_MODE;
      println("black rain/RAIN2_MODE enabled");
      break;   
    case 42:
      gCurrentGraphicMode = RAIN3_MODE;     
      println("Muddled Rain RAIN3_MODE enabled"); 
      break;
    case 43:
      gCurrentGraphicMode = FIRE2_MODE;     
      println("FIRE2_MODE enabled"); 
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
float gMoonPos[] = new float[]{536.0,391.0,399.0};
float[] gQuadRot = new float[]{6.2831855,0.0,0.0};
float gQuadScale = 270.29135f;
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
        gMoonPhase = 5.63f-value*(5.63f-.70f)/MAX_DIAL_VAL;
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
        
      case 5:  // = K2 xPos
        gMoonPos[0] = 300+value*surface.width/MAX_DIAL_VAL;
        printProjectionDims();
        break;
      case 6:  // = K3 yPos
        gMoonPos[1] = value*surface.height/MAX_DIAL_VAL;
        printProjectionDims();
        break;      
      case 7:  // = K7 zpos
        gMoonPos[2] = value*height/MAX_DIAL_VAL;
        printProjectionDims();
        break;
      case 8: // = K8 scale
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
