#include <serialGLCD.h>
#include <NewSoftSerial.h>
#include "JoyStickAdapter.h"
#include "cppfix.h"
#include "Common.h"

int CSettings::SystemModeCode = SYSTEM_MODE_MOVE;
//Temp mode
int	CSettings::SystemModeCode_Current = CSettings::SystemModeCode;
//Save current mode
int CSettings::SystemModeCode_Old = CSettings::SystemModeCode;

CJoyStickAdapter * pjsa;
NewSoftSerial srlXBee(SYSTEM_CON_XBEE_RX, SYSTEM_CON_XBEE_TX);
volatile boolean EnterMenu = 0;

void setup() {                
  Serial.begin(115200);
  srlXBee.begin(9600);
  pjsa = new CJoyStickAdapter(SYSTEM_CON_LEFT_JOYSTICK_V, SYSTEM_CON_LEFT_JOYSTICK_H, 
    SYSTEM_CON_RIGHT_JOYSTICK_V, SYSTEM_CON_RIGHT_JOYSTICK_H);
  attachInterrupt(0, MenuAction , FALLING);    
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
		Menu_Main(CSettings::SystemModeCode_Current);
		
		if (HIGH == digitalRead(BUTTON_2_PIN))
		{
			CSettings::SystemModeCode_Current = Menu_Previous();
		}
		
		if (HIGH == digitalRead(BUTTON_3_PIN))
		{
			CSettings::SystemModeCode_Current = Menu_Next();
		}				
		
		if (HIGH == digitalRead(BUTTON_4_PIN)) // "OK" Button
		{
			//Update current mode
			CSettings::SystemModeCode = CSettings::SystemModeCode_Current;
			//Save current mode
			CSettings::SystemModeCode_Old = CSettings::SystemModeCode;					
			EnterMenu = 0;
		}								
	}
	else
	{
		Display_Mode(CSettings::SystemModeCode);
		switch(CSettings::SystemModeCode)
		{
		case SYSTEM_MODE_MOVE:			
			srlXBee.print(pjsa->GetCommand());
			delay(1000);
			break;
		case SYSTEM_MODE_SERVO:
			break;
		case SYSTEM_MODE_AUTO:
			break;
		case SYSTEM_MODE_STANDBY:
			break;			
		}		
	}
}

void MenuAction()
{
  EnterMenu = !EnterMenu;
}

void Menu_Main(int aCurrentMode)
{

}

int Menu_Next()
{
	return 0;
}

int Menu_Previous()
{
	return 0;
}

void Display_Mode(int aModeCode)
{
}
