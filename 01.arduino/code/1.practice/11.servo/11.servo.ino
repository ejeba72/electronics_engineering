// Servo
// 2023.dec24 sun 1839mf

#include<Servo.h>

const int servoPin = 9;
int waitTime = 10;

Servo servo;

void setup() {
  servo.attach(servoPin);
}

void loop() {
  int i = 30;
  while(i<150) {
    servo.write(i);
    i++;
    delay(waitTime);
  }
  while(i>29) {
    servo.write(i);
    i--;
    delay(waitTime);
  }
}
