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
    case 2: // = K2
      break;  
    case 3: // = K3
      break;  
    case 4: // = K4
      break;  
    case 5: // = K5
      break;  
    default:
      break;   
  } 
}
