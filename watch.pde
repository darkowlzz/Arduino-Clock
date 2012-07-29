#include <LiquidCrystal.h>

struct Date  {
  int year;
  int month;
  int day;
};

Date today = { 12, 7, 29};  //  current date
int h=0, m=0, s=0, ms = 0;  //  hours, minutes, seconds, milliseconds
int mode = 0;

LiquidCrystal lcd(12,11,5,4,3,2);
const int buttonPin1 = 6;
const int buttonPin2 = 10;
const int led = 13;

int buttonState1 = 0, buttonState2 = 0;

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
    
    if (digitalRead(buttonPin2) == HIGH)    {
        mode++;
    }
    
    if( buttonState1 == HIGH)  {
        digitalWrite(led, HIGH);
    }
    else  {
        digitalWrite(led, LOW);
    }

    if (mode == 0)  {    
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
    else if (mode == 1) {
        lcd.clear();
        lcd.print("mode1");
        delay(1000);
    }
    else if (mode == 2) {
        lcd.clear();
        lcd.print("mode2");
        delay(1000);
    }
    else if (mode == 3) {
        lcd.clear();
        lcd.print("back to mode0");
        delay(2000);
        mode = 0;
    }
}
