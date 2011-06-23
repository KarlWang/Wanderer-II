#ifndef JOYSTICKADAPTER_H
#define JOYSTICKADAPTER_H

#include "Interfaces.h"

class CJoyStickAdapter
{
  IJoyStick * m_paL, * m_paR;
  int m_iLeftHValue, m_iLeftVValue, m_iRightHValue, m_iRightVValue;
public:
  CJoyStickAdapter(int aLeftHPin, int aLeftVPin, int aRightHPin, int aRightVPin);
  ~CJoyStickAdapter();
  int GetCommand(int aModeCode);
};

#endif


