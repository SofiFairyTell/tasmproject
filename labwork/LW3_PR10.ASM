text	segment 'code'
	assume CS:text
horizontal 	proc
     h: 
     	push CX
     	mov AH, 0ch ;функция вывода пикселя
     	mov AL,9
     	mov BH,0
     	mov CX,SI
     	inc SI
     	int 10h
     	pop CX
     loop h
     ret
horizontal 	endp
left 	proc
     l: 
     	push CX
     	mov AH, 0ch
     	mov AL,4 ; установка цвета
     	mov BH,0
     	mov CX,SI
     	int 10h
     	add SI,-1
     	pop CX
     loop l
     ret
left 	endp
begin:	
	mov AH,00h
	mov AL,10h
	int 10h
	mov DX,110 ; y - координата начальная
	mov BL,100 ; число повторений
	mov CX,150; длина стороны
cycle_hor:
	mov SI,200 ; x - начальная координата 
	push CX
	call horizontal
	inc DX
	pop CX
	inc CX
	add BL,-1
	cmp BL,0
jge cycle_hor
	mov DX,110 ; y - координата начальная
	mov BL,100 ; число повторений
	mov CX,1; длина стороны
cycle_left: 
	push CX
	mov SI,200 ;x  координата начальная
	call left
	pop CX
	inc CX
	inc DX
	add BL,-1
	cmp BL,0
jge cycle_left
	mov AH,08h
	int 21h
	mov AH,00h
	mov AL,03h
	int 10h
        mov AX,4C00h     ;завершаем работу программы
        int 21h	
text	ends
stk segment stack 'stack'
	dw 128 dup(?)
stk ends
end begin

