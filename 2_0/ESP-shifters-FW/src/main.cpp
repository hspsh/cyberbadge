
#include <Arduino.h>
#include "pinDefs.h"


class BootlegDumbMatrix {
public:

  int oe;
  int latch;
  int clock;
  int data;

  int rowCount;
  int *rowPins;

  BootlegDumbMatrix(){};

  void init(){
    pinMode(oe, OUTPUT);
    pinMode(latch, OUTPUT);
    pinMode(clock, OUTPUT);
    pinMode(data, OUTPUT);

    for (int i = 0; i < rowCount; i++) {
      pinMode(rowPins[i], OUTPUT);
      digitalWrite(rowPins[i], HIGH);
    }

    digitalWrite(oe, LOW);
  }

  void setRow(int row) {
    for (int i = 0; i < rowCount; i++) {
      digitalWrite(rowPins[i], HIGH);
    }
    if (row > rowCount) {
      return;
    }
    digitalWrite(rowPins[row], LOW);
  }

  void shiftOut(uint8_t val) {
    uint8_t i;

    for (i = 0; i < 8; i++)  {
      digitalWrite(data, !!(val & (1 << i)));
      
      digitalWrite(clock, HIGH);
      digitalWrite(clock, LOW);
    }
  }

  uint8_t lineBuffer[12];

  void spewBuf(){
    for (int i = 0; i < 12; i++) {
      shiftOut(lineBuffer[i]);
    }
  }

  void drawRow(int rowNum){
    setRow(rowNum);


    delayMicroseconds(delayVal);
    digitalWrite(LATCH_PIN, LOW);
    // delay(1);
    digitalWrite(LATCH_PIN, HIGH);
  }

  void drawFrame(){
    for (int line = 0; line < 8; line++) {
      uint8_t *pattern = getPattern(line);
      for (int i = 0; i < 12; i++) {
        lineBuffer[i] = pattern[i];
      }
      spewBuf();
    }
  }

  uint8_t getGreenPattern(int i){
    switch (i%3){
      case 0:
        return 0b01001001;
      case 1:
        return 0b10010010;
      default:
        return 0b00100100;
    }
  }

};

BootlegDumbMatrix dmatrix = BootlegDumbMatrix();

void setup() {

  dmatrix.oe = OE_PIN;
  dmatrix.latch = LATCH_PIN;
  dmatrix.clock = CLOCK_PIN;
  dmatrix.data = DATA_PIN;
  dmatrix.rowCount = 8;
  dmatrix.rowPins = new int[8];
  memcpy(dmatrix.rowPins, ROW_PINS, 8*sizeof(int));
  // dmatrix.rowPins = ROW_PINS;
  dmatrix.init();

  Serial.begin(115200);
}

int counter = 0;
int delayVal = 15000;

void loop() {
  dmatrix.drawFrame();
  
}