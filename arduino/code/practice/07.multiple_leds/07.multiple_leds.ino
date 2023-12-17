// Blinking multiple LEDs
// 2023.dec17 sun 2218mf

// Red - 5x
// Green - 10x
// Blue - 15x

int delayTime = 700;
int redPin = 2;
int greenPin = 3;
int bluePin = 4;

void setup() {
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);
}

void loop() {

  int i = 0;
  while (i<5) {
    digitalWrite(redPin, HIGH);
    delay(delayTime);
    digitalWrite(redPin, LOW);
    delay(delayTime);
    i++;
  } 

  // i = 0;    // This may not be necessary
  while (i<10) {
    digitalWrite(greenPin, HIGH);
    delay(delayTime);
    digitalWrite(greenPin, LOW);
    delay(delayTime);
    i++;
  }

  // i = 0;   // This may not be necessary
  while (i<15) {
    digitalWrite(bluePin, HIGH);
    delay(delayTime);
    digitalWrite(bluePin, LOW);
    delay(delayTime);
    i++;
  }

/*
  digitalWrite(redPin, HIGH);
  delay(delayTime);
  digitalWrite(redPin, LOW);
  delay(delayTime);

  digitalWrite(redPin, HIGH);
  delay(delayTime);
  digitalWrite(redPin, LOW);
  delay(delayTime);
*/

}
