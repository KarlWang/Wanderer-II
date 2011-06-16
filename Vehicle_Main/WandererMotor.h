#ifndef WANDERERMOTOR_H
#define WANDERERMOTOR_H

#include "Interfaces.h"

class CWandererMotor : public IDCMotor
{
  int m_iControlPin1;
  int m_iControlPin2;
  int m_iPWMPin;
  int m_iStatusCode;
public:
  CWandererMotor(int aControlPin1, int aControlPin2, int aPWMPin);
  void DoCW();
  void DoCCW();
  void DoStop();
  int GetStatus();
};

#endif
