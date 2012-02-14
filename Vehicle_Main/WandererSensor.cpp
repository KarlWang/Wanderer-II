#if defined(ARDUINO) && ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif
#include "WandererSensor.h"

CWandererSensor::CWandererSensor(int aSensorSignalPin, int aServoSignalPin)
{
  m_iSensorSignalPin = aSensorSignalPin;
  m_iServoSignalPin = aServoSignalPin;
  m_pSensor = new CIRSensor(m_iSensorSignalPin);
  //m_pServo = new Servo();
  //m_pServo->attach(m_iServoSignalPin);
  //m_pServo->write(90);
  m_Servo.attach(m_iServoSignalPin);
  m_Servo.write(90);
}

CWandererSensor::~CWandererSensor()
{
  delete m_pSensor;
//  delete m_pServo;
}

int CWandererSensor::Reset()
{
  //m_pServo->write(90);
  m_Servo.write(120);
  delay(800); //I guess it's enough. It actually runs pretty fast.
  return 0;
}

float CWandererSensor::Sweep(int aScanAngle)
{
  float fLeftLongestDis = 0;
  float fRightLongestDis = 0;
  float fCurDisVal = 0;
  float fHalfScanRange = aScanAngle / 2;
  int i;
  for (i=0; i<fHalfScanRange; i++)
  {
    //m_pServo->write(90 - i);
    m_Servo.write(90-i);
    fCurDisVal = GetDisVal();
    if (fCurDisVal > fLeftLongestDis)
      fLeftLongestDis = fCurDisVal;
    delay(15);
  }
  Reset();
  for (i=0; i<fHalfScanRange; i++)
  {
//    m_pServo->write(90 + i);
    m_Servo.write(90 + i);
    fCurDisVal = GetDisVal();
    if (fCurDisVal > fRightLongestDis)
      fRightLongestDis = fCurDisVal;
    delay(15);
  }  
  Reset();
  if (fRightLongestDis > fLeftLongestDis)
    return (0 - fRightLongestDis);
  else
    return fLeftLongestDis;
}

float CWandererSensor::GetDisVal()
{
  return m_pSensor->GetDistanceVal();
}
