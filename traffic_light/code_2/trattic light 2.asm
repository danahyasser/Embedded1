
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;trattic light 2.c,14 :: 		void interrupt(){
;trattic light 2.c,15 :: 		if(intf_bit){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;trattic light 2.c,16 :: 		counter++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;trattic light 2.c,17 :: 		intf_bit=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;trattic light 2.c,18 :: 		}
L_interrupt0:
;trattic light 2.c,19 :: 		}
L_end_interrupt:
L__interrupt38:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;trattic light 2.c,20 :: 		void main() {
;trattic light 2.c,21 :: 		adcon1=0x06;
	MOVLW      6
	MOVWF      ADCON1+0
;trattic light 2.c,22 :: 		trisb.b2=trisb.b3=trisd=trisc=trise=trisa=0;
	CLRF       TRISA+0
	MOVF       TRISA+0, 0
	MOVWF      TRISE+0
	MOVF       TRISE+0, 0
	MOVWF      TRISC+0
	MOVF       TRISC+0, 0
	MOVWF      TRISD+0
	BTFSC      TRISD+0, 0
	GOTO       L__main40
	BCF        TRISB+0, 3
	GOTO       L__main41
L__main40:
	BSF        TRISB+0, 3
L__main41:
	BTFSC      TRISB+0, 3
	GOTO       L__main42
	BCF        TRISB+0, 2
	GOTO       L__main43
L__main42:
	BSF        TRISB+0, 2
L__main43:
;trattic light 2.c,23 :: 		trisb.b0=trisb.b1=1;
	BSF        TRISB+0, 1
	BTFSC      TRISB+0, 1
	GOTO       L__main44
	BCF        TRISB+0, 0
	GOTO       L__main45
L__main44:
	BSF        TRISB+0, 0
L__main45:
;trattic light 2.c,24 :: 		portb.b2=portb.b3=1;
	BSF        PORTB+0, 3
	BTFSC      PORTB+0, 3
	GOTO       L__main46
	BCF        PORTB+0, 2
	GOTO       L__main47
L__main46:
	BSF        PORTB+0, 2
L__main47:
;trattic light 2.c,25 :: 		porta=porte=0;
	CLRF       PORTE+0
	MOVF       PORTE+0, 0
	MOVWF      PORTA+0
;trattic light 2.c,26 :: 		portc=portd=0;
	CLRF       PORTD+0
	MOVF       PORTD+0, 0
	MOVWF      PORTC+0
;trattic light 2.c,27 :: 		inte_bit=1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;trattic light 2.c,28 :: 		gie_bit=1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;trattic light 2.c,30 :: 		intedg_bit=1;
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;trattic light 2.c,31 :: 		for(;;){
L_main1:
;trattic light 2.c,32 :: 		while(auto_manual==1){
L_main4:
	BTFSS      PORTB+0, 1
	GOTO       L_main5
;trattic light 2.c,33 :: 		for(count=15;count>=0;count--){
	MOVLW      15
	MOVWF      _count+0
L_main6:
	MOVLW      128
	XORWF      _count+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main7
;trattic light 2.c,34 :: 		if (auto_manual==0){
	BTFSC      PORTB+0, 1
	GOTO       L_main9
;trattic light 2.c,35 :: 		portc=portd=porta=porte=0;
	CLRF       PORTE+0
	MOVF       PORTE+0, 0
	MOVWF      PORTA+0
	MOVF       PORTA+0, 0
	MOVWF      PORTD+0
	MOVF       PORTD+0, 0
	MOVWF      PORTC+0
;trattic light 2.c,36 :: 		break;
	GOTO       L_main7
;trattic light 2.c,37 :: 		}
L_main9:
;trattic light 2.c,38 :: 		if (count>3){
	MOVLW      128
	XORLW      3
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main10
;trattic light 2.c,39 :: 		red_west=1;
	BSF        PORTA+0, 0
;trattic light 2.c,40 :: 		green_south=1;
	BSF        PORTE+0, 0
;trattic light 2.c,41 :: 		yellow_south =0;
	BCF        PORTA+0, 5
;trattic light 2.c,42 :: 		}
	GOTO       L_main11
L_main10:
;trattic light 2.c,44 :: 		red_west =1;
	BSF        PORTA+0, 0
;trattic light 2.c,45 :: 		yellow_south =1;
	BSF        PORTA+0, 5
;trattic light 2.c,46 :: 		green_south =0;
	BCF        PORTE+0, 0
;trattic light 2.c,47 :: 		}
L_main11:
;trattic light 2.c,48 :: 		left = count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       FLOC__main+0, 0
	MOVWF      _left+0
;trattic light 2.c,49 :: 		right = count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _right+0
;trattic light 2.c,50 :: 		trns_tins=left;
	MOVF       FLOC__main+0, 0
	MOVWF      PORTD+0
;trattic light 2.c,51 :: 		trns_ones=right;
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;trattic light 2.c,52 :: 		delay_ms(1000) ;
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
	NOP
	NOP
;trattic light 2.c,33 :: 		for(count=15;count>=0;count--){
	DECF       _count+0, 1
;trattic light 2.c,53 :: 		}
	GOTO       L_main6
L_main7:
;trattic light 2.c,54 :: 		porta=porte=0;
	CLRF       PORTE+0
	MOVF       PORTE+0, 0
	MOVWF      PORTA+0
;trattic light 2.c,55 :: 		for(count=23;count>=0;count--){
	MOVLW      23
	MOVWF      _count+0
L_main13:
	MOVLW      128
	XORWF      _count+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main14
;trattic light 2.c,56 :: 		if (auto_manual==0){
	BTFSC      PORTB+0, 1
	GOTO       L_main16
;trattic light 2.c,57 :: 		portc=portd=0;
	CLRF       PORTD+0
	MOVF       PORTD+0, 0
	MOVWF      PORTC+0
;trattic light 2.c,58 :: 		break;
	GOTO       L_main14
;trattic light 2.c,59 :: 		}
L_main16:
;trattic light 2.c,60 :: 		if (count>3){
	MOVLW      128
	XORLW      3
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main17
;trattic light 2.c,61 :: 		red_south=1;
	BSF        PORTA+0, 3
;trattic light 2.c,62 :: 		green_west=1;
	BSF        PORTA+0, 2
;trattic light 2.c,63 :: 		yellow_west =0;
	BCF        PORTA+0, 1
;trattic light 2.c,65 :: 		}
	GOTO       L_main18
L_main17:
;trattic light 2.c,67 :: 		red_south =1;
	BSF        PORTA+0, 3
;trattic light 2.c,68 :: 		yellow_west =1;
	BSF        PORTA+0, 1
;trattic light 2.c,69 :: 		green_west =0;
	BCF        PORTA+0, 2
;trattic light 2.c,70 :: 		}
L_main18:
;trattic light 2.c,71 :: 		left = count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       FLOC__main+0, 0
	MOVWF      _left+0
;trattic light 2.c,72 :: 		right = count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _right+0
;trattic light 2.c,73 :: 		trns_tins=left;
	MOVF       FLOC__main+0, 0
	MOVWF      PORTD+0
;trattic light 2.c,74 :: 		trns_ones=right;
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;trattic light 2.c,75 :: 		delay_ms(1000) ;
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
	NOP
	NOP
;trattic light 2.c,55 :: 		for(count=23;count>=0;count--){
	DECF       _count+0, 1
;trattic light 2.c,76 :: 		}
	GOTO       L_main13
L_main14:
;trattic light 2.c,77 :: 		porta=porte=0;
	CLRF       PORTE+0
	MOVF       PORTE+0, 0
	MOVWF      PORTA+0
;trattic light 2.c,78 :: 		}
	GOTO       L_main4
L_main5:
;trattic light 2.c,79 :: 		while(auto_manual==0){
L_main20:
	BTFSC      PORTB+0, 1
	GOTO       L_main21
;trattic light 2.c,80 :: 		if(counter==1){
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main48
	MOVLW      1
	XORWF      _counter+0, 0
L__main48:
	BTFSS      STATUS+0, 2
	GOTO       L_main22
;trattic light 2.c,81 :: 		porta=0b00000001;
	MOVLW      1
	MOVWF      PORTA+0
;trattic light 2.c,82 :: 		porte=0b0000001;
	MOVLW      1
	MOVWF      PORTE+0
;trattic light 2.c,83 :: 		}
	GOTO       L_main23
L_main22:
;trattic light 2.c,84 :: 		else if (counter==2){
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main49
	MOVLW      2
	XORWF      _counter+0, 0
L__main49:
	BTFSS      STATUS+0, 2
	GOTO       L_main24
;trattic light 2.c,85 :: 		porta=0b00100001;
	MOVLW      33
	MOVWF      PORTA+0
;trattic light 2.c,86 :: 		porte=0b0000000;
	CLRF       PORTE+0
;trattic light 2.c,87 :: 		for(count=3;count>=0;count--){
	MOVLW      3
	MOVWF      _count+0
L_main25:
	MOVLW      128
	XORWF      _count+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main26
;trattic light 2.c,88 :: 		left = count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       FLOC__main+0, 0
	MOVWF      _left+0
;trattic light 2.c,89 :: 		right = count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _right+0
;trattic light 2.c,90 :: 		trns_tins=left;
	MOVF       FLOC__main+0, 0
	MOVWF      PORTD+0
;trattic light 2.c,91 :: 		trns_ones=right;
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;trattic light 2.c,92 :: 		delay_ms(1000) ;
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	DECFSZ     R11+0, 1
	GOTO       L_main28
	NOP
	NOP
;trattic light 2.c,87 :: 		for(count=3;count>=0;count--){
	DECF       _count+0, 1
;trattic light 2.c,93 :: 		}
	GOTO       L_main25
L_main26:
;trattic light 2.c,94 :: 		counter = 3;
	MOVLW      3
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
;trattic light 2.c,95 :: 		}
	GOTO       L_main29
L_main24:
;trattic light 2.c,96 :: 		else if(counter==3){
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVLW      3
	XORWF      _counter+0, 0
L__main50:
	BTFSS      STATUS+0, 2
	GOTO       L_main30
;trattic light 2.c,97 :: 		porta=0b00001100;
	MOVLW      12
	MOVWF      PORTA+0
;trattic light 2.c,98 :: 		porte=0b0000000;
	CLRF       PORTE+0
;trattic light 2.c,99 :: 		}
	GOTO       L_main31
L_main30:
;trattic light 2.c,100 :: 		else if (counter == 4){
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVLW      4
	XORWF      _counter+0, 0
L__main51:
	BTFSS      STATUS+0, 2
	GOTO       L_main32
;trattic light 2.c,101 :: 		porta=0b00001010;
	MOVLW      10
	MOVWF      PORTA+0
;trattic light 2.c,102 :: 		porte=0b0000000;
	CLRF       PORTE+0
;trattic light 2.c,103 :: 		for(count=3;count>=0;count--){
	MOVLW      3
	MOVWF      _count+0
L_main33:
	MOVLW      128
	XORWF      _count+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main34
;trattic light 2.c,104 :: 		left = count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       FLOC__main+0, 0
	MOVWF      _left+0
;trattic light 2.c,105 :: 		right = count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _right+0
;trattic light 2.c,106 :: 		trns_tins=left;
	MOVF       FLOC__main+0, 0
	MOVWF      PORTD+0
;trattic light 2.c,107 :: 		trns_ones=right;
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;trattic light 2.c,108 :: 		delay_ms(1000) ;
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main36:
	DECFSZ     R13+0, 1
	GOTO       L_main36
	DECFSZ     R12+0, 1
	GOTO       L_main36
	DECFSZ     R11+0, 1
	GOTO       L_main36
	NOP
	NOP
;trattic light 2.c,103 :: 		for(count=3;count>=0;count--){
	DECF       _count+0, 1
;trattic light 2.c,109 :: 		}
	GOTO       L_main33
L_main34:
;trattic light 2.c,110 :: 		porta=porte=0;
	CLRF       PORTE+0
	MOVF       PORTE+0, 0
	MOVWF      PORTA+0
;trattic light 2.c,111 :: 		counter=1;
	MOVLW      1
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
;trattic light 2.c,112 :: 		}
L_main32:
L_main31:
L_main29:
L_main23:
;trattic light 2.c,113 :: 		}
	GOTO       L_main20
L_main21:
;trattic light 2.c,114 :: 		}
	GOTO       L_main1
;trattic light 2.c,115 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
