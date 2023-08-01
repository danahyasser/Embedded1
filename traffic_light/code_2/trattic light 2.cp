#line 1 "C:/Users/HP/Desktop/traffic_light/code_2/trattic light 2.c"










int counter =0;
unsigned char left , right;
signed char count=0;
void interrupt(){
if(intf_bit){
counter++;
intf_bit=0;
}
}
void main() {
adcon1=0x06;
trisb.b2=trisb.b3=trisd=trisc=trise=trisa=0;
trisb.b0=trisb.b1=1;
portb.b2=portb.b3=1;
porta=porte=0;
portc=portd=0;
inte_bit=1;
gie_bit=1;

intedg_bit=1;
for(;;){
while( portb.B1 ==1){
for(count=15;count>=0;count--){
if ( portb.B1 ==0){
portc=portd=porta=porte=0;
break;
}
if (count>3){
 porta.b0 =1;
 porte.b0 =1;
 porta.b5  =0;
}
else {
 porta.b0  =1;
 porta.b5  =1;
 porte.b0  =0;
}
left = count/10;
right = count%10;
 portd =left;
 portc =right;
delay_ms(1000) ;
}
porta=porte=0;
for(count=23;count>=0;count--){
if ( portb.B1 ==0){
portc=portd=0;
break;
}
if (count>3){
 porta.b3 =1;
 porta.b2 =1;
 porta.b1  =0;

}
else {
 porta.b3  =1;
 porta.b1  =1;
 porta.b2  =0;
}
left = count/10;
right = count%10;
 portd =left;
 portc =right;
delay_ms(1000) ;
}
porta=porte=0;
}
while( portb.B1 ==0){
if(counter==1){
porta=0b00000001;
porte=0b0000001;
}
else if (counter==2){
porta=0b00100001;
porte=0b0000000;
for(count=3;count>=0;count--){
left = count/10;
right = count%10;
 portd =left;
 portc =right;
delay_ms(1000) ;
}
counter = 3;
}
else if(counter==3){
porta=0b00001100;
porte=0b0000000;
}
else if (counter == 4){
porta=0b00001010;
porte=0b0000000;
for(count=3;count>=0;count--){
left = count/10;
right = count%10;
 portd =left;
 portc =right;
delay_ms(1000) ;
}
porta=porte=0;
counter=1;
}
}
}
}
