// Blink LED, 5th iteration
// 2024feb4 sun 1440mf

extern "C" {
  void setDir();
  void led(byte);
}

void setup() {
  setDir();
}

void loop() {
  led(1);
  led(0);
}
