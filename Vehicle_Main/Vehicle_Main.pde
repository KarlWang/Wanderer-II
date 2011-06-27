#include <Servo.h>

#include "WandererTrack.h"
#include "WandererMotor.h"
#include "WandererSensor.h"
#include "IRSensor.h"
#include "cppfix.h"
#include "Common.h"

CWandererTrack * pwt = new CWandererTrack(7, 5, 6, 9, 8);
CIRSensor * pirs = new CIRSensor(A0);


Servo wandererServo;

int CSettings::SystemModeCode = SYSTEM_MODE_STANDBY;
int CSettings::ServoPos_Current = -1;
int iComNum = -1;


int curServoPos_L;
int curServoPos_R;
bool obs_L;
bool obs_R;

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

void ServoFastSweep()
{
  wandererServo.write(0);
  delay(2000);
  wandererServo.write(180);
  delay(2000);
  wandererServo.write(90);  
}

int KeepSweeping()
{
  int tmpPos;  
  curServoPos_L = 180;
  curServoPos_R = 0;
  obs_L = false;
  obs_R = false;  

  for(tmpPos = 90; tmpPos < 180; tmpPos++)
  {                               
    wandererServo.write(tmpPos);
    if (pirs->Obstructed(11))
    {
      curServoPos_L = tmpPos; //Obstructed on left
    }
    delay(15);
  }

  for(tmpPos = 180; tmpPos > 90; tmpPos--) 
  {                                
    wandererServo.write(tmpPos); 
    if (pirs->Obstructed(11))
    {  
      curServoPos_L = tmpPos; //Obstructed on left
    }
    delay(15);
  }

  for (tmpPos = 90; tmpPos > 0; tmpPos-=1) 
  {
    wandererServo.write(tmpPos);
    if (pirs->Obstructed(11))
    {  
      curServoPos_R = tmpPos; //Obstructed on right
    }
    delay(15);                    
  }

  for (tmpPos = 0; tmpPos < 90; tmpPos++)
  {
    wandererServo.write(tmpPos);
    if (pirs->Obstructed(11))
    {
      curServoPos_R= tmpPos; //Obstructed on right  
    }
    delay(15);                   
  }  

  wandererServo.write(90);
  delay(15);
}

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

  CSettings::SystemModeCode = SYSTEM_MODE_STANDBY;
  CSettings::ServoPos_Current = -1;

  pinMode(13, OUTPUT); //red
  pinMode(12, OUTPUT); //green  
  delay(1000);
}

void loop() {
  iComNum = GetSerialNumber();
  switch (iComNum)
  {
  case VEHICLE_COM_MOVE :
    CSettings::SystemModeCode = SYSTEM_MODE_MOVE;
    break;
  case VEHICLE_COM_SERVO :
    CSettings::SystemModeCode = SYSTEM_MODE_SERVO;
    break;
  case VEHICLE_COM_AUTO :
    CSettings::SystemModeCode = SYSTEM_MODE_AUTO;
    KeepSweeping();  
    if ((curServoPos_L - 90) > (90 - curServoPos_R))
    {
      pwt->Turn(2, 1);
      delay(500);
    }
    else
    {
      pwt->Turn(1, 1);
      delay(500);
    } 		
    break;
  case VEHICLE_COM_STANDBY :
    CSettings::SystemModeCode = SYSTEM_MODE_STANDBY;
    break;
  default:
    break;
  }
      

  switch (CSettings::SystemModeCode)
  {
  case SYSTEM_MODE_MOVE :
    Serial.print(pirs->GetDistanceVal(), 2);
    CSettings::ServoPos_Current = -1;
    switch(iComNum)
    {
    case VEHICLE_FORWARD :
      pwt->Forward();
      break;
    case VEHICLE_BACKWARD :
      pwt->Reverse();
      break;
    case VEHICLE_FORWARD_TURN_LEFT :
      pwt->Turn(2, 1);
      break;
    case VEHICLE_FORWARD_TURN_RIGHT :
      pwt->Turn(1, 1);
      break;
    case VEHICLE_BACKWARD_TURN_LEFT :
      pwt->Turn_Backward_Left();
      break;
    case VEHICLE_BACKWARD_TURN_RIGHT :
      pwt->Turn_Backward_Right();
      break;
    case VEHICLE_SPIN_CLOCKWISE :
      pwt->Turn(1, 2);
      break;
    case VEHICLE_SPIN_COUNTERCLOCKWISE :
      pwt->Turn(2, 2);
      break;
    case VEHICLE_STOP :
      pwt->Stop();
      break;	
    default :
      break;
    }
    break;
  case SYSTEM_MODE_SERVO :
    Serial.print(pirs->GetDistanceVal(), 2);
    if (-1 == CSettings::ServoPos_Current)
    {	
      CSettings::ServoPos_Current = 90;
      delay(1000);
    }		
    switch(iComNum)
    {
    case VEHICLE_FORWARD :
      pwt->Forward();
      break;
    case VEHICLE_BACKWARD :
      pwt->Reverse();
      break;
    case VEHICLE_SPIN_CLOCKWISE :
      pwt->Turn(1, 2);
      break;
    case VEHICLE_SPIN_COUNTERCLOCKWISE :
      pwt->Turn(2, 2);
      break;
    case VEHICLE_STOP :
      pwt->Stop();
      break;	
    case SERVO_COUNTERCLOCKWISE :
      wandererServo.write(--CSettings::ServoPos_Current);
      break;
    case SERVO_CLOCKWISE :
      wandererServo.write(++CSettings::ServoPos_Current);
      break;
    default :
      break;
    }		
    break;
  case SYSTEM_MODE_AUTO :
    Serial.print(pirs->GetDistanceVal(), 2);
    CSettings::ServoPos_Current = -1;
    if (pirs->Obstructed(11))
    {
      pwt->Stop();
      delay(1000);
      KeepSweeping();
      if ((curServoPos_L - 90) > (90 - curServoPos_R))
      {
        pwt->Turn(2, 1);
        delay(500);
        pwt->Stop();
        delay(500);
      }
      else
      {
        pwt->Turn(1, 1);
        delay(500);
        pwt->Stop();
        delay(500);      
      }    
    }
    else
      pwt->Forward();		
    break;
  case SYSTEM_MODE_STANDBY :
    CSettings::ServoPos_Current = -1;
    pwt->Stop();
    /*
    digitalWrite(12, LOW);
     digitalWrite(13, HIGH);   
     delay(1000);             
     digitalWrite(13, LOW);    
     delay(1000);     					
     break;
     */
  default:
    break;
  }	  			
}




