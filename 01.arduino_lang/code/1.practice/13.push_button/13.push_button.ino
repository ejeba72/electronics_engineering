// 1151mf sun 19may2024
// PUSH BUTTON FOR LED
// Arduino code as part of my attempt to troubleshoot my assembly code. If this code works, it means my breadboard setup is not the issue.

int blueLedPin = 2;
int redLedPin = 3;
int buttonPin = 4;
int buttonRead;
int dt = 50;
void setup() {
  Serial.begin(9600);
  pinMode(blueLedPin, OUTPUT);
  pinMode(redLedPin, OUTPUT);
  pinMode(buttonPin, INPUT);
}

void loop() {
  buttonRead = digitalRead(buttonPin);
  Serial.println(buttonRead);
  delay(dt);
  if (buttonRead==1) {
    digitalWrite(blueLedPin, HIGH);
    digitalWrite(redLedPin, HIGH);
  } else {
    digitalWrite(blueLedPin, LOW);
    digitalWrite(redLedPin, LOW);
  }
}
