#ifndef JOYSTICK_H
#define JOYSTICK_H

#include "Interfaces.h"

class CJoyStick : public IJoyStick
{
  int m_JoyStick_H_Pin;
  int m_JoyStick_V_Pin;
public:
  CJoyStick(int aJoyStick_H_Pin, int aJoyStick_V_Pin);
  int GetHValue();
  int GetVValue();
};

#endif

