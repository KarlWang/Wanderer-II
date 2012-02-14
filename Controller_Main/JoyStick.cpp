#if defined(ARDUINO) && ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif
#include "JoyStick.h"

CJoyStick::CJoyStick(int aJoyStick_H_Pin, int aJoyStick_V_Pin)
{
  m_JoyStick_H_Pin = aJoyStick_H_Pin;
  m_JoyStick_V_Pin = aJoyStick_V_Pin;
}

int CJoyStick::GetHValue()
{
  return analogRead(m_JoyStick_H_Pin);
}

int CJoyStick::GetVValue()
{
  return analogRead(m_JoyStick_V_Pin);
}

