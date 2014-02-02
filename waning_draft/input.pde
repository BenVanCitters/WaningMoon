// http://www.openprocessing.org/visuals/?visualID=6268
// wrestled into VJ compatible MIDI form by Jay Silence

import themidibus.*;
 boolean debug=false;
// MIDI bus for parameter input via Akai LPD8
MidiBus myBus;

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
  }
}


final int NO_GRAPHIC_MODE=0;
final int RED_MOON_MODE=1;
final int BLUE_MOON_MODE=2;
final int RAIN_MODE=3;

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
      break;   
    case 37:
      gCurrentGraphicMode = RED_MOON_MODE;
      break;   
    case 38:
      gCurrentGraphicMode = BLUE_MOON_MODE;
      break;   
    case 39:
      gCurrentGraphicMode = RAIN_MODE;
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
 
float gMoonPhase = 0.f;
float gULRad = 0.f;
float gURRad = 0.f;
float gLLRad = 0.f;
float gLRRad = 0.f;
float gMoonPos[] = new float[]{0.f,0.f,0.f};

float[] gQuadRot = new float[]{0.f,0.f,0.f};
float gQuadScale = 0.f;
void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  if(debug) {
    print("Controller Change - ");
    print("Channel "+channel);
    print(" - Number "+number);
    println(" - Value "+value);
  }
   
  switch(number){
    case 1:  // = K1
      gMoonPhase = value*TWO_PI/128.f;
      println("gMoonPhase = " + gMoonPhase);
      break;

    case 2:  // = K2
      gQuadRot[0] = value*TWO_PI/128.f;
      println("gQuadRot = [" + gQuadRot[0] +","+ gQuadRot[1] +","+ gQuadRot[2] +"]" );
      break;
    case 3:  // = K3
      gQuadRot[1] = value*TWO_PI/128.f;
      println("gQuadRot = [" + gQuadRot[0] +","+ gQuadRot[1] +","+ gQuadRot[2] +"]" );
      break;      
    case 4:  // = K4
      gQuadRot[2] = value*TWO_PI/128.f;
      println("gQuadRot = [" + gQuadRot[0] +","+ gQuadRot[1] +","+ gQuadRot[2] +"]" );
      break;  
      
    case 5:  // = K2
      gMoonPos[0] = value*width/128.f;
      println("gMoonPos = [" + gMoonPos[0] + "," + gMoonPos[1]+ "," + gMoonPos[2] + "]");
      break;
    case 6:  // = K3
      gMoonPos[1] = value*height/128.f;
      println("gMoonPos = [" + gMoonPos[0] + "," + gMoonPos[1]+ "," + gMoonPos[2] + "]");
      break;      
    case 7:  // = K3
      gMoonPos[2] = value*height/128.f;
      println("gMoonPos = [" + gMoonPos[0] + "," + gMoonPos[1]+ "," + gMoonPos[2] + "]");
      break;
    case 8: // = K8
      gQuadScale = value*20.f/128.f;
      println("gQuadScale = " + gQuadScale);    
      break;  

//original control      
//    case 2:  // = K2
//      gMoonPos[0] = value*width/128.f;
//      println("gMoonPhase.x = " + gMoonPos[0]);
//      break;
//    case 3:  // = K3
//      gMoonPos[1] = value*height/128.f;
//      println("gMoonPhase.y = " + gMoonPos[1]);
//      break;      
//      
//    case 5: // = K5
//      gULRad = value*height/128.f;
//      println("gULRad = " + gULRad);
//      break;  
//    case 6: // = K6
//      gURRad = value*height/128.f;
//      println("gURRad = " + gURRad);    
//      break;  
//    case 7: // = K7
//      gLLRad = value*height/128.f;
//      println("gLLRad = " + gLLRad);    
//      break;  
//    case 8: // = K8
//      gLRRad = value*height/128.f;
//      println("gLRRad = " + gLRRad);    
//      break;  
    default:
      break;   
  } 
}
