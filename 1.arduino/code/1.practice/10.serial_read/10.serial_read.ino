// READING FROM SERIAL MONITOR
// 2023.dec22 fri 1420mf

String yourName;

void setup() {
  Serial.begin(9600);
}

void loop() {
  Serial.println("What is your name?");
  while (Serial.available()==0) {

  }
  yourName = Serial.readString();
  Serial.print("Your name is ");
  Serial.println(yourName);
}

/*
  void loop() {
  Serial.println("What is your favourite number?");
  while (Serial.available()==0) {}
  yourName = Serial.parseInt();
  Serial.print("Your favourite number is ");
  Serial.println(yourName);
}
*/
