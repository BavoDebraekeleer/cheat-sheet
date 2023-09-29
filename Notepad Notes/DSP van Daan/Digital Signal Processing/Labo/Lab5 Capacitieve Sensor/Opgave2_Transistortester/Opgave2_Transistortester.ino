/* DSP Labo 5 Opgave 2
   Transistortester
   Jesse Denaux & Daan Dekoning Krekels
*/

#include <CapacitiveSensor.h>
#include <LiquidCrystal.h>

// LCD bibliotheek initialiseren
const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

#define BASE A4
#define COLLECTOR A5
#define RED_NPN 7
#define GREEN_PNP 6

#define DETECTED_SI 0
#define DETECTED_GE 1
#define DETECTED_NONE 2
byte Q_type = DETECTED_NONE;

#define CS_DREMPEL 500
#define CS0_SEND A0
#define CS0_RECIEVE A1
#define CS1_SEND 9
#define CS1_RECIEVE 8
CapacitiveSensor Cs = CapacitiveSensor(CS0_SEND, CS0_RECIEVE);
CapacitiveSensor Cs1 = CapacitiveSensor(CS1_SEND, CS1_RECIEVE);

bool debounce = false;
bool inPNPMode = false;

float U_base, U_collector, I_base, I_collector;

void setup() {
  pinMode(RED_NPN, OUTPUT);
  pinMode(GREEN_PNP, OUTPUT);

  Serial.begin(115200);

  // Aantal rijen en kolommen doorgeven
  lcd.begin(16, 2);

  lcd.print("Opgestart");
  delay(500);
  lcd.clear();
}

void loop() {
  // Basis en collector inlezen en weergeven via Serial
  int base = analogRead(BASE);
  int collector = analogRead(COLLECTOR);
  Serial.print("Collector: "); Serial.println(collector);
  Serial.print("Base: "); Serial.println(base);

  // Transistortype bepalen Si, Ga of stuk
  Q_type = detect_type(base, collector);

  // Afhankelijk van het type geven we een andere tekst weer op de LCD
  switch (Q_type)
  {
    case DETECTED_SI:
      Serial.println("Q is working!");
      lcd.clear();
      lcd.print("Q is working!");
      lcd.setCursor(2, 1);
      lcd.print("SI");
      Serial.print("SI");
      break;

    case DETECTED_GE:
      Serial.println("Q is working!");
      lcd.clear();
      lcd.print("Q is working!");
      lcd.setCursor(2, 1);
      lcd.print("GE");
      Serial.print("GE");
      break;

    case DETECTED_NONE:
      lcd.clear();
      lcd.print("Q is not working!!!");
      Serial.println("Q is not working!!!");
      break;
  }

  // Verdere informatie over de transistor weergeven
  if (inPNPMode && Q_type != DETECTED_NONE) {
    // PNP MODE
    lcd.setCursor(2, 1);
    lcd.print("-PNP-HFE=");
    Serial.print("-PNP-HFE=");
    // Berekeningen laten uitvoeren om HFE te weten
    calculate_transistor(base, collector, &U_base, &U_collector, &I_base, &I_collector);
    float hfe = I_collector / I_base;
    lcd.print(round(hfe));
    Serial.println(round(hfe));
  } else if (!inPNPMode && Q_type != DETECTED_NONE) {
    // NPN MODE
    lcd.setCursor(2, 1);
    lcd.print("-NPN-HFE=");
    Serial.print("-NPN-HFE=");
    // Berekeningen laten uitvoeren om HFE te weten
    calculate_transistor(base, collector, &U_base, &U_collector, &I_base, &I_collector);
    float hfe = I_collector / I_base;
    lcd.print(round(hfe));
    Serial.println(round(hfe));
  }

  // Capaciteit inlezen
  long v = Cs.capacitiveSensor(30);
  long v1 = Cs1.capacitiveSensor(30);

  // Werd de modus-knop gebruikt?
  if (v > CS_DREMPEL && !debounce) {
    debounce = true;
    inPNPMode = !inPNPMode;
    if (inPNPMode) {
      Serial.println("PNP mode active");
      digitalWrite(RED_NPN, LOW);
      digitalWrite(GREEN_PNP, HIGH);

    }
    else {
      Serial.println("NPN mode active");
      digitalWrite(RED_NPN, HIGH);
      digitalWrite(GREEN_PNP, LOW);
    }
    delay(500);
    debounce = false;
  }

  // Werd de extra info knop gebruikt?
  if (v1 > CS_DREMPEL && !debounce) {
    debounce = true;
    calculate_transistor(base, collector, &U_base, &U_collector, &I_base, &I_collector);
    lcd.setCursor(0, 1);
    lcd.autoscroll();
    lcd.print("Ube=" + String(round(U_base)) + ",Uce=" + String(round(U_collector)) + ",Ib=" + String(round(I_base)) + ",Ic=" + String(round(I_collector)));

    delay(500);
    debounce = false;
  }
  delay(300);
}


void calculate_transistor(int base, int collector, float *Ubase, float *Ucollector , float *Ibase, float *Icollector) {
  /* int base en int collector moeten de analoog gelezen waardes zijn
     Bereken de Ub, Uc, Ib en Ic waarde van de transistor
     Geeft de uitkomst terug via de pointers
  */
  *Ubase = (((float)base / 1023.0) * 5.0);
  const float R_base = 100000.0;
  *Ibase = U_base / R_base;
  *Ucollector = (((float)collector / 1023.0) * 5.0);
  const float R_collector = 1000.0;
  *Icollector = U_collector / R_collector;
}

byte detect_type(int base, int collector) {
  /*
     Als de Ube spanning tussen 0.5V en 0.8V is spreken we over een silicium transistor.
     Dan zal deze functie 0 retourneren.
     Als de Ube spanning tussen 0.2V en 0.7V is spreken we over een germanium transistor.
     Dan zal deze functie 1 retourneren.
     Anders zal deze functie 2 retourneren en werkt de transistor niet.
  */
  float U_base = (((float)base / 1023.0) * 5.0);
  float U_collector = (((float)collector / 1023.0) * 5.0);
  float U_be = U_base - U_collector;
  if (U_be > 0.5 && U_be < 0.8) {
    return DETECTED_SI;
  } else if (U_be > 0.2 && U_be < 0.7) {
    return DETECTED_GE;
  } else {
    return DETECTED_NONE;
  }
}
