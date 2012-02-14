#if defined(ARDUINO) && ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif
#include "IRSensor.h"

CIRSensor::CIRSensor(int aSignalPin)
{
  m_iSignalPin = aSignalPin;
}

int CIRSensor::GetSensorVal()
{
  return analogRead(m_iSignalPin);
}

float CIRSensor::GetDistanceVal()
{
  return 12343.85 * pow(analogRead(m_iSignalPin),-1.15);
}

bool CIRSensor::Obstructed(int aObsDis)
{
  //  if (10 < GetDistanceVal() && GetDistanceVal() < 11)
  if (-1 == aObsDis)
    return (GetDistanceVal() < m_iObsDis);
  else
    return (GetDistanceVal() < aObsDis);
}

void CIRSensor::SetObsDis(int aObsDis)
{
  m_iObsDis = aObsDis;
}

