#include <Servo.h>

#include "WandererTrack.h"
#include "WandererMotor.h"
#include "cppfix.h"


#define SERVORIGHT    1800   // Servo position when looking right.
#define SERVOLEFT     1200   // Servo position when looking left.  

CWandererTrack * pwt = new CWandererTrack(7, 5, 6, 9, 8);

Servo wandererServo;

int servoPin = 11;
int curServoPos_L;
int curServoPos_R;
bool obs_L;
bool obs_R;
float fDisVal = 20.00;
float fCntVal = 10.00;

float GetDistanceVal()
{
  return 12343.85 * pow(analogRead(A0), -1.15);
}

int ServoSweep(Servo &aServo, int aDirection)
{
  /*
aDirection
   	0-180 : Specify servo degree
   	188 : Servo degree 0->180
   	199 : Servo degree 180->0
   */
  switch (aDirection)
  {
  case 188 :
    break;
  case 199 :
    break;
  default :
    if (aDirection >= 0 && aDirection <= 180)
    {			
      aServo.write(aDirection);
    }
    break;
  }
}

void Sweep_Move()
{
  int tmpPos;  
  for(tmpPos = 70; tmpPos < 110; tmpPos++)
  {                               
    wandererServo.write(tmpPos);
    delay(15);
  }	

  for(tmpPos = 110; tmpPos > 70; tmpPos--)
  {                               
    wandererServo.write(tmpPos);
    delay(15);
  }	
}

int Sweep_Stop()
{
  int tmpPos;  
  curServoPos_L = 180;
  curServoPos_R = 0;
  obs_L = false;
  obs_R = false;  

  for(tmpPos = 90; tmpPos < 180; tmpPos++)
  {                               
    wandererServo.write(tmpPos);
    if (GetDistanceVal() < fDisVal)
    {
      curServoPos_L = tmpPos; //Obstructed on left
    }
    delay(15);
  }

  for(tmpPos = 180; tmpPos > 90; tmpPos--) 
  {                                
    wandererServo.write(tmpPos); 
    if (GetDistanceVal() < fDisVal)
    {  
      curServoPos_L = tmpPos; //Obstructed on left
    }
    delay(15);
  }

  for (tmpPos = 90; tmpPos > 0; tmpPos--) 
  {
    wandererServo.write(tmpPos);
    if (GetDistanceVal() < fDisVal)
    {  
      curServoPos_R = tmpPos; //Obstructed on right
    }
    delay(15);                    
  }

  for (tmpPos = 0; tmpPos < 90; tmpPos++)
  {
    wandererServo.write(tmpPos);
    if (GetDistanceVal() < fDisVal)
    {
      curServoPos_R= tmpPos; //Obstructed on right  
    }
    delay(15);                   
  }  

  wandererServo.write(tmpPos);
  //  delay(15);
}

void pulseOut(byte pinNumber, int duration)
{
  digitalWrite(servoPin, HIGH);
  delayMicroseconds(duration);
  digitalWrite(servoPin, LOW);
} 

void setup() {  
  wandererServo.attach(servoPin);
  wandererServo.write(90);
  delay(1000);
}

void loop() {
  long dis, disLeft, disRight;
  int numPulses;

  pwt->Forward();
  do
  {
    for (numPulses = 0; numPulses < 10; numPulses++)
    {
      pulseOut(servoPin, SERVOLEFT);
      delay(20);
    } 	
    disLeft = GetDistanceVal();
    delay(25);
    for (numPulses = 0; numPulses < 10; numPulses++)
    {
      pulseOut(servoPin, SERVORIGHT);
      delay(20);
    } 	
    disRight = GetDistanceVal();
    delay(25);
    dis = (disLeft > disRight ? disRight : disLeft);
  }
  while(dis > fDisVal);

  pwt->Stop();
  delay(200);
  Sweep_Stop();
  if (((curServoPos_L - 90) < fCntVal) && ((90 - curServoPos_R) < fCntVal))
  {
    pwt->Reverse();
    delay(300);
    //    pwt->Turn(2, 2);
    //    delay(300);
    if ((curServoPos_L - 90) > (90 - curServoPos_R))
    {
      pwt->Turn(2, 2);
      delay(300);
    }
    else
    {
      pwt->Turn(1, 2);
      delay(300);     
    }    
  }
  else
  {
    if ((curServoPos_L - 90) > (90 - curServoPos_R))
    {
      pwt->Turn(2, 1);
      delay(300);
      pwt->Stop();
      delay(500);
    }
    else
    {
      pwt->Turn(1, 1);
      delay(300);
      pwt->Stop();
      delay(500);      
    }    
  }
}









