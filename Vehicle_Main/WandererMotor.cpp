#if defined(ARDUINO) && ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif
#include "WandererMotor.h"

CWandererMotor::CWandererMotor(int aControlPin1, int aControlPin2, int aPWMPin)
{
  m_iControlPin1 = aControlPin1;
  m_iControlPin2 = aControlPin2;  
  m_iPWMPin = aPWMPin;  
  pinMode(m_iControlPin1, OUTPUT);
  pinMode(m_iControlPin2, OUTPUT);
  pinMode(m_iPWMPin, OUTPUT);  
  
  m_iStatusCode = -1;
}

int CWandererMotor::GetStatus()
{
  return m_iStatusCode;
};

void CWandererMotor::DoCW()
{ 
  digitalWrite(m_iControlPin1, HIGH);
  digitalWrite(m_iControlPin2, LOW);  
  m_iStatusCode = 1;
};

void CWandererMotor::DoCCW()
{
  digitalWrite(m_iControlPin1, LOW);
  digitalWrite(m_iControlPin2, HIGH);  
  m_iStatusCode = 2;
};

void  CWandererMotor::DoStop()
{
  digitalWrite(m_iControlPin1, LOW);
  digitalWrite(m_iControlPin2, LOW);  
  m_iStatusCode = 0;
};
