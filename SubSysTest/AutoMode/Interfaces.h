#ifndef INTERFACES_H
#define INTERFACES_H


class ISensorGroup
{
  int iStatusCode;
public:
  virtual int StartScan() = 0;
  virtual int StopScan() = 0;
  virtual int GetStatus() = 0;
};

class IDCMotor
{
public:
  virtual void DoCW() = 0;
  virtual void DoCCW() = 0;
  virtual void DoStop() = 0;
  virtual int GetStatus() = 0;
};

#endif
