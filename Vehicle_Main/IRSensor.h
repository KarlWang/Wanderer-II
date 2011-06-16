#ifndef IRSENSOR_H
#define IRSENSOR_H

class CIRSensor
{
  int m_iSignalPin;
  int m_iObsDis;
public:
  CIRSensor(int aSignalPin);  
  int GetSensorVal();
  float GetDistanceVal();
  bool Obstructed(int aObsDis = -1);
  void SetObsDis(int aObsDis);
};

#endif

