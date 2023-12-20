// SOS Morse Code
// 2023.dec18 mon 1713mf

int morsePin = 2;
int sTime = 150;
int oTime = 800;

void setup() {
  pinMode(morsePin, OUTPUT);
}

void loop() {
// For letter S
  int i = 0;
  while (i<2) {
    digitalWrite(morsePin, HIGH);
    delay(sTime);
    digitalWrite(morsePin, LOW);
    delay(sTime);
    i++;
  }
  digitalWrite(morsePin, HIGH);
  delay(sTime);
  digitalWrite(morsePin, LOW);
  delay(oTime);

// For letter O
  i = 0;
  while (i<3) {
    digitalWrite(morsePin, HIGH);
    delay(oTime);
    digitalWrite(morsePin, LOW);
    delay(oTime);
    i++;
  }

// For letter S
  i = 0;
  while (i<2) {
    digitalWrite(morsePin, HIGH);
    delay(sTime);
    digitalWrite(morsePin, LOW);
    delay(sTime);
    i++;
  }
  digitalWrite(morsePin, HIGH);
  delay(sTime);
  digitalWrite(morsePin, LOW);
  delay(oTime);
}
