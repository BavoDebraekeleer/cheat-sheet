// Akoestisch Alarm
// Jesse Denaux & Daan Dekoning Krekels
#define LUIDSPREKER 2
const float f[] = {440.0, 466.2, 493.9, 523.3, 554.4, 587.3, 622.3, 659.3, 698.5, 740.0, 784.4, 830.6, 880.0, 1760.0}; // A -> A2 : frequentie
const float x[] = {0.000, 0.056, 0.109, 0.159, 0.206, 0.251, 0.293, 0.333, 0.370, 0.405, 0.439, 0.470, 0.500, 0.750 }; // A -> A2 : tijd
#define C  3
#define D  5
#define A2 13

void setup() {
  pinMode(LUIDSPREKER, OUTPUT);
}

void loop() {
  // for(int i = 587.3; i < 1760; i += 16){
  //   tone(LUIDSPREKER, i, 50);
  //   delay(20);
  // }

  // for (int j=1760; j > 523.3; j -= 12.5){
  //   tone(LUIDSPREKER, j, 50);
  //   delay(20);
  // }
  for(byte i = D; i <= A2; i += 1){
    tone(LUIDSPREKER, f[i], x[i]);
    delay(2000/(A2-D));
  }

  for (byte j=A2; j >= C; j -= 1){
    tone(LUIDSPREKER, f[j], x[j]);
    delay(1500/(A2-C));
  }

}
