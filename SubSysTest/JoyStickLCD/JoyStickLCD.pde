#include <NewSoftSerial.h>

const int numReadings = 10;

int readings[numReadings];      // the readings from the analog input
int index = 0;                  // the index of the current reading
int total = 0;                  // the running total
int average = 0;                // the average

int inputPin = A0;


NewSoftSerial mySerial(2, 3);

void setup()
{
  // initialize serial communication with computer:
  mySerial.begin(115200);                  
  // initialize all the readings to 0:
  for (int thisReading = 0; thisReading < numReadings; thisReading++)
    readings[thisReading] = 0;  

  //  lcd.clearLCD();
  mySerial.print(0x7C,BYTE);
  mySerial.print(0x00,BYTE);
  delay(10);    
}



void loop() {



  // subtract the last reading:
  // total= total - readings[index];        
  // read from the sensor:  
  readings[index] = analogRead(inputPin);
  // add the reading to the total:
  total= total + readings[index];      
  // advance to the next position in the array:  
  index = index + 1;                    

  // if we're at the end of the array...
  if (index >= numReadings)     
  {  
    // ...wrap around to the beginning:
    index = 0;           

    // calculate the average:
    average = total / numReadings;        
    total = 0;

    mySerial.print(0x7C,BYTE);
    mySerial.print(0x00,BYTE);    
    delay(10);    
    // send it to the computer (as ASCII digits)
    mySerial.print(average);  
    delay(100);  
  }
}

