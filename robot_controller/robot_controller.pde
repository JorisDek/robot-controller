import controlP5.*;
import processing.serial.*;

Serial port;

ControlP5 controlP5;
int width = 300;
int height = 500;
String allData = "";
String bluetoothReadString = "";
String soutString;
float afstandFloat;
String debugString;
String directionString;
//String printString = "";
//int index = 0;
PFont font;
int value  = 0;
float aanButtonWidth = 50;
float aanButtonHeight = 50;
float aanButtonX = width - aanButtonWidth - 100;
float aanButtonY = height - aanButtonHeight - 25;
float uitButtonWidth = 50;
float uitButtonHeight = 50;
float uitButtonX = width - uitButtonWidth - 25;
float uitButtonY = height - uitButtonHeight - 25;
float arduinoDataPosX = width - 275;
float arduinoDataPosY = 400;

float modusButtonWidth = 50;
float modusButtonHeight = 50;
float modus1ButtonX = 15;
float modus1ButtonY = 15;
float modus2ButtonX = 85;
float modus2ButtonY = 15;
float modus3ButtonX = 160;
float modus3ButtonY = 15;
float modus0ButtonX = 235;
float modus0ButtonY = 15;

float upButtonWidth = 50;
float upButtonHeight = 75;
float upButtonX = 125;
float upButtonY = 75;

float downButtonWidth = 50;
float downButtonHeight = 75;
float downButtonX = 125;
float downButtonY = 250;

float leftButtonWidth = 75;
float leftButtonHeight = 50;
float leftButtonX = 25;
float leftButtonY = 175;

float rightButtonWidth = 75;
float rightButtonHeight = 50;
float rightButtonX = 200;
float rightButtonY = 175;

float middleButtonWidth = 50;
float middleButtonHeight = 50;
float middleButtonX = 125;
float middleButtonY = 175;

float turnLeftButtonX = 50;
float turnLeftButtonY = 100;
float turnRightButtonX = 200;
float turnRightButtonY = 100;

int modus1 = 166;
int modus2 = 167;
int modus3 = 168;
int modus0 = 169;

void setup() {
  
  size(width, height);
  port = new Serial(this, "COM40", 9600);
  
  port.bufferUntil('\n');
  font = loadFont("AgencyFB-Reg-16.vlw");
  textFont(font, 16);
  controlP5 = new ControlP5(this);
   // parameters  : name, minimum, maximum, default value (float), x, y, width, height
  controlP5.addSlider("Stuur",140,40,90,15,350,275,30);
}

