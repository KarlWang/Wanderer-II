#include "Interfaces.h"

#ifndef WANDERERTRACK_H
#define WANDERERTRACK_H

#define TURN_LEFT 1
#define TURN_RIGHT 2
#define NORMAL_TURN 1
#define SHARP_TURN 2

class CWandererTrack
{
  IDCMotor * pLeftMotor, * pRightMotor;
  bool m_bStandingBy;
  int m_iStandByPin;
  int m_iLeftControlPin1;
  int m_iLeftControlPin2;  
  int m_iRightControlPin1;
  int m_iRightControlPin2;   
  IDCMotor * m_pLeftMotor;
  IDCMotor * m_pRightMotor;
  int StandBy();
  int QuitStandBy();
public:
  CWandererTrack(int aStandByPin, int aLeftControlPin1, int aLeftControlPin2, int aRightControlPin1, int aRightControlPin2);
  ~CWandererTrack();
  int Forward();
  int Reverse();
  int Turn(int, int);
	int Turn_Backward_Left();
	int Turn_Backward_Right();
  int Stop();
};

#endif
