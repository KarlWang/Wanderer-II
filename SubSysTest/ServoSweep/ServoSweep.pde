/*
 * 04_Test_Servo_Sweep
 * 
 * Sweep the Hitec HS-55 servo motor through entire range 
 * of motion from 0.6ms to 2.4ms (600 to 2400us).
 * Starts at center position, 1.5ms, safer place to start
 * than at either extreme.
 * Goes by steps of "STEP" so may not exactly hit
 * min or max limits.  Change "STEP" for faster/slower
 * motion.
 *
 * Makey Robot, MAKE Magazine, Volume 19, p. 77
 * Created: June 2009 Kris Magri
 * Modified:
 *
 */

  #define servoPin     11      // Servomotor on pin D10
  #define SERVOMAX     2400    // Max travel at 2.4ms = 2400 microseconds
  #define SERVOMIN     600     // Min travel at 0.6ms =  600 microseconds
  #define SERVOCENTER  1500    // Center at 1.5ms = 1500 microseconds
  #define SERVORIGHT    1800   // Servo position when looking right.
  #define SERVOLEFT     1200   // Servo position when looking left.  
  #define STEP         70      // Decrease for slower motion
  
void pulseOut(byte pinNumber, int duration)
{
  digitalWrite(servoPin, HIGH);
  delayMicroseconds(duration);
  digitalWrite(servoPin, LOW);
}  

// setup
// Set servo as OUTPUT pin.  Move servo to center position.

void setup()                                                 
{
  int index;
  int pulseWidth; 
  
  pinMode(servoPin, OUTPUT);
  
  // move servo to center position
  for (index = 0; index < 100; index++)
  {
    digitalWrite(servoPin, HIGH);
    delayMicroseconds(SERVOCENTER);
    digitalWrite(servoPin, LOW);
    delay(20);
  }

  for (pulseWidth = SERVOCENTER;pulseWidth >=SERVOMIN;pulseWidth -= STEP)
  {
    digitalWrite(servoPin, HIGH);
    delayMicroseconds(pulseWidth);
    digitalWrite(servoPin, LOW);
    delay(20);
  }  
}


// Main program
// Sweep servo down to minimum, then up to maximum, back to center.
// Repeat.

void loop()                    
{
  int numPulses;  
  for (numPulses = 0; numPulses < 100; numPulses++)
  {
    pulseOut(servoPin, SERVOLEFT);
    delay(20);
  }   
  
  for (numPulses = 0; numPulses < 100; numPulses++)
  {
    pulseOut(servoPin, SERVORIGHT);
    delay(20);
  }  
/*
  int index;
  int pulseWidth;                          // Between 600 and 2400us.
 
  // Sweep servo from center to minimum.
  for (pulseWidth = SERVOCENTER;pulseWidth >=SERVOMIN;pulseWidth -= STEP)
  {
    digitalWrite(servoPin, HIGH);
    delayMicroseconds(pulseWidth);
    digitalWrite(servoPin, LOW);
    delay(20);
  } 

  // Sweep servo up from minimum to maximum.
  for (pulseWidth = SERVOMIN; pulseWidth <= SERVOMAX ; pulseWidth+= STEP)
  {
    digitalWrite(servoPin, HIGH);
    delayMicroseconds(pulseWidth);
    digitalWrite(servoPin, LOW);
    delay(20);
  } 

  // Sweep servo down from maximum to center.
  for (pulseWidth = SERVOMAX; pulseWidth >= SERVOCENTER;pulseWidth-=STEP)
  {
    digitalWrite(servoPin, HIGH);
    delayMicroseconds(pulseWidth);
    digitalWrite(servoPin, LOW);
    delay(20);
  } 
*/  
} // End main program. 
