#include "Command.h"
#include "JoyStickAdapter.h"
#include "cppfix.h"

CJoyStickAdapter * pjsa;

void setup() {                
  Serial.begin(9600);
  pjsa = new CJoyStickAdapter(A5, A0, A4, A1);
}

void loop() {
  Serial.println(pjsa->GetCommand());
  delay(1000);
}
