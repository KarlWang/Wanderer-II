const int joyH = A0; 
int servoVal;
//const int joyV = 5; 

void setup() {  
  Serial.begin(9600);
}

void loop(){
    servoVal = analogRead(joyH);           
    servoVal = map(servoVal, 0, 1023, 0, 180);   
    Serial.print(servoVal);                    	     
 
    //servoVal = analogRead(joyV);            
    //servoVal = map(servoVal, 0, 1023, 70, 180);     
    //myservo1.write(servoVal);                      	    
 
    delay(100);                                  		  
}

