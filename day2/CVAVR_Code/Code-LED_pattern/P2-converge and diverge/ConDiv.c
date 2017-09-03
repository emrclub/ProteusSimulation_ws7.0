/****************************
This is a program to converge and diverge 8 LED
******************************/


#include <mega8.h>
#include <io.h>
#include <delay.h>
#define F_XTAL 12000000L



void main(void)
{
unsigned char i,a,b,c;
DDRB=0xff;
PORTB=0x00;

while (1)
      {
      a=0b0001;
      b=0b1000;
      for(i=0; i<4; i++){
       c=a*10000+b; 
       PORTB=c;
       delay_ms(100);
       a=a<<1;
       b=b>>1;
      }
      a=0b1000;
      b=0b0001;
      for(i=0; i<4; i++){
       c=a*10000+b; 
       PORTB=c;
       delay_ms(100);
       a=a>>1;
       b=b<<1;
      }
      
}
}