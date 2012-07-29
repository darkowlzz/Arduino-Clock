#include <LiquidCrystal.h>

struct Date  {
  int year;
  int month;
  int day;
};

Date today = { 12, 7, 29};  //  current date
int h=0, m=0, s=0, ms = 0;  //  hours, minutes, seconds, milliseconds
int pin2Mode = 0, pin3Mode = 0;

LiquidCrystal lcd(12,11,5,4,3,2);
const int buttonPin1 = 6;
const int buttonPin2 = 10;
const int buttonPin3 = 9;
const int buttonPin4 = 8;
const int led = 13;

int buttonState1 = 0, buttonState2 = 0, buttonState3 = 0, buttonState4 = 0;

void regTime(int t) {
    //  stores the current time in the system

    int excess;     //to store time exceeding 60s
    s += t;
    
    if (s>=60)  {   //if time exceeds 
        excess = s%60;
        s = excess;
        m++;
    }

    if (m == 60)  { //reset minutes 
        h++;
        m=0;
    }

    if (h == 24)  { //reset hours
        h = 0;
    }
}

void printTime()    {
    //  print the time on the screen

    lcd.setCursor(0,0);
    
    lcd.clear();
    lcd.print(h);
    lcd.print(":");
    lcd.print(m);
    lcd.print(":");
    lcd.print(s);
}


void setup()  {
  lcd.begin(16,2);
  pinMode(buttonPin1, INPUT);
  pinMode(buttonPin2, INPUT);
  pinMode(led, OUTPUT);
  Serial.begin(9600);
}


void loop()  {
  
    buttonState1 = digitalRead(buttonPin1);
    
    if (digitalRead(buttonPin2) == HIGH)    {   // when button2 is pressed
        pin2Mode++;
    }
    
    // check button1 for LED light

    if( buttonState1 == HIGH)  {
        digitalWrite(led, HIGH);
    }
    else  {
        digitalWrite(led, LOW);
    }
    
    // end button1 check
    
    //mode check
    if (pin2Mode == 0)  {    
        regTime(1);
        printTime();
  
        lcd.setCursor(0,1);
        lcd.print(today.day);
        lcd.print("/");
        lcd.print(today.month);
        lcd.print("/");
        lcd.print(today.year);
  
        delay(1000);
    }
    else if (pin2Mode == 1) {
        regTime(1);
        lcd.clear();
        lcd.print("mode1");
        delay(1000);
    }
    else if (pin2Mode == 2) {
        // mode 2 starts

        lcd.clear();
        if (digitalRead(buttonPin3) == HIGH)    {
            pin3Mode++;
        }
    
        lcd.setCursor(0,0);
        lcd.print("mode2");
        
        if (pin3Mode == 0)  {
            regTime(1);
            lcd.setCursor(0,1);
            lcd.print("Change time");
        }
        else if (pin3Mode == 1)  {
            regTime(1);
            lcd.setCursor(0,1);
            lcd.print("Hour: ");
            if (digitalRead(buttonPin4) == HIGH)    {
                h++;
            }
            lcd.print(h);
        }
        else if (pin3Mode == 2) {
            regTime(1);
            lcd.setCursor(0,1);
            lcd.print("Minutes: ");
            if (digitalRead(buttonPin4) == HIGH)    {
                m++;
            }
            lcd.print(m);
        }
        else if (pin3Mode == 3) {
            regTime(1);
            lcd.setCursor(0,1);
            lcd.print("back to T-M-0");
            pin3Mode = 0;
        }
        
        delay(1000);

        // mode 2 ends
    }
    else if (pin2Mode == 3) {
        lcd.clear();
        lcd.print("back to mode0");
        delay(2000);
        pin2Mode = 0;
    }
}
