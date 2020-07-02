dely    macro ; (1)
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

Text  segment public 'code';   (30)            
      assume CS:text,DS:data; (31)
;extrn triangle:proc
InputInt 	proc 
	mov ah,0ah
	xor di,di
	mov dx,offset buff;адрес буфера
	int 21h
	mov dl,0ah
	mov ah,02
	int 21h
	;обрабатываем содержимое буфера
	mov si,offset buff+2
ii1:	xor ax,ax
	mov bx,10
ii2:
	mov cl,[si] ; берем символ из буфера
	cmp cl,0dh ; не последний ли он?
	jz endin
	;символ не последний значит проверим правильность
	sub cl,'0'; делаем из символа число
	mul bx ;умножаем на 10
	add ax,cx
	inc si
	jmp ii2
	;все символы из буфера обработаны число в ax
endin:
	ret
InputInt endp 
refresh 	proc
	mov ax,00h
	mov al,10h
	int 10h
ret
refresh endp 

	
;процедура рисования треугольника
triangle   proc; (32)
                mov AL,14;(33) определяем цвет
                mov BH,0; (34) видеостраница
                mov SI,150;(35) задаём начальные 
                mov DI,150;(36) координаты
                mov CX,y; (37) высота треугольника
Prym1:       push CX ; (38) 
                mov CX,lngt; (39) ширина линии
Prym:        push CX;           
                mov AH,0ch;(40)  функция ввода пиксела
                mov CX,SI;(41) задаем начальные
                mov DX,DI;(42) координаты
                int 10h;(43) перрывание BIOS
                inc SI;(44) смещение по оси ox
                pop CX; (45)
                loop Prym;(45)
                inc DI;(46) смещение по oy
                dec x
                mov SI,x;(47) возвращаем прежнюю x-координату
                pop CX;(48)
                add lngt,2               
                loop Prym1             
          ret ;(50)
triangle  endp;(51)
;процедура задержки
Zadergka   proc;(52)
                mov bp,1;(53)
               ; mov cvet1,1;(54)
mig:                             ;(55)
               ; mov bl,color;(56)задаём значение
                ;mov color,bl;(57)цвета
                push x
                push lngt
                call triangle;(58)
                dely;(59) задержка в одну секунду       
                call refresh
                dely
                pop lngt
                pop x
                inc bp;(60)
                ;cmp bp,3;(61) на третьей итерации цикла(когда задержка будет 3 сек.) переходим 
                ;je  changCvet;(62) на метку changCvet
                mov ah,06h;(63) функция ввода с клавиатуры без эха
                mov dl,0ffh;(64) задаём режим функции
                int 21h;(65) 
                cmp al,44h;(66) если нажата F10( 44h –ASCI код F10), то переходим на ex – выход из программы
                jne mig;(67)
                jmp ex;(68)       
ex:                          ;(72)
          ret                 ;(73)
Zadergka   endp       ;(74)
            
;главная процедура
Main            proc;(75)           
                mov AX,data;(76)            
                mov DS,AX;(77)
                ; int 21h;(78)
                ; mov x,30;(79) задаём ширину прямоугольника
                ; mov y,30;(80)
                mov AH,00h;(81) функция задания режима  
                mov AL,10h;(82) графический режим EGA
                int 10h;(83) прерывание BIOS
                call InputInt
                mov cx,ax
                mult:
                	add time,18
                	loop mult
                call Zadergka;(84) вызываем процедуру задержки
                mov AH,00h;(85) возвращаемся в
                mov AL,03h;(86) текстовый режим
                int 10h;(87)
                mov ax,4c00h;(88)
            int 21h;(89)  
main            endp;(90)
text            ends;(91)
data            segment;(92)
                x dw 150;(93)
                y dw 150;(94)
                lngt dw 1
                ; b dw 50
                time dw 0
                ; iter db 0
                color db 14;(95)
                error db "incorrect number$"
                buff db 6,7 dup(?)
data            ends;(97)
stk             segment stack 'stack';(98)
                dw 128 dup (0);(99)
stk             ends;(100)
        end main;(101)  
