// Blink LED, more practice.
// 2024feb4 sun 1157mf

// Short and long durations for delay
int shortDelay = 70;
int longDelay = 1000;

// declare function prototypes
extern "C" {
  void setDir();
  void led(byte);
}

void setup() {
  setDir();
}

void loop() {
  led(1);
  delay(shortDelay);
  led(0);
  delay(shortDelay);
  led(1);
  delay(shortDelay);
  led(0);
  delay(longDelay);
}
