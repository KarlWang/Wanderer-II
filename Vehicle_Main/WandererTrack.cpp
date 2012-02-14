#if defined(ARDUINO) && ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif
#include "WandererTrack.h"
#include "WandererMotor.h"
#include "Interfaces.h"

CWandererTrack::CWandererTrack(int aStandByPin, int aLeftControlPin1, int aLeftControlPin2, int aRightControlPin1, int aRightControlPin2)
{
  m_iStandByPin = aStandByPin;
  m_iLeftControlPin1 = aLeftControlPin1;
  m_iLeftControlPin2 = aLeftControlPin2;  
  m_iRightControlPin1 = aRightControlPin1;
  m_iRightControlPin2 = aRightControlPin2;   
  
  pinMode(m_iStandByPin, OUTPUT);
  digitalWrite(m_iStandByPin, LOW);
  m_bStandingBy = true;
  
  m_pLeftMotor = new CWandererMotor(m_iLeftControlPin1, m_iLeftControlPin2, A3);
  m_pRightMotor = new CWandererMotor(m_iRightControlPin1, m_iRightControlPin2, A5);
};

CWandererTrack::~CWandererTrack()
{
  delete m_pLeftMotor;
  delete m_pRightMotor;
};

int CWandererTrack::StandBy()
{
  digitalWrite(m_iStandByPin, LOW);
  m_bStandingBy = true;
  return 0;
};

int CWandererTrack::QuitStandBy()
{
  digitalWrite(m_iStandByPin, HIGH);
  m_bStandingBy = false;
  return 0;
};

int CWandererTrack::Forward()
{
  m_pLeftMotor->DoCW();
  m_pRightMotor->DoCW();
  if (m_bStandingBy)
  {
    QuitStandBy();
  }
  return 0;
};

int CWandererTrack::Reverse()
{
  m_pLeftMotor->DoCCW();
  m_pRightMotor->DoCCW();
  if (m_bStandingBy)
  {
    QuitStandBy();
  }
  return 0;
};

/*
* Right turn: aLeftOrRight = 1    
* Left turn: aLeftOrRight = 2
* Normal turn: aTurningMode = 1    
* Sharp turn: aTurningMode = 2
*/
int CWandererTrack::Turn(int aLeftOrRight, int aTurningMode)
{
  if (1 == aLeftOrRight)
  {
    switch (aTurningMode)
    {
    case 1:
      m_pLeftMotor->DoStop();
      m_pRightMotor->DoCW();
      break;
    case 2:
      m_pLeftMotor->DoCCW();
      m_pRightMotor->DoCW();	  
      break;
    default: break;
    }
  }
  else if (2 == aLeftOrRight)
  {
    switch (aTurningMode)
    {
    case 1:
      m_pRightMotor->DoStop();
      m_pLeftMotor->DoCW();
      break;
    case 2:
      m_pRightMotor->DoCCW();
      m_pLeftMotor->DoCW();	  
      break;
    default: break;
    }    
  }
  if (m_bStandingBy)
  {
    QuitStandBy();
  }
  return 0;
};

int CWandererTrack::Turn_Backward_Left()
{
  m_pLeftMotor->DoStop();
  m_pRightMotor->DoCCW();
  if (m_bStandingBy)
  {
    QuitStandBy();
  }
}

int CWandererTrack::Turn_Backward_Right()
{
  m_pLeftMotor->DoCCW();
  m_pRightMotor->DoStop();
  if (m_bStandingBy)
  {
    QuitStandBy();
  }
}

int CWandererTrack::Stop()
{
  StandBy();
  return 0;
};
