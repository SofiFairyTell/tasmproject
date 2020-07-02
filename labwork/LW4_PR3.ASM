dely    macro time; (1)
        local zd,c1,cikl,ii,ii1; (2) описываем все метки, используемые вмакроопределении
        push cx; (3)помещаем в стек используемые в макроопределении регистры
        push bx; (4)
        push bp; (5)
        push ax; (6)
        push dx; (7)
        mov cx,time; (8) задаём количество повторений цикла задержки zd – задержка в цикле 18.2 секунды
zd:     push cx; (9)
        mov bp,0;(10)
        mov bx,1;(11)
        
cikl:   
        inc BP;(12)
        mov ah,00h;(13)       
        int 1Ah;(14)
        cmp BP,1;(15)
        je ii;(16) переходим на метку ii на первой итерации цикла
        jmp ii1;(17) на следующих итерациях переходим на метку ii1
ii:     add bx,dx;(18) формируем значение на единицу больше, чем в регистре dx
ii1:                    ; (19)
        cmp bx,dx;(20) если значение в регистре dx изменилось(сравниваем значение в dx с сформированным в строке 18 значением в регистре bx, которое на единицу больше, на единицу больше значение в dx станет через 18.2 сек)
        jne cikl;(21) если нет, то новая итерация цикла
        pop cx;(22) если да, конец макрокоманды задержки
        loop zd;(23)
        pop cx;(24)
        pop bx;(25)
        pop bp;(26)
        pop ax;(27)
        pop dx;(28)
        endm;(29)
Text	  segment 'code';	(30)	        
	  assume CS:text,DS:data; (31)

;процедура рисования прямоугольника
Prymoug   proc; (32)
                mov AL,cvet;(33) определяем цвет
                mov BH,0; (34) видеостраница
                mov SI,250;(35) задаём начальные 
                mov DI,150;(36) координаты
                mov CX,y; (37) высота прямоугольника
Prym1:       push CX ; (38) 
                mov CX,x; (39) ширина прямоугольника
Prym:        push CX;	        
                mov AH,0ch;(40)  функция ввода пиксела
                mov CX,SI;(41) задаем начальные
                mov DX,DI;(42) координаты
                int 10h;(43) перрывание BIOS
                inc SI;(44) смещение по оси ox
                pop CX; (45)
                loop Prym;(45)
                inc DI;(46) смещение по oy
                mov SI,250;(47) возвращаем прежнюю x-координату
                pop CX;(48)
                loop Prym1;(49)               
          ret ;(50)
Prymoug   endp;(51)
;процедура задержки
Zadergka   proc;(52)
                mov bp,1;(53)
                mov cvet1,1;(54)
mig:                             ;(55)
                mov bl,cvet1;(56)задаём значение
                mov cvet,bl;(57)цвета
                call prymoug;(58)
                dely 18;(59) задержка в одну секунду       
                inc bp;(60)
                cmp bp,3;(61) на третьей итерации цикла(когда задержка будет 3 сек.) переходим 
                je  changCvet;(62) на метку changCvet
                mov ah,06h;(63) функция ввода с клавиатуры без эха
                mov dl,0ffh;(64) задаём режим функции
                int 21h;(65) 
                cmp al,44h;(66) если нажата F10( 44h –ASCI код F10), то переходим на ex – выход из программы
                jne mig;(67)
                jmp ex;(68)       
changCvet:      inc iter;(69) меняем константу цвета
                cmp iter,1
                je yellow
                cmp iter,2
                je green
                cmp iter,3 
                je yellow
                cmp iter,4
                je red
red:        ;call refresh
        mov b,80
        mov color,4
        mov iter,0
        mov bp,1
        jmp mig
yellow:     ;call refresh
        mov b,50
        mov color,14
        mov bp,1
        jmp mig
green:      ;call refresh
        mov b,20
        mov color,2
        mov bp,1;(70) приводим счётчик в исходное положение
        jmp mig ;(71)
ex:                          ;(72)
          ret                 ;(73)
Zadergka   endp       ;(74)
	        
;главная процедура
Main            proc;(75)	        
                mov AX,data;(76)			
	        mov DS,AX;(77)
                int 21h;(78)
                mov x,30;(79) задаём ширину прямоугольника
                mov y,30;(80)
                mov AH,00h;(81) функция задания режима	
                mov AL,10h;(82) графический режим EGA
                int 10h;(83) прерывание BIOS
                call Zadergka;(84) вызываем процедуру задержки
                mov AH,00h;(85) возвращаемся в
                mov AL,03h;(86) текстовый режим
                int 10h;(87)
                mov ax,4c00h;(88)
	        int 21h;(89)  
main            endp;(90)
text            ends;(91)
data            segment;(92)
                x dw 0;(93)
                y dw 0;(94)
                cvet db 0;(95)
                cvet1 db 0;(96)
data            ends;(97)
stk             segment stack 'stack';(98)
                dw 128 dup (0);(99)
stk             ends;(100)
		end main;(101)	
