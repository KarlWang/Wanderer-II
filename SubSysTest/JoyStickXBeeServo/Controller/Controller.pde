//const int joyH = A0; 
int servoVal;
const int joyV = A1; 

void setup() {  
  Serial.begin(9600);
}

void loop(){
    servoVal = analogRead(joyV);           
    //servoVal = map(servoVal, 0, 1023, 0, 180);   
    Serial.println(servoVal);                    	     
 
    //servoVal = analogRead(joyV);            
    //servoVal = map(servoVal, 0, 1023, 70, 180);     
    //myservo1.write(servoVal);                      	    
 
    delay(1000);                                  		  
}

