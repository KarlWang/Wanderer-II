#ifndef INTERFACES_H
#define INTERFACES_H


class IJoyStick
{
public:
  virtual int GetHValue() = 0;
  virtual int GetVValue() = 0;
};

#endif
