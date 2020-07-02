text	segment public 'code'
	assume CS:text, DS:data
extrn draw:proc	;вызов процедуры из файла DRAW
public control 	;объявление процедуры для вызова в других файлах

;процедура управления фигурой одновременно с изменением цвета
control proc
zstart:
	mov ah,06h	;записать код нажатой клавишы
        mov dl,0ffh
        int 21h
        cmp AL,32
        je zex
	cmp AL,72 	;проверка на клавишу вверх
	jne zelse1
	cmp y,25
	je znext0
	sub y,10
znext0:	call draw
	jmp zendifelse
zelse1:	
	cmp AL,80 	;проверка на клавишу вниз
	jne zelse2
	cmp y,350
	je znext1
	add y,10
znext1:	call draw
	jmp zendifelse
zelse2:	
	cmp AL,75 	;проверка на клавишу влево
	jne zelse3
	cmp x,25
	je znext2
	sub x,10
znext2:	call draw
	jmp zendifelse
zelse3:
	cmp AL,77 	;проверка на клавишу вправо
	jne zelseexit
	cmp x,615	;проверка на крайную правую границы
	je znext3	;перейти к метке в случае равенства
	add x,10
znext3:	call draw 	;выполнить перерисовку фигуры
	jmp zendifelse
zelseexit: 
	cmp AL,27	;проверка на ESC
	jne zendifelse
	jmp exit 	; перейти к завершению программы
zex: mov stop,1 	;изменение значения переменной
     jmp zstart
;переход на данную метку завершит выполнение программы даже во время измения ее цвета
exit:	
	mov AH,00h
	mov AL,03h 	;возврат к текстовому режиму
	int 10h
	mov AX,4C00h 	;завершение программы
	int 21h 	;прерываение MS-DOS
zendifelse: ret
control endp

text ends
data        segment 
x dw 25
y dw 50              
color db 0
stop db 0
data ends  
end