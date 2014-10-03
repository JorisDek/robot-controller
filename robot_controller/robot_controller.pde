import processing.serial.*;

Serial port;
int width = 300;
int height = 500;
String allData = "";
String bluetoothReadString = "";
String soutString;
float afstandFloat;
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
float arduinoDataPosY = 300;

float upButtonWidth = 50;
float upButtonHeight = 75;
float upButtonX = 125;
float upButtonY = 25;

float downButtonWidth = 50;
float downButtonHeight = 75;
float downButtonX = 125;
float downButtonY = 200;

float leftButtonWidth = 75;
float leftButtonHeight = 50;
float leftButtonX = 25;
float leftButtonY = 125;

float rightButtonWidth = 75;
float rightButtonHeight = 50;
float rightButtonX = 200;
float rightButtonY = 125;

float middleButtonWidth = 50;
float middleButtonHeight = 50;
float middleButtonX = 125;
float middleButtonY = 125;


void setup() {
  
  size(width, height);
  port = new Serial(this, "COM40", 9600);
  
  port.bufferUntil('\n');
  font = loadFont("AgencyFB-Reg-16.vlw");
  textFont(font, 16);
  
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
         port.write("1");
    }
    
    if(mouseX > uitButtonX && 
       mouseX < uitButtonX + uitButtonWidth && 
       mouseY > uitButtonY && 
       mouseY < uitButtonY + uitButtonHeight){
         println("UIT button");
         port.write("0"); 
    }
    
    if(mouseX > upButtonX && 
       mouseX < upButtonX + upButtonWidth && 
       mouseY > upButtonY && 
       mouseY < upButtonY + upButtonHeight){
         println("UP button");
         port.write("UP"); 
    }
    
    if(mouseX > downButtonX && 
       mouseX < downButtonX + downButtonWidth && 
       mouseY > downButtonY && 
       mouseY < downButtonY + downButtonHeight){
         println("DOWN button");
         port.write("DOWN"); 
    }
    if(mouseX > leftButtonX && 
       mouseX < leftButtonX + leftButtonWidth && 
       mouseY > leftButtonY && 
       mouseY < leftButtonY + leftButtonHeight){
         println("LEFT button");
         port.write("LEFT"); 
    }
    if(mouseX > rightButtonX && 
       mouseX < rightButtonX + rightButtonWidth && 
       mouseY > rightButtonY && 
       mouseY < rightButtonY + rightButtonHeight){
         println("RIGHT button");
         port.write("RIGHT"); 
    }
    if(mouseX > middleButtonX && 
       mouseX < middleButtonX + middleButtonWidth && 
       mouseY > middleButtonY && 
       mouseY < middleButtonY + middleButtonHeight){
         println("MIDDLE button");
         port.write("OK"); 
    }
  } 
  fill(0,255,0);
  text("Data uit arduino: " + soutString + ", " + afstandFloat + ".", arduinoDataPosX, arduinoDataPosY);
}
void serialEvent(Serial port) {
  while (port.available() > 0){
    allData = port.readStringUntil('\n');
    println(allData);
   
    //bluetoothReadString = data.substring(0, data.length() - 1);
    String data[] = split(allData, ',');
    String debugString = data[0];
    String afstandString = data[1];
    println(debugString);
    println(afstandString);
    //int soutStringIndex = bluetoothReadString.indexOf(",");
    //afstandStringIndex = bluetoothReadString.indexOf(",", soutStringIndex);
    //String soutString = bluetoothReadString.substring(0, soutStringIndex);
    //String afstandString = bluetoothReadString.substring(soutStringIndex + 1, bluetoothReadString.length());
    
  
    float afstandFloat = float(afstandString);
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
 


