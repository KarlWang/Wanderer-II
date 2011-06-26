#include <Servo.h>


Servo wandererServo;

int SystemModeCode = 999;
int ServoPos_Current = -1;
int iComNum = -1;



int GetSerialNumber()
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
  Serial.begin(9600);
  wandererServo.attach(11);
  wandererServo.write(90);

  SystemModeCode = 999;
  ServoPos_Current = -1;
}

void loop() {
  iComNum = GetSerialNumber();

  //Serial.print(pirs->GetDistanceVal());
  if (-1 == ServoPos_Current)
  {	
    ServoPos_Current = 90;
    delay(1000);
  }		
  switch(iComNum)
  {
  case 201 :

    break;
  case 211 :
 
    break;
  case 271 :
  
    break;
  case 261 :
  
    break;
  case 281 :

    break;	
  case 199 :
    wandererServo.write(++ServoPos_Current);
    break;
  case 188 :
    wandererServo.write(--ServoPos_Current);
    break;
  default :
    break;
  }		
}




