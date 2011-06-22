void setup() {
  Serial.begin(9600);
  pinMode(4, INPUT);
  pinMode(5, INPUT);
  pinMode(6, INPUT);  
}

void loop() {
  int sensorValue4 = digitalRead(4);
  int sensorValue5 = digitalRead(5);
  int sensorValue6 = digitalRead(6);
  
  Serial.print("(4):");
  Serial.println(sensorValue4, DEC);
  
  Serial.print("(5):");
  Serial.println(sensorValue5, DEC);

  Serial.print("(6):");
  Serial.println(sensorValue6, DEC);  
  
  delay(1000);
}
