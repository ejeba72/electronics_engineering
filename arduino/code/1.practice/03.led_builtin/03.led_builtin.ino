// Blinking the arduino's in-built led
// 2023.dec15 fri 1138mf

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(70);
  digitalWrite(LED_BUILTIN, LOW);
  delay(70);
  digitalWrite(LED_BUILTIN, HIGH);
  delay(70);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
