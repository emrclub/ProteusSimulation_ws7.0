/****************************
This is a program to simultaneously alternate and converge up and down of two LED(1,2 then 8,7..and so on)
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
     for(c=0; c<2; c++){
      
      for(i=0; i<2; i++){
       PORTB=a;
       delay_ms(50);
       a=a<<1;
      }
      
      for(i=0; i<2; i++){
       PORTB=b*10000;
       delay_ms(50);
       b=b>>1;
      }
     }
}
}