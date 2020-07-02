text	segment public 'code'
	assume CS:text,DS:data
extrn draw:proc	 	;вызов внешней процедуры из файла DRAW
extrn ChangeColor:proc 	;вызов внешней процедуры из файла CHANGEC

main proc
	mov AX,data
	mov DS,AX
	call draw 	;рисуем 8-гольник 
start:	mov AH,08h
	int 21h
	cmp AL,72 	;проверка на клавишу вверх
	jne else1	
	cmp y,50	;для проверки на выход за границы экрана и возможный возврат
	je next0	
	sub y,10
next0:	
	call draw
	jmp endifelse
else1:	
	cmp AL,80 	;проверка на клавишу вниз
	jne else2
	cmp y,300
	je next1
	add y,10
next1:	
	call draw
	jmp endifelse
else2:	
	cmp AL,75 	;проверка на клавишу влево
	jne else3
	cmp x,25 	;для проверки на выход за границы экрана и возможный возврат
	je next2
	sub x,10
next2:	call draw
	jmp endifelse
else3:
	cmp AL,77 	;проверка на клавишу вправо
	jne elsecolor
	cmp x,600 	;для проверки на выход за границы экрана и возможный возврат
	je next3
	add x,10
next3:	call draw 	;рисование 8-угольника
	jmp endifelse
elsecolor: cmp AL,13 	;проверка на Enter
	jne elseexit
	call ChangeColor 	;вызов процедуры изменения цвета
	jmp endifelse	
elseexit: cmp AL,27 	;проверка на ESC
	jne endifelse
	jmp exit
endifelse: jmp start
exit:	
	mov AH,00h
	mov AL,03h	 ;возвращение в текстовый режим
	int 10h
	mov AX,4C00h	 ;завершение программы
	int 21h 	;прерывание MS-DOS
main endp
text ends 
data        segment 
x dw 25 	;начальные координаты X и Y
y dw 0             

data ends  
end main
