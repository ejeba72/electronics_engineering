// Joystick Setup, First Attempt
// 2023.dec17 sun 0821mf

int xpin = A0;
int ypin = A1;
int dt = 200;    // dt means delayTime

void setup() {
  pinMode(xpin, INPUT);
  pinMode(ypin, INPUT);
  Serial.begin(9600);
}

void loop() {
  Serial.print("x-axis: ");
  Serial.print(analogRead(xpin));
  Serial.print(" y-axis: ");
  Serial.println(analogRead(ypin));
  delay(dt);
}
