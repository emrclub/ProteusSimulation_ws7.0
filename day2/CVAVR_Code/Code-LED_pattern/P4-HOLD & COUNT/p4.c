/************************
This program is used to glow 8 LED in "HOLD & COUNT" fashion.(e.g. hold 1 & count 2,3,4...then hold 1,2 & count 3,4,5..)
*************************/

#include <mega8.h>
#include <io.h>
#include <delay.h>
#define F_XTAL 12000000L



void main(void)
{
unsigned char i=0,j=0,a=0,b=0,c=0;
DDRB=0xff;
PORTB=0x00;

while (1)
      {
      a=0b00000001;
      b=0b00000001;
      for(i=0; i<7; i++){ 
      
       for(j=0; j<=(8-i); j++){
       c=a|b; 
       PORTB=c;
       delay_ms(50);
       b=b<<1;
       }
       
       b=0b00000001;
        b=b<<(i);
        a=a<<1;
       a=a+0b00000001;
      }
      
      
      
}
}