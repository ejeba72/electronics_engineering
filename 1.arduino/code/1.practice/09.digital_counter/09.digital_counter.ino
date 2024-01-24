// Digital Counter
// 2023.dec20 wed 1106mf
// The following program will use 4 LEDs to represent 4 switches in a microchip. These 4 switches will be used to display numbers from Zero to Fifteen in binary number system.

int firstDigit = 2;
int secondDigit = 3;
int thirdDigit = 4;
int fourthDigit = 5;
int waitTime = 3500;

void setup() {
  pinMode(firstDigit, OUTPUT);
  pinMode(secondDigit, OUTPUT);
  pinMode(thirdDigit, OUTPUT);
  pinMode(fourthDigit, OUTPUT);
}

void loop() {
  // Number 0, 0b0000
  digitalWrite(firstDigit, LOW);
  digitalWrite(secondDigit, LOW);
  digitalWrite(thirdDigit, LOW);
  digitalWrite(fourthDigit, LOW);
  delay(waitTime);

  // Number 1, 0b0001
  digitalWrite(firstDigit, HIGH);
  digitalWrite(secondDigit, LOW);
  digitalWrite(thirdDigit, LOW);
  digitalWrite(fourthDigit, LOW);
  delay(waitTime);

  // Number 2, 0b0010
  digitalWrite(firstDigit, LOW);
  digitalWrite(secondDigit, HIGH);
  digitalWrite(thirdDigit, LOW);
  digitalWrite(fourthDigit, LOW);
  delay(waitTime);

  // Number 3, 0b0011
  digitalWrite(firstDigit, HIGH);
  digitalWrite(secondDigit, HIGH);
  digitalWrite(thirdDigit, LOW);
  digitalWrite(fourthDigit, LOW);
  delay(waitTime);

  // Number 4, 0b0100
  digitalWrite(firstDigit, LOW);
  digitalWrite(secondDigit, LOW);
  digitalWrite(thirdDigit, HIGH);
  digitalWrite(fourthDigit, LOW);
  delay(waitTime);

  // Number 5, 0b0101
  digitalWrite(firstDigit, HIGH);
  digitalWrite(secondDigit, LOW);
  digitalWrite(thirdDigit, HIGH);
  digitalWrite(fourthDigit, LOW);
  delay(waitTime);

// Number 6, 0b0110
  digitalWrite(firstDigit, LOW);
  digitalWrite(secondDigit, HIGH);
  digitalWrite(thirdDigit, HIGH);
  digitalWrite(fourthDigit, LOW);
  delay(waitTime);

// Number 7, 0b0111
  digitalWrite(firstDigit, HIGH);
  digitalWrite(secondDigit, HIGH);
  digitalWrite(thirdDigit, HIGH);
  digitalWrite(fourthDigit, LOW);
  delay(waitTime);

// Number 8, 0b1000
  digitalWrite(firstDigit, LOW);
  digitalWrite(secondDigit, LOW);
  digitalWrite(thirdDigit, LOW);
  digitalWrite(fourthDigit, HIGH);
  delay(waitTime);

// Number 9, 0b1001
  digitalWrite(firstDigit, HIGH);
  digitalWrite(secondDigit, LOW);
  digitalWrite(thirdDigit, LOW);
  digitalWrite(fourthDigit, HIGH);
  delay(waitTime);

// Number 10, 0b1010
  digitalWrite(firstDigit, LOW);
  digitalWrite(secondDigit, HIGH);
  digitalWrite(thirdDigit, LOW);
  digitalWrite(fourthDigit, HIGH);
  delay(waitTime);

// Number 11, 0b1011
  digitalWrite(firstDigit, HIGH);
  digitalWrite(secondDigit, HIGH);
  digitalWrite(thirdDigit, LOW);
  digitalWrite(fourthDigit, HIGH);
  delay(waitTime);

// Number 12, 0b1100
  digitalWrite(firstDigit, LOW);
  digitalWrite(secondDigit, LOW);
  digitalWrite(thirdDigit, HIGH);
  digitalWrite(fourthDigit, HIGH);
  delay(waitTime);

// Number 13, 0b1101
  digitalWrite(firstDigit, HIGH);
  digitalWrite(secondDigit, LOW);
  digitalWrite(thirdDigit, HIGH);
  digitalWrite(fourthDigit, HIGH);
  delay(waitTime);

// Number 14, 0b1110
  digitalWrite(firstDigit, LOW);
  digitalWrite(secondDigit, HIGH);
  digitalWrite(thirdDigit, HIGH);
  digitalWrite(fourthDigit, HIGH);
  delay(waitTime);

// Number 15, 0b1111
  digitalWrite(firstDigit, HIGH);
  digitalWrite(secondDigit, HIGH);
  digitalWrite(thirdDigit, HIGH);
  digitalWrite(fourthDigit, HIGH);
  delay(waitTime);
}
