#define DATA_PIN 13
#define CLOCK_PIN 22
#define LATCH_PIN 23

#define OE_PIN 19
#define ROW1_PIN 15
#define ROW2_PIN 2
#define ROW3_PIN 0
#define ROW4_PIN 16
#define ROW5_PIN 4

#include <Arduino.h>


void shiftOut(uint8_t dataPin, uint8_t clockPin, uint8_t val)
{
  uint8_t i;

  for (i = 0; i < 8; i++)  {
    digitalWrite(dataPin, !!(val & (1 << i)));
    
    digitalWrite(clockPin, HIGH);
    digitalWrite(clockPin, LOW);
  }
}

int pins[] = {ROW1_PIN, ROW2_PIN, ROW3_PIN, ROW4_PIN, ROW5_PIN};


void setRow(int row) {
   for (int i = 0; i < 5; i++) {
    digitalWrite(pins[i], HIGH);
  }
  if (row > 4) {
      return;
  }
  digitalWrite(pins[row], LOW);
}


void setup() {
  pinMode(DATA_PIN, OUTPUT);
  pinMode(CLOCK_PIN, OUTPUT);
  pinMode(LATCH_PIN, OUTPUT);
  pinMode(OE_PIN, OUTPUT);
  pinMode(ROW1_PIN, OUTPUT);
  pinMode(ROW2_PIN, OUTPUT);
  pinMode(ROW3_PIN, OUTPUT);
  pinMode(ROW4_PIN, OUTPUT);
  pinMode(ROW5_PIN, OUTPUT);

  digitalWrite(OE_PIN, LOW);
}

int counter = 0;

void loop() {
  setRow(counter++);
  if (counter > 5) {
    delay(5);
    counter = 0;
  }
  for (int i = 0; i < 96; i++) {
    shiftOut(DATA_PIN, CLOCK_PIN, 1);
    digitalWrite(LATCH_PIN, LOW);
    // delay(1);
    delayMicroseconds(10);
    digitalWrite(LATCH_PIN, HIGH);
    // delay(2);
  }

}