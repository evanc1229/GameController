//
//#define VRX_PIN  A0 // Arduino pin connected to VRX pin
//#define VRY_PIN  A2 // Arduino pin connected to VRY pin

//#define RIGHT_THRESHOLD  400
//#define LEFT_THRESHOLD 800
//#define UP_THRESHOLD    400
//#define DOWN_THRESHOLD  800
//
//#define COMMAND_NO     0x00
//#define COMMAND_RIGHT   0x01
//#define COMMAND_LEFT  0x02
//#define COMMAND_UP     0x04
//#define COMMAND_DOWN   0x08
//
//int xValue = 0 ; // To store value of the X axis
//int yValue = 0 ; // To store value of the Y axis
//int command = COMMAND_NO;
int pot = 0;

const int UpButton = 3;
const int DownButton = 6;
const int LeftButton = 4;
const int RightButton = 5;
const int HomeButton = 2;
const int StickButton = 7;

void setup(){
   Serial.begin(9600);
   pinMode(UpButton, INPUT_PULLUP);
   pinMode(DownButton, INPUT_PULLUP);
   pinMode(LeftButton, INPUT_PULLUP);
   pinMode(RightButton, INPUT_PULLUP);
   pinMode(HomeButton, INPUT_PULLUP);
   pinMode(StickButton, INPUT_PULLUP);
   pinMode(A1, INPUT);
} 

void loop(){
   // Buttons
   if(digitalRead(UpButton) == 0){
    Serial.print("UpB:");
    delay(100);
   }
   if(digitalRead(DownButton) == 0){
    Serial.print("DownB:");
    delay(100);
   }
   if(digitalRead(LeftButton) == 0){
    Serial.print("LeftB:");
    delay(100);
   }
   if(digitalRead(RightButton) == 0){
    Serial.print("RightB:");
    delay(100);
   }
   if(digitalRead(HomeButton) == 0){
    Serial.print("HomeB:");
    delay(100);
   }
   if(digitalRead(StickButton) == 0){
    Serial.print("StickB:");
    delay(100);
   }

   int potNew = analogRead(A1) % 100;
   if(potNew != pot)
   {
     pot = potNew;
     Serial.print("Pot");
     Serial.print(potNew);
     Serial.print(":");
     delay(100);
   }

 /*  //Joystick
   
   // read analog X and Y analog values
  xValue = analogRead(VRX_PIN);
  yValue = analogRead(VRY_PIN);

  // converts the analog value to commands
  // reset commands
  command = COMMAND_NO;

  // check left/right commands
  if (xValue < RIGHT_THRESHOLD)
    command = command | COMMAND_RIGHT;
  else if (xValue > LEFT_THRESHOLD)
    command = command | COMMAND_LEFT;

  // check up/down commands
  if (yValue < UP_THRESHOLD)
    command = command | COMMAND_UP;
  else if (yValue > DOWN_THRESHOLD)
    command = command | COMMAND_DOWN;

  // NOTE: AT A TIME, THERE MAY BE NO COMMAND, ONE COMMAND OR TWO COMMANDS

  // print command to serial and process command
  if (command & COMMAND_LEFT) {
    Serial.println("LEFT:");
  }

  if (command & COMMAND_RIGHT) {
    Serial.println("RIGHT:");
  }

  if (command & COMMAND_UP) {
    Serial.println("UP:");
  }

  if (command & COMMAND_DOWN) {
    Serial.println("DOWN:");
  }
  */
}
