// READING INPUT FROM POTENTIOMETER
// 2023.dec13 0918mf

void setup() {
  pinMode(A0, INPUT);
  Serial.begin(9600);
}

void loop() {
  Serial.println((analogRead(A0))*(5./1023));
  delay(700);
}
