text	segment public 'code'
	assume CS:text, DS:data
extrn draw:proc	
extrn control:proc

public ChangeColor 
dely    macro time
        local zd,c1,cikl,ii,ii1 	; задание уникальных меток
        push cx
        push bx
        push bp
        push ax
        push dx
        mov cx,time 	;определение времени задержки
zd:     push cx
        mov bp,0
        mov bx,1
        call control 	;вызов процедуры управления при смене цвета
cikl:  	inc BP
        mov ah,00h       
        int 1Ah 	;прерываение BIOS
        cmp BP,1
        je ii
        jmp ii1
ii:     add bx,dx
ii1:                   
        cmp bx,dx
        jne cikl
        pop cx
        loop zd 	;возврат в начало цикла потому что макроопределение еще не завершено
        pop cx
        pop bx
        pop bp
        pop ax
        pop dx
endm

ChangeColor   proc
                mov bp,0
		mov stop,0           
mig:                                             		
	cmp color,15	;проверка на цвет
	je firstcolor	;не можем увеличить, потому что 15 последний
	cmp color,14	;не можем увеличить, потому что 15 последний
	je firstcolor
	cmp color,9	;проверка на совпадение с цветом фона
	je dontbkcolor 	; перейти к этой метке в случае совпадения цвета с фоном
	cmp color,12	;проверка на совпадение с цветом фона
	je dontbkcolor
	inc color
	jmp enddontbkcolor
dontbkcolor: add color,2
	jmp enddontbkcolor	
firstcolor: mov color,1	;присваиваем цвет отличный от фона
enddontbkcolor:                
		call draw	
                dely 18
		cmp stop,1	;переменная меняется в процедуре control
		je ex      
               	inc bp
		cmp bp,7
                	je  ex	
                	jmp mig 	;возврат в начало
ex:                        
          ret 	;возврат в основную программу (главный модуль)           
ChangeColor   endp

text ends
data        segment 
x dw 0
y dw 0              
color db 0
stop db 0
data ends  
end