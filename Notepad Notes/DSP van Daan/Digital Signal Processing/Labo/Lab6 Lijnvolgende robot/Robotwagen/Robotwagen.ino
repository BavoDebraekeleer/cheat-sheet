#include <LiquidCrystal_I2C.h>
#include <Wire.h>

//LIJN == 1

// PWM Settings
const int PWM_FREQUENCY = 500;
const int PWM_RESOLUTION = 8;
const int PWM_MAX_DC = 255;

// Motor PWM Pin declarations
const int PWM_CHANNEL_COUNT = 4;
const int MOTOR_COUNT = 2;

int MOTOR_PINS[PWM_CHANNEL_COUNT] = {18, 5, 2, 15};
int MOTOR_CHANNELS[PWM_CHANNEL_COUNT] = {0, 1, 2, 3};

// LED PWM Pin declarations
const int LED_CHANNEL_COUNT = 4;
const int LED_COUNT = 4;

int LED_PINS[LED_COUNT] = {13, 12, 14, 27};
int LED_CHANNELS[LED_CHANNEL_COUNT] = {4, 5, 6, 7};
int LED_STATE[] = {0, 0, 0, 0};

// I2C LCD Initialisation
//int LCD_COLUMNS = 16;
//int LCD_ROWS = 2;
//LiquidCrystal_I2C lcd(0x27, LCD_COLUMNS, LCD_ROWS);

// Phototransitor Pin Declaration
const int PL_PIN = 25;
const int TRIG_PIN = 19;
const int ECHO_PIN = 23;

enum COMMANDS {
  LEFT_TURN_FORWARD,      // 0
  FORWARD,                // 1
  RIGHT_TURN_FORWARD,     // ...
  RIGHT,
  RIGHT_TURN_BACKWARDS,
  BACKWARDS,
  LEFT_TURN_BACKWARDS,
  LEFT,
  STOP,
  BARRIER_ONE_UP,
  BARRIER_ONE_DOWN,
  PRIOR_VEHICLE,
  BARRIER_TWO_UP,
  BARRIER_TWO_DOWN,     //13
};

enum MOTOR_DIRECTION {
  MOTOR_BACKWARDS = -1,
  MOTOR_STOP = 0,
  MOTOR_FORWARD = 1
};

volatile int drivingSpeed = 100;

byte linetracker;
#define LINKS true
#define RECHTS false
bool vorige_afslag = LINKS;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  Wire.begin();
  
  for (int i = 0; i < PWM_CHANNEL_COUNT; i++) {
    ledcSetup(MOTOR_CHANNELS[i], PWM_FREQUENCY, PWM_RESOLUTION);
    ledcAttachPin(MOTOR_PINS[i], MOTOR_CHANNELS[i]);
  }
  //init of the LED Pins
  for (int i = 0; i < LED_COUNT; i++) {
    ledcSetup(LED_CHANNELS[i], PWM_FREQUENCY, PWM_RESOLUTION);
    ledcAttachPin(LED_PINS[i], LED_CHANNELS[i]);
    ledcWrite(LED_CHANNELS[i], 128);
  }
  delay(5000);
  //  lcd.init();
  //  lcd.backlight();
  
}

void loop() {
  // put your main code here, to run repeatedly:
  Wire.requestFrom(8, 1);
  while (Wire.available()) {
    linetracker = Wire.read();
    Serial.println(linetracker, BIN);
  }
//  parcourRijden();
  lijnVolgen();
  delay(50);
}

void lijnVolgen(){
  if (linetracker == 0b11111111 || linetracker == 0b11111110 ||  linetracker == 0b01111111) {
    driveMotors(MOTOR_STOP, 0, MOTOR_STOP, 0);
    delay(250);
    richtingKiezen(500);
  }
  else if ((linetracker == 0b11111100 || linetracker == 0b11111000) &&  vorige_afslag == LINKS) {
    richtingKiezen(500);
  }
  else if ((linetracker == 0b00111111 || linetracker == 0b00011111) && vorige_afslag == RECHTS){
    richtingKiezen(500);
  }
//  else if (linetracker == 0b11111111) { //Bij obstakel
//    richtingKiezen(150);
//    driveMotors(MOTOR_BACKWARDS, drivingSpeed, MOTOR_BACKWARDS, drivingSpeed);
//    delay(500);
//  }
  else if (linetracker & (1 << 1)) { 
    driveMotors(MOTOR_FORWARD, drivingSpeed * 2, MOTOR_FORWARD, drivingSpeed / 2); //Links draaien
    Serial.println("Links draaien");
    delay(150);
  }
  else if (linetracker & (1 << 6))
  {
    driveMotors(MOTOR_FORWARD, drivingSpeed / 2, MOTOR_FORWARD, drivingSpeed * 2); //Rechts draaien 
    Serial.println("Rechts draaien");
    delay(150);
  }

  else {
    driveMotors(MOTOR_FORWARD, drivingSpeed, MOTOR_FORWARD, drivingSpeed); //Rechtdoor rijden
    Serial.println("Rechtdoor");
  }
}

