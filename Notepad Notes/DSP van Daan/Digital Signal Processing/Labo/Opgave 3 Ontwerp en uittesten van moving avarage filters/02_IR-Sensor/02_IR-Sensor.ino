void setup()
{
  Serial.begin(9600);
  DDRC &= ~(1 << PC0); // ADC0 als ingang
  Serial.print(0);     // To freeze the lower limit
  Serial.print(" ");
  Serial.print(6); // To freeze the upper limit
  Serial.print(" ");
}

#define SAMPLE_COUNT 20
#define SAMPLE_TIME 7
bool pol = false;
void loop()
{
  float measurement = 0;
  for (byte i = 0; i < SAMPLE_COUNT; i++)
  {
    delay(SAMPLE_TIME);
    measurement += analogRead(A0); // Lees spanningswaarde en tel op bij meting
  }
  measurement = measurement / SAMPLE_COUNT; // Gmeiddelde van de metingen bepalen
  Serial.print(measurement * (5.0 / 1023.0)); // Gemeten spanning afdrukken
  Serial.print(" ");
  delay(50);
}
