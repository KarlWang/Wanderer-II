#include "Servo.h"
#include "IRSensor.h"

#ifndef WANDERERSENSOR_H
#define WANDERERSENSOR_H

class CWandererSensor
{
  //Servo * m_pServo;
  Servo m_Servo;
  CIRSensor * m_pSensor;
  int m_iSensorSignalPin;
  int m_iServoSignalPin;
public:
  CWandererSensor(int aSensorSignalPin, int aServoSignalPin);
  ~CWandererSensor();
  int Reset();
  float Sweep(int aScanAngle);
  float GetDisVal();
};

#endif
