#define auto_manual portb.B1
#define manual portb.B0
#define trns_tins portd
#define trns_ones portc
#define red_west porta.b0
#define yellow_west porta.b1
#define green_west porta.b2
#define red_south porta.b3
#define yellow_south porta.b5
#define green_south porte.b0
int counter =0;
unsigned char left , right;
signed char count=0;






void interrupt()
{
if(intf_bit)
{
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
while(auto_manual==1){
for(count=15;count>=0;count--){
if (auto_manual==0){  //to apply maual mode immediately
portc=portd=porta=porte=0;
break; }
if (count>3){
red_west=1;
green_south=1;
yellow_south =0;
}
else {
red_west =1;
yellow_south =1;
green_south =0;
}
left = count/10;
right = count%10;
trns_tins=left;
trns_ones=right;
delay_ms(1000) ; }
portc=portd=porta=porte=0; // to reset led's and segment
for(count=23;count>=0;count--){
if (auto_manual==0){
portc=portd=0;
break;
}
if (count>3){
red_south=1;
green_west=1;
yellow_west =0;
}
else {
red_south =1;
yellow_west =1;
green_west =0;
}
left = count/10;
right = count%10;
trns_tins=left;    //to show number on thr segment
trns_ones=right;
delay_ms(1000) ;
}




porta=porte=0;
}
while(auto_manual==0){
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
trns_tins=left;
trns_ones=right;
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
trns_tins=left;
trns_ones=right;
delay_ms(1000) ;
}
porta=porte=0;
counter=1;
}
}
}
}