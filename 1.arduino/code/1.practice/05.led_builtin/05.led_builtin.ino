// Blinking builtin leds
// 2023.dec17 sun 1737mf

int shortDelayTime = 100;
int longDelayTime = 100;

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(13, OUTPUT);
}

void loop() {
// For builtin led attached to digital pin 13.
  digitalWrite(13, HIGH);
  delay(shortDelayTime);
  digitalWrite(13, LOW);
  delay(shortDelayTime);

  digitalWrite(13, HIGH);
  delay(shortDelayTime);
  digitalWrite(13, LOW);
  delay(longDelayTime);

// For builtin led with the name "LED_BUILTIN".
  digitalWrite(LED_BUILTIN, HIGH);
  delay(shortDelayTime);
  digitalWrite(LED_BUILTIN, LOW);
  delay(shortDelayTime);

  digitalWrite(LED_BUILTIN, HIGH);
  delay(shortDelayTime);
  digitalWrite(LED_BUILTIN, LOW);
  delay(longDelayTime);

}
