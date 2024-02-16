// BLINK AN LED IN ASSEMBLY
// 2024feb4 sun 0803mf

extern "C" {
  void start();
  void led(byte);
}

void setup() {
  start();
}

void loop() {
  led(1);
  delay(70);
  led(0);
  delay(70);
  led(1);
  delay(70);
  led(0);
  delay(1000);
}
