void setup()
{
  Serial.begin(9600);
}

void loop()
{
  Serial.print("Value:");
  Serial.println(GetSerialFloat());
  delay(2000);
}

float GetSerialFloat()
{
  char cstrNum[128];
  int iCount = 0;
  while (Serial.available() == 0)
  {
    // do nothing until something comes into the serial buffer
  } 
  while (Serial.available() > 0)
  {
    while (Serial.available() > 0)
    {
      cstrNum[iCount++] = Serial.read();
    }
    delay(5); // the processor needs a moment to process
  }
  return atof(cstrNum);  
}

float Temp()
{
  char cstrNum[256];
  int iCount = 0;
  while (Serial.available()==0)
  {
    // do nothing until something comes into the serial buffer
  } 
  while (Serial.available() > 0)
  {
    cstrNum[iCount++] = Serial.read();
    delay(5);
  }
  //cstrNum[iCount] = '\0';
  return atof(cstrNum);   
}
