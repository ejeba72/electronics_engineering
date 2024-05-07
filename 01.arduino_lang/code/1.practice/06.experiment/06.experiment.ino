// Experiment to verify if pin 13 has a relationship with "LED_BUILTIN". The result of the experiment suggests so. This experiment may be better understood in the context of "05.led.builtin.ino" where I thought that the builtin led which we can control with pin 13 is different from the builtin led which we can control by the keyword "LED_BUILTIN".
// 2023.dec17 sun 2112mf

void setup() {
  pinMode(13, OUTPUT);
}

void loop() {
  digitalWrite(13, HIGH);
  delay(800);
  digitalWrite(13, LOW);
  delay(800);
}
