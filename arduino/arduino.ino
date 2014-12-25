/*
Still experimental.
*/
 
#include <Stepper.h>
 
int in1Pin = 10;
int in2Pin = 12;
int in3Pin = 11;
int in4Pin = 9;

int motorEnablePin = 7;

int shutterPin = 8;

int potPin = A0;

int potVal = 0;
 
Stepper motor(512, in1Pin, in2Pin, in3Pin, in4Pin);  
 
void setup()
{
  pinMode(in1Pin, OUTPUT);
  pinMode(in2Pin, OUTPUT);
  pinMode(in3Pin, OUTPUT);
  pinMode(in4Pin, OUTPUT);
  pinMode(shutterPin, OUTPUT);
  
  pinMode(motorEnablePin, OUTPUT);
  digitalWrite(motorEnablePin, HIGH);
  
  // this line is for Leonardo's, it delays the serial interface
  // until the terminal window is opened
  while (!Serial);
  
  Serial.begin(9600);
  motor.setSpeed(10);
  digitalWrite(shutterPin, LOW);
}
 
void loop()
{
  potVal = analogRead(potPin);
  Serial.print(potVal);
  Serial.print("\n");

  motor.step(-30);
  delay(500);

  digitalWrite(shutterPin, HIGH);
  delay(100);
  digitalWrite(shutterPin, LOW);
  delay(6000);

/*
  if (Serial.available())
  {
    int steps = Serial.parseInt();
    motor.step(steps);
  }
*/
}
