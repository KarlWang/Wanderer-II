#include <Servo.h>

// Change this value if you want fast color changes
const int WAIT_TIME_MS = 500;

Servo myservo;
int pos = 0;

void setup() {
  // Configure the serial port and display instructions.
  Serial.begin(9600);
  myservo.attach(9);
}


void loop() {

  // When specific characters are sent we change the current color of the LED.
  if (Serial.available()) {
    int characterRead = Serial.read();

    // If the character matches change the state of the LED,
    // otherwise ignore the character.
    switch(characterRead) {
    case 'a':
      if (pos < 180)
      {
        myservo.write(pos);
        delay(15);
        pos++;
      }
      break;

    case 'b':
      if (pos > 0)
      {
        myservo.write(pos);
        delay(15);
        pos--;
      }      
      break;

    case 'c':
           
      break;

    default:
      // Ignore all other characters and leave the LED
      // in its previous state.
      break;
    }

    delay(WAIT_TIME_MS);
  }

}

