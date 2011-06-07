#include <Servo.h>
Servo myservo;

int angle = 0;

int getserialnumber()
// function to get an integer from the serial monitor box, i.e. user input
{
  int result=0;
  int q = 0;
  while (Serial.available()==0)
  {
    // do nothing until something comes into the serial buffer
  } 
  while (Serial.available()>0)
  {
    while (Serial.available()>0)
    {
      result=result*10; // move the previous digit to the next column on the left, e.g. 1 becomes 10
      // while there is data in the buffer
      q = Serial.read()-48; // read the next number in the buffer, subtract 48 to convert to the actual number
      result=result+q;
    }
    delay(5); // the processor needs a moment to process
  }
  return result;
}


void setup() {
  myservo.attach(9);
  // Configure the serial port and display instructions.
  Serial.begin(9600);
  delay(2000);
}


void loop() {
  angle=getserialnumber();
  myservo.write(angle);

  // If the character matches change the state of the LED,
  // otherwise ignore the character.
  switch(angle) {
  case 'a':
    break;

  case 'b':   
    break;

  case 'c':
    break;

  default:
    // Ignore all other characters and leave the previous state.
    break;
  }
}





