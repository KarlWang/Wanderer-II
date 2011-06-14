#ifndef JOYSTICK_H
#define JOYSTICK_H

class CJoyStick
{
  int m_iJoyStick_H_Value;
  int m_iJoyStick_V_Value;
public:
  CJoyStick(int aJoyStick_H_Pin, int aJoyStick_V_Pin);
  ~CJoyStick();
};

#endif
