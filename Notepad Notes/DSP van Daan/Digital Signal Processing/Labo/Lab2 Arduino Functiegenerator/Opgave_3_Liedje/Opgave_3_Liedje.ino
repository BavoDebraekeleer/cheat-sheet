// Liedje maken
// Jesse Denaux & Daan Dekoning Krekels
#define LUIDSPREKER 2
const float f[] = {440.0, 466.2, 493.9, 523.3, 554.4, 587.3, 622.3, 659.3, 698.5, 740.0, 784.4, 830.6, 880.0, 1760.0, 392.0}; // A -> A2 : frequentie
const float x[] = {0.000, 0.056, 0.109, 0.159, 0.206, 0.251, 0.293, 0.333, 0.370, 0.405, 0.439, 0.470, 0.500, 0.750 }; // A -> A2 : tijd
#define C  3
#define D  5
#define E  7
#define F  8
#define G  10
#define Fis 9
#define A 12
#define B 2
#define Gl 14

const byte liedje[] = {C,D,E,C, C,D,E,C, E,F,G, E,F,G, G,A,G,F,E, C, G,A,G,F,E, C, C, Gl, C, C, Gl, C};
const bool snelh[]  = {0,0,0,1, 0,0,0,1, 0,0,1, 0,0,1, 0,0,0,0,1, 1, 0,0,0,0,1, 1, 1, 1, 1, 1, 1, 1};
const float pauze[] = {0.25,0.25,0.25,0.25, 0.25,0.25,0.25,0.25, 0.25,0.25,0.5, 0.25,0.25,0.5, 0.125,0.125,0.125,0.125,0.25,0.25, 0.125,0.125,0.125,0.125,0.25,0.25, 0.25,0.25,0.5, 0.25,0.25,0.5};


byte liedje_length = sizeof(liedje)/sizeof(liedje[0]);
void setup() {
  pinMode(LUIDSPREKER, OUTPUT);
}

void loop() {
  for(byte i = 0; i < liedje_length; i++){
    tone(LUIDSPREKER, f[liedje[i]], x[liedje[i]]);
    delay(pauze[i]*1000);
    if (snelh[i]){
      tone(LUIDSPREKER, f[liedje[i]], x[liedje[i]]);
    }
  }


}
