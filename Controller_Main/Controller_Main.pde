#include <NewSoftSerial.h>
#include <serialGLCD.h>
#include "JoyStickAdapter.h"
#include "cppfix.h"
#include "Common.h"

CJoyStickAdapter * pjsa;
int CSettings::SystemModeCode = SYSTEM_MODE_MOVE;
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
    lcd.drawFilledBox(10,10,30,30,0x55);
  }
  else
  {
    lcd.clearLCD();
  }
  
  srlXBee.println(pjsa->GetCommand());
  delay(500);
/*  
  if (HIGH == digitalRead(BUTTON_1_PIN))
  {
    CSettings::SystemModeCode = SYSTEM_MODE_MOVE;	
  }
  else if (HIGH == digitalRead(BUTTON_2_PIN))
  {
    CSettings::SystemModeCode = SYSTEM_MODE_SERVO;	
  }
  else if (HIGH == digitalRead(BUTTON_3_PIN))
  {
  }
  else if (HIGH == digitalRead(BUTTON_4_PIN))
  {
  }

  switch(CSettings::SystemModeCode)
  {
  case SYSTEM_MODE_MOVE:
    srlXBee.print(pjsa->GetCommand());
    delay(1000);
    break;
  case SYSTEM_MODE_SERVO:
    break;
  }
*/  
}

void MenuAction()
{
  EnterMenu = !EnterMenu;
}