void draw() {
  background(0);
  fill(0,255,0);
  rect(aanButtonX,aanButtonY,aanButtonWidth,aanButtonHeight);
  fill(255);
  text("Led AAN",aanButtonX + (aanButtonWidth*0.1),aanButtonY+ (aanButtonHeight*0.7));
  
  fill(255,0, 0);
  rect(uitButtonX,uitButtonY,upButtonWidth,uitButtonHeight);
  fill(255);
  text("Led UIT",uitButtonX + (uitButtonWidth*0.1),uitButtonY+ (uitButtonHeight*0.7));
  
  rect(modus1ButtonX, modus1ButtonY, modusButtonWidth, modusButtonHeight);
  rect(modus2ButtonX,modus2ButtonY,modusButtonWidth,modusButtonHeight);
  rect(modus3ButtonX,modus3ButtonY,modusButtonWidth,modusButtonHeight);
  rect(modus0ButtonX,modus0ButtonY,modusButtonWidth,modusButtonHeight);
  
  
  rect(upButtonX,upButtonY,upButtonWidth,upButtonHeight);
  rect(downButtonX,downButtonY,downButtonWidth,downButtonHeight);
  rect(leftButtonX,leftButtonY,leftButtonWidth,leftButtonHeight);
  rect(rightButtonX,rightButtonY,rightButtonWidth,rightButtonHeight);
  rect(middleButtonX,middleButtonY,middleButtonWidth,middleButtonHeight);

  
  text(bluetoothReadString,100,200);
  if(mousePressed){
    if(mouseX > aanButtonX && 
       mouseX < aanButtonX + aanButtonWidth && 
       mouseY > aanButtonY && 
       mouseY < aanButtonY + aanButtonHeight){
         println("AAN button!");
         port.write("l");
    }
    
    if(mouseX > uitButtonX && 
       mouseX < uitButtonX + uitButtonWidth && 
       mouseY > uitButtonY && 
       mouseY < uitButtonY + uitButtonHeight){
         println("UIT button");
         port.write("k"); 
    }
    
    if(mouseX > upButtonX && 
       mouseX < upButtonX + upButtonWidth && 
       mouseY > upButtonY && 
       mouseY < upButtonY + upButtonHeight){
         println("UP button");
         port.write("W"); 
    }
    
    if(mouseX > downButtonX && 
       mouseX < downButtonX + downButtonWidth && 
       mouseY > downButtonY && 
       mouseY < downButtonY + downButtonHeight){
         println("DOWN button");
         port.write("S"); 
    }
    if(mouseX > leftButtonX && 
       mouseX < leftButtonX + leftButtonWidth && 
       mouseY > leftButtonY && 
       mouseY < leftButtonY + leftButtonHeight){
         println("LEFT button");
         port.write("A"); 
    }
    if(mouseX > rightButtonX && 
       mouseX < rightButtonX + rightButtonWidth && 
       mouseY > rightButtonY && 
       mouseY < rightButtonY + rightButtonHeight){
         println("RIGHT button");
         port.write("D"); 
    }
    if(mouseX > middleButtonX && 
       mouseX < middleButtonX + middleButtonWidth && 
       mouseY > middleButtonY && 
       mouseY < middleButtonY + middleButtonHeight){
         println("MIDDLE button");
         port.write("F"); 
    }
     
    if(mouseX > modus1ButtonX && 
       mouseX < modus1ButtonX + modusButtonWidth && 
       mouseY > modus1ButtonY && 
       mouseY < modus1ButtonY + modusButtonHeight){
         println("MODUS 1 button");
         port.write("1"); 
    }
    if(mouseX > modus2ButtonX && 
       mouseX < modus2ButtonX + modusButtonWidth && 
       mouseY > modus2ButtonY && 
       mouseY < modus2ButtonY + modusButtonHeight){
         println("MODUS 2 button");
         port.write("2"); 
    }
    if(mouseX > modus3ButtonX && 
       mouseX < modus3ButtonX + modusButtonWidth && 
       mouseY > modus3ButtonY && 
       mouseY < modus3ButtonY + modusButtonHeight){
         println("MODUS 3 button");
         port.write("3"); 
    }
    if(mouseX > modus0ButtonX && 
       mouseX < modus0ButtonX + modusButtonWidth && 
       mouseY > modus0ButtonY && 
       mouseY < modus0ButtonY + modusButtonHeight){
         println("MODUS 0 button");
         port.write("0"); 
    }
  } 
  fill(0,255,0);
  text("Data uit arduino: " + debugString + ", " + directionString + ", " + afstandFloat + ".", arduinoDataPosX, arduinoDataPosY);
}
void serialEvent(Serial port) {
  while (port.available() > 0){
    allData = port.readStringUntil('\n');
    println(allData);
   
    //bluetoothReadString = data.substring(0, data.length() - 1);
    String data[] = split(allData, ',');
    debugString = data[0];
    //directionString = data[1];
    
    println(debugString);
    println(directionString);
    //int soutStringIndex = bluetoothReadString.indexOf(",");
    //afstandStringIndex = bluetoothReadString.indexOf(",", soutStringIndex);
    //String soutString = bluetoothReadString.substring(0, soutStringIndex);
    //String afstandString = bluetoothReadString.substring(soutStringIndex + 1, bluetoothReadString.length());
    
  
    //float afstandFloat = float(afstandString);
  }
}

void controlEvent(ControlEvent theEvent) {
  /* events triggered by controllers are automatically forwarded to
     the controlEvent method. by checking the name of a controller one can
     distinguish which of the controllers has been changed.
  */
  /* check if the event is from a controller otherwise you'll get an error
     when clicking other interface elements like Radiobutton that don't support
     the controller() methods
  */
  
  if(theEvent.isController()) {
    float stuurValue = theEvent.controller().value();
    int stuurValueInt = int(stuurValue);
    stuurValueInt = stuurValueInt + 100;
    print("control event from : "+theEvent.controller().name());
    println(", value : "+stuurValueInt);
    port.write(stuurValueInt);
    
    
    
  }
}

  /*
  if(value == '0'){
    if (mousePressed && (mouseButton == LEFT)) {
      port.write(49);
      value = 1;
      
    }
  } else if(value == '1'){
      if (mousePressed && (mouseButton == LEFT)) {
        port.write(48);
        value = 0;
      }
  }

  
  String preString = "Afstand = ";
  String endString = " cm!";
  background(0);

  if (afstandFloat < 30) {
    //text kleur rood
    fill(200, 5, 0);
  }
  else if (afstandFloat < 50) {
    //text kleur blauw
    fill(0, 5, 200);
  } else {
    //text kleur groen
    fill(5, 200, 0);
  }
  text(preString, 25, 100);
  text(printString, 500, 100);
  text(endString, 150, 300);
}

void serialEvent(Serial port) 
{
  data = port.readStringUntil('.');
  afstandString = data.substring(0, data.length() - 1);
  afstandFloat =  float(afstandString);
  println(afstandFloat);


  printString = afstandString;
*/
 


