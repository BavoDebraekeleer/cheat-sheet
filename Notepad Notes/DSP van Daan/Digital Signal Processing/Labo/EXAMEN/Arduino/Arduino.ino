#include <CapacitiveSensor.h>

const byte value[] = { 128, 131, 134, 137, 141, 144, 147, 150, 153, 156, 159, 162, 168, 171,
                       174, 177, 180, 183, 186, 189, 191, 194, 197, 199, 202, 205, 207, 209, 212,
                       214, 217, 219, 221, 223, 225, 227, 229, 231, 233, 235, 236, 238, 240, 241,
                       243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 253, 254, 254, 255,
                       255, 255, 255, 255, 255, 255, 255, 255, 255, 254, 254, 254, 253, 253, 252,
                       251, 250, 249, 248, 247, 246, 245, 243, 242, 240, 239, 237, 236, 234, 232,
                       230, 228, 226, 224, 222, 220, 218, 215, 213, 211, 208, 206, 203, 201, 198,
                       195, 193, 190, 187, 184, 181, 179, 176, 173, 170, 167, 164, 161, 158, 155,
                       152, 148, 145, 142, 139, 136, 133, 130, 126, 123, 120, 117, 114, 111, 108,
                       104, 101, 98, 95, 92, 89, 86, 83, 80, 77, 75, 72, 69, 66, 63, 61, 58, 55,
                       53, 50, 48, 45, 43, 41, 38, 36, 34, 32, 30, 28, 26, 24, 22, 20, 19, 17,
                       16, 14, 13, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 2, 1, 1, 0, 0, 0, 0, 0, 0,
                       0, 1, 1, 1, 2, 2, 3, 4, 4, 5, 6, 7, 8, 10, 11, 12, 13, 15, 16, 18, 20, 21,
                       23, 25, 27, 29, 31, 33, 35, 37, 39, 42, 44, 47, 49, 51, 54, 57, 59, 62,
                       65, 67, 70, 73, 76, 79, 82, 85, 91, 94, 97, 101, 103, 106, 109, 112,
                       115, 119, 122, 125
                     };

CapacitiveSensor   cs_4_2 = CapacitiveSensor(4, 2);       // 10M resistor between pins 4 & 2, pin 2 is sensor pin, add a wire and or foil if desired
#define ONDER_8CM_lower 48010
#define ONDER_8CM_upper 48040
#define TUSSEN_8_12CM_upper 4800
#define TUSSEN_8_12CM_lower 4810

#define TUSSEN_12_20CM 4700
#define SINUS true
#define BLOK false
bool modus = BLOK;

#define signalPin 9
volatile int f = 400;
void setup()
{

  Serial.begin(115200);
  pinMode(signalPin, OUTPUT);
  // TC1 Control Register A
  TCCR1A |= (1 << COM1A1); // Clear OC1A/OC1B on Compare Match, set OC1A/OC1B at BOTTOM (non-inverting mode)
  TCCR1A |= (1 << WGM10); // Fast PWM, 8-bit MODE 5
  TCCR1B |= (1 << CS10);
  TCCR1B |= (1 << WGM12);
}
void loop() {

  long sensor =  cs_4_2.capacitiveSensor(30);
//  if (sensor > ONDER_8CM_lower && sensor < ONDER_8CM_upper) {
//    // Beweegt je hand tussen een 8-tal cm en 12-tal cm boven het aanraakvlak van de capacitieve sensor dan  is het uitgangssignaal een sinusgolf
//    modus = SINUS;
//  }
//  if (sensor > TUSSEN_8_12CM_lower && sensor < TUSSEN_8_12CM_upper) {
//    // Beweegt je hand boven 12 cm en 20 cm boven het aanraakvlak van de capacitieve sensor dan is het uitgangssignaal een blokgolf.
//    modus = BLOK;
//  }

  Serial.print(f);


  if (modus) {
    double a = 1.0 / f;
    double b = a * 1000000.0;
    double c = b / 255;
    //39 -> 3.9
    //sinus
    for (int j = 0; j < 100; j++)
    {
      for (int j = 0; j < 256; j++)
      {
        analogOut(value[j]);
        delayMicroseconds(c);
      }
    }
  }
  if (!modus) {
    double a = 1.0 / f;
    double b = a * 1000000.0;
    double c = b / 2.0;
    for (int j = 0; j < 3; j++)
    {
      for (int x = 0; x < 100; x++)

      {
        analogOut(0);
        delayMicroseconds(c);
        analogOut(255);
        delayMicroseconds(c);
      }
    }
    delay(100);
  }
}

void analogOut(byte val) {
  OCR1A = (val);
}
