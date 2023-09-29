// echo produceren met Arduino
#define cbi(PORT, bit) (PORT &= ~(1 << bit))
#define sbi(PORT, bit) (PORT |= 1 << bit)

const int pwmOUTPin = 11; // PWM-uitgang
const byte halfMax = 127;
boolean div2, selectChannel; // stuurvariabele voor sampling

// globaal toegankelijke interrupvariabele

volatile boolean adcSample;
volatile byte potSample, analogSample;
int indexCounter, valAnalog, valPot;
byte pwmBuf, ringBuff[512]; // audio ringbuffer-array
byte channel_selection = 0;
#define CHANNEL_PAUSE 1
void setup()
{
  pinMode(pwmOUTPin, OUTPUT); // PWM-pin 11 als uitgang

  // instellen adcPrescaler met deelfactor 8 (011)
  cbi(ADCSRA, ADPS2);
  sbi(ADCSRA, ADPS1);
  sbi(ADCSRA, ADPS0);

  // ADC Left Adjust Result (ADLAR) deze bit op 1
  // resultaat conversie bewaard in ADCH en ADCL en links uitgelijnd
  sbi(ADMUX, ADLAR);

  // reference selection bits O1
  // AVC met externe condensator aan de AREF-pin
  
  
  
  // TODO Veranderen naar 1.1V


  
  sbi(ADMUX, REFS0);
  sbi(ADMUX, REFS1);

  // instellen multiplexer ADC0
  cbi(ADMUX, MUX0);
  cbi(ADMUX, MUX1);
  cbi(ADMUX, MUX2);
  cbi(ADMUX, MUX3);

  // fast PWM voor Timer2
  cbi(TCCR2A, COM2A0);
  sbi(TCCR2A, COM2A1);

  sbi(TCCR2A, WGM20);
  sbi(TCCR2A, WGM21);
  cbi(TCCR2B, WGM22);

  // instellen prescaler Timer2
  sbi(TCCR2B, CS20);
  cbi(TCCR2B, CS21);
  cbi(TCCR2B, CS22);

  // activeren PWM-port Timer2
  sbi(DDRB, 3); // digitale pen 11 als uitgang

  // cli(); //interrupts uit om vervorming te voorkomen
  cbi(TIMSK0, TOIE0); // Timer0 uit (vertraging vermijden)
  sbi(TIMSK2, TOIE2); // activeren Timer2 interrupt

  valAnalog = analogSample;
}

void loop()
{
  while (!adcSample)
  {
  }
  adcSample = false;

  // schaal vertraagd sample met potentiometerwaarde
  valPot = (halfMax - ringBuff[indexCounter]) * potSample / 255;
  valAnalog = halfMax - analogSample;
  valAnalog = valAnalog + valPot;

  // begrenzen analoge waarde (min/max)
  if (valAnalog < -halfMax)
    valAnalog = -halfMax;
  if (valAnalog > halfMax)
    valAnalog - halfMax;

  // if (valAnalog < -halfMax) valAnalog = -60;
  // if (valAnalog > halfMax) valAnalog = 60;

  // offset optellen bij PWM-buffer
  pwmBuf = halfMax + valAnalog;
  ringBuff[indexCounter] = pwmBuf;
  indexCounter++;

  // beperken bufferindex tot het interval 0-511
  indexCounter = indexCounter & 511;

  OCR2A = pwmBuf; // schrijf huidige sample naar PWM-kanaal
}

// ophalen analoge waarde en potmeterwaarde
ISR(TIMER2_OVF_vect)
{
  PORTB = PORTB | 1;
  div2 = !div2; // reduceer samplefrequentie met factor 2
  if (div2)
  {
    // selectChannel = !selectChannel;
    if (channel_selection == CHANNEL_PAUSE)
    {
      potSample = ADCH;
      sbi(ADMUX, MUX0); // stel multiplexer in op ADC1
      channel_selection = 0;
    }
    else
    {
      analogSample = 1 * ADCH;
      channel_selection += 1;
      if (channel_selection == CHANNEL_PAUSE)
        cbi(ADMUX, MUX0); // multiplexer instellen op ADC0
      adcSample = true;
    }
    sbi(ADCSRA, ADSC); // start volgende omzetting
  }
}
