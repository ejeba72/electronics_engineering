// PASSIVEBUZZ CODE
// 2023.dec13 wed 1252mf

void setup() {
  pinMode(3, OUTPUT);
}

void loop() {
  analogWrite(3, 3);
  delay(300);
  analogWrite(3, 0);
  delay(300);
}
