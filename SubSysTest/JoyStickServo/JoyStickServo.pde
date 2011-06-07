/*
 Author:
 Fabio Biondi  <http://www.fabiobiondi.com/blog>
 
*/
 
#include <Servo.h> 
 
const int servo1 = 9; 
const int joyH = A0; 
//const int joyV = 5; 
 
int servoVal; 
 
Servo myservo1; 
 
 
 
void setup() {
  myservo1.attach(servo1);  
  Serial.begin(9600);
}
 
 
void loop(){
 
    outputJoystick();
 
    servoVal = analogRead(joyH);           
    servoVal = map(servoVal, 0, 1023, 0, 180);   
    myservo1.write(servoVal);                    	     
 
    //servoVal = analogRead(joyV);            
    //servoVal = map(servoVal, 0, 1023, 70, 180);     
    //myservo1.write(servoVal);                      	    
 
    delay(15);                                  		  
}
 
 
/**
* Display joystick values
*/
void outputJoystick(){
 
    Serial.print(analogRead(joyH));
    Serial.print ("---");  
    //Serial.print(analogRead(joyV));
    //Serial.println ("----------------");
}
