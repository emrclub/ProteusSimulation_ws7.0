#include <io.h>
#include <delay.h>
#include <mega8.h>
#include <math.h>
#define F_XTAL 12000000L

#define E PORTC.0           //enable pin of LCD
#define RS PORTC.1          //Register Select pin of LCD

#define RowA PORTD.0        //to send the data to keypad
#define RowB PORTD.1 
#define RowC PORTD.2 
#define RowD PORTD.3 

#define Col1 PIND.4        //to receive the data from keypad
#define Col2 PIND.5 
#define Col3 PIND.6 
#define Col4 PIND.7 

void cmd(char a)
{
    E=1;
    RS=0;  
    PORTB=a; 
    delay_ms(5);
    E=0;
    delay_ms(5);
} 
    
void lcd1(char b)
{ 
    E=1; 
    RS=1;
    PORTB =b;
    delay_ms(5);
    E=0;
    delay_ms(5);
} 
    
void string1(char *str)
{
     while(*str!='\0')
     {               
      lcd1(*str);
      str++;
     }
}

void init_LCD()
{
   
  cmd(0x38);        //LCD initialization
  cmd(0x0e);        //display on cursor off
  cmd(0x01);        //clear display screen
  cmd(0x06);        //shift 
  cmd(0x02);        //return to home
}

char READ_SWITCHES(void)    
{    
    RowA = 0; RowB = 1; RowC = 1; RowD = 1;     //Test Row A
    if (Col1 == 0) { delay_ms(10); while (Col1==0); return '7'; }
    if (Col2 == 0) { delay_ms(10); while (Col2==0); return '8'; }
    if (Col3 == 0) { delay_ms(10); while (Col3==0); return '9'; }
    if (Col4 == 0) { delay_ms(10); while (Col4==0); return '/'; }

    RowA = 1; RowB = 0; RowC = 1; RowD = 1;     //Test Row B
    if (Col1 == 0) { delay_ms(10); while (Col1==0); return '4'; }
    if (Col2 == 0) { delay_ms(10); while (Col2==0); return '5'; }
    if (Col3 == 0) { delay_ms(10); while (Col3==0); return '6'; }
    if (Col4 == 0) { delay_ms(10); while (Col4==0); return 'x'; }
    
    RowA = 1; RowB = 1; RowC = 0; RowD = 1;     //Test Row C
    if (Col1 == 0) { delay_ms(10); while (Col1==0); return '1'; }
    if (Col2 == 0) { delay_ms(10); while (Col2==0); return '2'; }
    if (Col3 == 0) { delay_ms(10); while (Col3==0); return '3'; }
    if (Col4 == 0) { delay_ms(10); while (Col4==0); return '-'; }
    
    RowA = 1; RowB = 1; RowC = 1; RowD = 0;     //Test Row D
    if (Col1 == 0) { delay_ms(10); while (Col1==0); return 'C'; }
    if (Col2 == 0) { delay_ms(10); while (Col2==0); return '0'; }
    if (Col3 == 0) { delay_ms(10); while (Col3==0); return '='; }
    if (Col4 == 0) { delay_ms(10); while (Col4==0); return '+'; }

    return 'n';               // Means no key has been pressed
}


char get_key(void)           //get key from user
{
    char key = 'n';              //assume no key pressed

    while(key=='n')              //wait untill a key is pressed
    {       
      key = READ_SWITCHES();   //scan the keys again and again
    }
    return key;                  //when key pressed then return its value
}
   



char IsOperator(char ch)
{
  if(ch == '*' || ch=='+' || ch=='/' || ch=='-')
    return 1;
  else 
    return '\0';  
}

char IsDigit(char ch)
{
  if(ch>=48 && ch<=57)
   return 1;
  else
   return '\0';
}

char IsClear(char ch)
{
   char pos = 0xCE;
   cmd(pos);
  if(ch=='C')
   return 1;
  else
   return '\0';
}

void print_result(int res)
{
   if(res==0)
   {
     lcd1('0');
   }
   
   while(res!=0)
   {
     lcd1(res%10 + '0');
     pos = pos - 1;
     res = res/10;
   } 
}

void Calculate(int op1, int op2, char Operation)
{
   int res;
   if(Operation == '+')
    res = op1+op2;
   else if(Operation == '-')
    res = op1-op2;
   else if(Operation == '*')
    res = op1*op2;
   else if(Operation == '/')
    {
      res = op1/op2;
    }
   


}

void main()
{
    char flag_op = 0;
    int op1=0, op2=0;
    int count=0;
    char Operator = 'n';

    DDRB=0xFF;
    DDRD=0x0F;

    init_LCD();

/*cmd(0x83);
string1("WELCOMWE TO");
cmd(0xPORTD.7);
string1("EMR CLUB");
delay_ms(100);
*/
    cmd(0x01);
    cmd(0x80);
    lcd1('3');
    delay_ms(20);
    cmd(0x01);
    cmd(0x80);
/* while(1)
 {
  char ch = get_key();
    if(IsDigit(ch))
    {   
        if(flag_op == 0)
        {
          op1 = 10*op1 + (int)(ch);
        }
        else 
        {
          op2 = 10*op2 + (int)(ch);
        }
    }
    else if(IsOperator(ch))
    {
       if(flag_op==1){ cmmd(0x01); cmd(0x80); string1("Invalid Input");continue;}
       
       Operator = ch; 
       flag_op = 1;        
    }
    else if(IsClear(ch))
    {
      flag_op = 0;
      cmd(0x01);
      Operator = 'n';
    }
    else if(ch=='=')
    {
      Calculate(op1, op2, Operator);
	  op1=0;
	  op2=0;
	  Operator='n';
    }
 }*/
  while(1)
  {
    char ch = get_key();
    lcd1(ch);
    delay_ms(100);
    cmd(0x01);
  } 
  
}

