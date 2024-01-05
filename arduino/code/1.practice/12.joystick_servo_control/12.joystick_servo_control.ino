// Joystick-controlled Servo
// 2023.dec24 sun 2316mf
// 2023.dec27 wed 0626mf
/*
Steps:
- write code for joystick.
- use serial monitor to examine joystick code
- then develop the code to include the servo
*/
/*
Roughwork
- I wish I had two servos. Well since I have one, I will use just one of the axes.
- By the way, I am trying to simulate the degree of rotation about the vertical axis of a car's tires. While it is true that  the two front tires don't have the same angle of rotation, for this simulation, I'll pretend that they do. Because, I am interested in an innovative 4-wheel steering, I wish to use two servos to represent the generation direction of the front tires and back tires. That is, one servo represents the general direction of the front tires, the other servo represents the general direction of the back tires. CONSEQUENTLY, I WILL HENCEFORTH PRETEND THAT I AM DEALING WITH THE ROTATION OF FRONT WHEELS AND BACK WHEELS.
- Total angle of rotation of the wheels = 140 degrees. (Arbitrary/Random value, I haven't yet figured out what the actual value should be).
- Map rotation of wheels (represented by servo) to joystick movement. 140 == 1023
- Rotation of wheels == (140/1023) * input value from joystick
*/

#include<Servo.h>
Servo wheel;

int joystickPinXAxis = A0;
int joystickPinYAxis = A1;
int readJoystickXAxis;
int readJoystickYAxis;
int wheelPin = 5;
float frontWheelSteeringPosition;
float backWheelSteeringPosition;

void setup() {
  Serial.begin(9600);
  pinMode(joystickPinXAxis, INPUT);
  pinMode(joystickPinYAxis, INPUT);
  wheel.attach(wheelPin);
}

void loop() {
  readJoystickXAxis = analogRead(joystickPinXAxis);
  readJoystickYAxis = analogRead(joystickPinYAxis);
  frontWheelSteeringPosition = (140./1023.) * (1023 - readJoystickXAxis);
//  backWheelSteeringPosition = (140./1023.) * readJoystickYAxis;
  wheel.write(frontWheelSteeringPosition);
//  wheel.write(backWheelSteeringPosition);

  Serial.print("Joystick displacement: ");
  Serial.print(readJoystickXAxis);
  Serial.print(" Front wheel steering position: ");
  Serial.println(frontWheelSteeringPosition);
}