void richtingKiezen(int pauze) {
  if (vorige_afslag == LINKS) {
    driveMotors(MOTOR_FORWARD, int(drivingSpeed*1.5), MOTOR_BACKWARDS, drivingSpeed * 2); //Rechts draaien
    Serial.println("Rechts draaien");
    delay(pauze);
  }
  else if (vorige_afslag == RECHTS) {
    driveMotors(MOTOR_BACKWARDS, drivingSpeed * 2, MOTOR_FORWARD, int(drivingSpeed* 1.5)) ; //Links draaien 
    Serial.println("Links draaien");
    delay(pauze);
  }
  byte linetracker_bocht;
  Wire.requestFrom(8, 1);
  while (Wire.available()) {
    linetracker_bocht = Wire.read();
  }
  if (linetracker_bocht & (1 << 3) && linetracker_bocht & (1 << 4) || linetracker_bocht & (1 << 2) && linetracker_bocht & (1 << 3) || linetracker_bocht & (1 << 4) && linetracker_bocht & (1 << 5)) {
    if (pauze <= 50) {
      richtingKiezen(pauze);
    }
    else {
      richtingKiezen(pauze / 2);
    }
  }
  else {
    vorige_afslag = !vorige_afslag;
  }
}

void parcourRijden(){
  drivingSpeed=250;
  
  driveMotors(MOTOR_FORWARD, drivingSpeed/2, MOTOR_FORWARD, drivingSpeed); // Curved turn forward to the right
  delay(1500);
  driveMotors(MOTOR_FORWARD, drivingSpeed, MOTOR_FORWARD, drivingSpeed); // Drive forward
  delay(3000);
  driveMotors(MOTOR_FORWARD, drivingSpeed, MOTOR_FORWARD, drivingSpeed/2); // Curved turn forward to the left
  delay(3000);
  driveMotors(MOTOR_STOP, 0, MOTOR_STOP, 0); // Stop driving
  delay(1000);
  driveMotors(MOTOR_BACKWARDS, drivingSpeed, MOTOR_BACKWARDS, drivingSpeed); // Drive backwards
  delay(1500);
  driveMotors(MOTOR_BACKWARDS, drivingSpeed, MOTOR_FORWARD, drivingSpeed); // Turn right around center point chassis
  delay(1000);
  driveMotors(MOTOR_STOP, 0, MOTOR_STOP, 0); // Stop driving
  delay(1000);
  driveMotors(MOTOR_BACKWARDS, drivingSpeed, MOTOR_BACKWARDS, drivingSpeed/2); // Curved turn backwards to the left
  delay(1000);
  driveMotors(MOTOR_STOP, 0, MOTOR_STOP, 0); // Stop driving
  delay(1000);
}
void driveMotors(int leftMotorDirection, int leftMotorSpeed, int rightMotorDirection, int rightMotorSpeed) {
  //  lcd.clear(); // scherm leegmaken bij nieuw commando
  //  lcd.setCursor(0, 0); // Cursor links bovenaan zetten

  switch (leftMotorDirection)
  {
    case MOTOR_BACKWARDS:
      Serial.println("Linker motor achteruit");
      //lcd.print("Linker motor achteruit"); // Tekst op het scherm zetten
      ledcWrite(MOTOR_CHANNELS[3], LOW); // Motor doet de rupsbanden naar achter draaien
      ledcWrite(MOTOR_CHANNELS[2], rightMotorSpeed); // Correcte PWM signaal sturen naar linker motor
      break;
    case MOTOR_STOP:
      Serial.println("Linker motor stop");
      //lcd.print("Linker motor stop");
      ledcWrite(MOTOR_CHANNELS[2], LOW);
      ledcWrite(MOTOR_CHANNELS[3], LOW); // Motorsnelheid wordt op 0 gezet
      break;
    case MOTOR_FORWARD:
      Serial.println("Linker motor vooruit");
      //lcd.print("Linker motor vooruit");
      ledcWrite(MOTOR_CHANNELS[3], rightMotorSpeed); // Correcte PWM signaal sturen naar linker motor
      ledcWrite(MOTOR_CHANNELS[2], HIGH); // Motor doet de rupsbanden naar voren draaien
      break;
    default:
      break;
  }

  switch (rightMotorDirection)
  {
    case MOTOR_BACKWARDS:
      Serial.println("Rechter motor achteruit");
      //lcd.print("Rechter motor achteruit");
      ledcWrite(MOTOR_CHANNELS[1], LOW); // Motor doet de rupsbanden naar achter draaien
      ledcWrite(MOTOR_CHANNELS[0], leftMotorSpeed);// Correcte PWM signaal sturen naar rechter motor
      break;
    case MOTOR_STOP:
      Serial.println("Rechter motor stop");
      //lcd.print("Rechter motor stop");
      ledcWrite(MOTOR_CHANNELS[0], LOW);
      ledcWrite(MOTOR_CHANNELS[1], LOW);// Motorsnelheid wordt op 0 gezet
      break;
    case MOTOR_FORWARD:
      Serial.println("Rechter motor vooruit");
      //lcd.print("Rechter motor vooruit");
      ledcWrite(MOTOR_CHANNELS[1], leftMotorSpeed);// Correcte PWM signaal sturen naar rechter motor
      ledcWrite(MOTOR_CHANNELS[0], HIGH); // Motor doet de rupsbanden naar voren draaien
      break;
    default:
      break;
  }
}
