#include <NewSoftSerial.h>
#include "JoyStickAdapter.h"
#include "cppfix.h"
#include "Common.h"

int CWorkingMode::ModeCode = MODE_VEHICLE;
CJoyStickAdapter * pjsa;
NewSoftSerial srlXBee(2, 3);

void setup() {                
  Serial.begin(9600);
	srlXBee.begin(9600);
  pjsa = new CJoyStickAdapter(A5, A0, A4, A1);
	
	pinMode(BUTTON_1_PIN, INPUT);
	pinMode(BUTTON_2_PIN, INPUT);
	pinMode(BUTTON_3_PIN, INPUT);
	pinMode(BUTTON_4_PIN, INPUT);
}

void loop() {
	if (HIGH == digitalRead(BUTTON_1_PIN))
	{
		CWorkingMode::ModeCode = MODE_VEHICLE;	
	}
	else if (HIGH == digitalRead(BUTTON_2_PIN))
	{
		CWorkingMode::ModeCode = MODE_SERVO;	
	}
	else if (HIGH == digitalRead(BUTTON_3_PIN))
	{
	}
	else if (HIGH == digitalRead(BUTTON_4_PIN))
	{
	}

  switch(CWorkingMode::ModeCode)
  {
  case MODE_VEHICLE:
    srlXBee.print(pjsa->GetCommand());
    delay(1000);
    break;
  case MODE_SERVO:
    break;
  }
}

