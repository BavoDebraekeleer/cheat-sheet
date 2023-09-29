/* Trapversterkingsgenerator
 * Jesse Denaux en Daan Dekoning Krekels
 * 17/02/2022
 */

#include <LiquidCrystal.h>
#define MODE_SELECT 0b00000100
#define ZERO_BTTN 0b00001000 // INT1
#define UP_BTTN 0b00010000   // PD4
#define DOWN_BTTN 0b00100000 // PD5

byte teller = 0;
bool up = false;
bool down = false;
// LCD bibliotheek initialiseren
const int rs = 12, en = 11, d4 = 10, d5 = 9, d6 = 8, d7 = 7;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

void setup()
{
  Serial.begin(9600);
  Serial.println("Compiled: "__FILE__
                 ", " __DATE__ ", " __TIME__ ", " __VERSION__);

  /*
   * Pin instellingen
   */
  DDRC = 0b00001111; // Uitgang naar somversterker en POT op A4
  DDRB = 0b00011111; // LCD pinnen
  DDRD = 0b10000000; // LCD en buttons

  /*
  * Interrupt pin om naar 0 te zetten
  */
  EIMSK |= (1 << INT1);
  // Neergaande flank
  EICRA |= (1 << ISC11);
  EICRA &= ~(1 << ISC10);

  /*
   * ADC op A4 om gewenste frequentie in te lezen 
   */

  ADCSRA |= ((1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0)); //Prescaler at 128 so we have an 125Khz clock source

  ADMUX |= (1 << REFS0);
  ADMUX &= ~(1 << REFS1); //Avcc(+5v) as voltage reference

  ADMUX &= ~(1 << MUX3); // 0100 ADC4
  ADMUX |= (1 << MUX2);
  ADMUX &= ~(1 << MUX1);
  ADMUX &= ~(1 << MUX0);

  ADCSRB &= ~((1 << ADTS2) | (1 << ADTS1) | (1 << ADTS0)); //ADC in free-running mode
  ADCSRA |= (1 << ADATE);                                  //Signal source, in this case is the free-running
  ADCSRA |= (1 << ADEN);                                   //Power up the ADC
  ADCSRA |= (1 << ADSC);

  /* 
   * LCD initialiseren
   */
  lcd.begin(16, 2);
}

void loop()
{
  // Kies mode afhankelijk van de MODE_SELECT schakelaar
  if ((PIND & MODE_SELECT) == MODE_SELECT)
  {
    // DEMO MODE
    // Optellen en weer aftellen
    Serial.println("DEMO MODE");
    for (byte i = 0; i <= 15; i++)
    {
      PORTC = i;
      // Serial.println(PORTC,BIN);
      Serial.println(PORTC);
      delay(snelheid()); // Bereken delay snelheid voor juiste frequentie
    }
    for (byte i = 14; i > 0; i--)
    {
      PORTC = i;
      // Serial.println(PORTC,BIN);
      Serial.println(PORTC);
      delay(snelheid());
    }
  }
  else
  {
    // MANUAL MODE
    if ((PIND & UP_BTTN) == UP_BTTN)
    {
      up = true;
      delay(100); // Voorkom te snel achter eklaar drukken
    }
    if (up)
    {
      if (teller < 15)
      {
        teller++;
      }
      up = false;
    }
    if ((PIND & DOWN_BTTN) == DOWN_BTTN)
    {
      down = true;
      delay(100); // Voorkom te snel achter eklaar drukken
    }
    if (down)
    {
      if (teller > 0)
      {
        teller--;
      }
      down = false;
    }
    Serial.println(teller);
    PORTC = teller;
  }
}

ISR(INT1_vect)
{
  // Interrupt om de teller te resetten
  teller = 0;
  PORTC = teller;
}

int snelheid()
{
  // Start me ADC te lezen
  ADCSRA |= (1 << ADSC);
  while (!(ADCSRA & (1 << ADIF)))
  {
  } // hier geen instructies, gewoon wachten.
  byte tLaag = ADCL;
  byte tHoog = ADCH; // Combineren van ADC bytes naar in en die meten mappen naar een waarde tussen 5 of 10ms
  byte tijd = map((tHoog << 8) + tLaag, 0, 1023, 5, 10);
  // De frequentie is 1/t
  float frec = 1.0 / (tijd / 1000.0); // tijd eerst ms -> seconden
  lcd.clear();                        // Frequentie weergeven op LCD
  lcd.setCursor(0, 0);
  lcd.print(frec);
  lcd.print("Hz");
  Serial.print(frec);
  return tijd;
}
