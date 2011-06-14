#include "WProgram.h"
#include "JoyStick.h"
#include "JoyStickAdapter.h"
#include "Interfaces.h"
#include "Command.h"


CJoyStickAdapter::CJoyStickAdapter(int aLeftHPin, int aLeftVPin, int aRightHPin, int aRightVPin)
{
  m_paL = new CJoyStick(aLeftHPin, aLeftVPin);
  m_paR = new CJoyStick(aRightHPin, aRightVPin);
  m_iLeftHValue = -1;
  m_iLeftVValue = -1;
  m_iRightHValue = -1;
  m_iRightVValue = -1;
}

CJoyStickAdapter::~CJoyStickAdapter()
{
  delete m_paL;
  delete m_paR;
}

int CJoyStickAdapter::GetCommand()
{
  m_iLeftVValue = m_paL->GetVValue();
  m_iRightVValue = m_paR->GetVValue();

  if ((m_iLeftVValue > 900) && (m_iRightVValue > 900))
  {
    return VEHICLE_FORWARD;
  }
  else if ((m_iLeftVValue < 100) && (m_iRightVValue < 100))
  {
    return VEHICLE_BACKWARD;
  }
  else if ((315 < m_iLeftVValue && m_iLeftVValue < 715) && (m_iRightVValue > 900))
  {
    return VEHICLE_FORWARD_TURN_LEFT;
  }
  else if ((m_iLeftVValue > 900) && (315 < m_iRightVValue && m_iRightVValue < 715))
  {
    return VEHICLE_FORWARD_TURN_RIGHT;
  }
  else if ((315 < m_iLeftVValue && m_iLeftVValue < 715) && (m_iRightVValue < 100))
  {
    return VEHICLE_BACKWARD_TURN_LEFT;
  }
  else if ((m_iLeftVValue < 100) && (315 < m_iRightVValue && m_iRightVValue < 715))
  {
    return VEHICLE_BACKWARD_TURN_RIGHT;
  }
  else if ((m_iLeftVValue > 900) && (m_iRightVValue < 100))
  {
    return VEHICLE_SPIN_CLOCKWISE;
  }
  else if ((m_iLeftVValue < 100) && (m_iRightVValue > 900))
  {
    return VEHICLE_SPIN_COUNTERCLOCKWISE;
  }
  else if ((315 < m_iLeftVValue && m_iLeftVValue < 715) && (315 < m_iRightVValue && m_iRightVValue < 715))
  {
    return VEHICLE_STOP;
  }
  else
  {
    return -1;
  }	
}


