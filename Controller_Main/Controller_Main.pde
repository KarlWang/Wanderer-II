#include <serialGLCD.h>
#include <NewSoftSerial.h>
#include "JoyStickAdapter.h"
#include "cppfix.h"
#include "Common.h"

int CSettings::SystemModeCode = SYSTEM_MODE_MENU;
//Temp mode
int	CSettings::SystemModeCode_Current = CSettings::SystemModeCode;
//Save current mode
int CSettings::SystemModeCode_Old = CSettings::SystemModeCode;

CJoyStickAdapter * pjsa;
NewSoftSerial srlXBee(SYSTEM_CON_XBEE_RX, SYSTEM_CON_XBEE_TX);
volatile boolean EnterMenu = 0;
bool WriteLCD = true;

void setup() {                
  Serial.begin(115200);
  srlXBee.begin(9600);
  pjsa = new CJoyStickAdapter(SYSTEM_CON_LEFT_JOYSTICK_V, SYSTEM_CON_LEFT_JOYSTICK_H, 
  SYSTEM_CON_RIGHT_JOYSTICK_V, SYSTEM_CON_RIGHT_JOYSTICK_H);
  attachInterrupt(0, MenuInterruption , FALLING);    
}

serialGLCD lcd;

void loop() {
  if (EnterMenu)
  {
    CSettings::SystemModeCode = SYSTEM_MODE_MENU;    
  }
  else
  {
    CSettings::SystemModeCode = CSettings::SystemModeCode_Old;
  }

  if (CSettings::SystemModeCode == SYSTEM_MODE_MENU)
  {    
    if (WriteLCD)
    {
      Menu_Main(CSettings::SystemModeCode_Current);
      WriteLCD = false;
      srlXBee.print(VEHICLE_COM_STANDBY);
    }

    if (HIGH == digitalRead(BUTTON_2_PIN))
    {
      CSettings::SystemModeCode_Current = Menu_Previous();
      WriteLCD = true;
      delay(300);
    }
    else if (HIGH == digitalRead(BUTTON_3_PIN))
    {
      CSettings::SystemModeCode_Current = Menu_Next();
      WriteLCD = true;     
      delay(300);      
    }				
    else if (HIGH == digitalRead(BUTTON_4_PIN)) // "OK" Button
    {
      //Update current mode
      CSettings::SystemModeCode = CSettings::SystemModeCode_Current;
      //Save current mode
      CSettings::SystemModeCode_Old = CSettings::SystemModeCode;
      //Send command to vehicle
      switch(CSettings::SystemModeCode)
      {
      case SYSTEM_MODE_MOVE:			
        srlXBee.print(VEHICLE_COM_MOVE);
        break;
      case SYSTEM_MODE_SERVO:
        srlXBee.print(VEHICLE_COM_SERVO);
        break;
      case SYSTEM_MODE_AUTO:
        srlXBee.print(VEHICLE_COM_AUTO);      
        break;
      case SYSTEM_MODE_STANDBY:
        srlXBee.print(VEHICLE_COM_STANDBY);      
        break;			
      }		
      delay(100);			
      EnterMenu = 0;
      WriteLCD = true;
    }								
  }
  else
  {
    //if (WriteLCD)
    //{
    if ((millis() / 1000) % 2 == 0)
    {
      if (srlXBee.available())
        Display_Mode(CSettings::SystemModeCode);
    }      
    //  WriteLCD = false;
    //}      
    switch(CSettings::SystemModeCode)
    {
    case SYSTEM_MODE_MOVE:			
      srlXBee.print(pjsa->GetCommand(SYSTEM_MODE_MOVE));
      delay(15);
      break;
    case SYSTEM_MODE_SERVO:
      srlXBee.print(pjsa->GetCommand(SYSTEM_MODE_SERVO));
      delay(15);    
      break;
    case SYSTEM_MODE_AUTO:
      break;
    case SYSTEM_MODE_STANDBY:
      break;			
    }		
  }
}

void MenuInterruption()
{
  EnterMenu = !EnterMenu;   
  CSettings::SystemModeCode_Current = SYSTEM_MODE_MOVE; 
  WriteLCD = true;
}

void Menu_Main(int aCurrentMode)
{
  lcd.clearLCD();
  lcd.gotoLine(3);
  switch(aCurrentMode)
  {
  case SYSTEM_MODE_MENU:			
    Serial.print("      WELCOME TO");
    lcd.gotoLine(5);
    Serial.print("     WANDERER-II!");
    lcd.gotoLine(8);
    Serial.print("  Please Select Mode");
    break;    
  case SYSTEM_MODE_MOVE:			
    Serial.print("     Mode:Vehicle");
    lcd.gotoLine(8);
    Serial.print("Cancel             OK");    
    break;
  case SYSTEM_MODE_SERVO:
    Serial.print("     Mode:Servo");
    lcd.gotoLine(8);
    Serial.print("Cancel             OK");     
    break;
  case SYSTEM_MODE_AUTO:
    Serial.print("     Mode:Auto");
    lcd.gotoLine(8);
    Serial.print("Cancel             OK");     
    break;
  }	
}

int Menu_Next()
{
  int iModeCode;
  iModeCode = CSettings::SystemModeCode_Current;
  if ((iModeCode + 1) > 3)
    return 1;
  else
    return (iModeCode + 1);
}

int Menu_Previous()
{
  int iModeCode;
  iModeCode = CSettings::SystemModeCode_Current;
  if ((iModeCode - 1) < 1)
    return 3;
  else
    return (iModeCode - 1);
}

void Display_Mode(int aCurrentMode)
{
  lcd.clearLCD();
  lcd.gotoLine(3);
  Serial.print("IR Sensor: ");
  Serial.print(GetSerialFloat());  
  lcd.gotoLine(8);
  switch(aCurrentMode)
  { 
  case SYSTEM_MODE_MOVE:			
    Serial.print("Mode: Vehicle");      
    break;
  case SYSTEM_MODE_SERVO:
    Serial.print("Mode: Servo"); 
    break;
  case SYSTEM_MODE_AUTO:
    Serial.print("Mode: Auto");     
    break;
  }
}

float GetSerialFloat()
{
  char * cstrNum = 0;
  int iCount = 0;
  while (srlXBee.available()==0)
  {
    // do nothing until something comes into the serial buffer
  } 
  while (srlXBee.available() > 0)
  {
    while (srlXBee.available() > 0)
    {
      cstrNum[iCount++] = srlXBee.read();
    }
    delay(5); // the processor needs a moment to process
  }
  return atof(cstrNum);  
}

