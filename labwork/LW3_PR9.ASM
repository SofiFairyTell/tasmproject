text	segment 'code'
	assume CS:text,DS:data
horizontal 	proc
     h: 
     	push CX
     	mov AH, 0ch ;функция вывода пикселя
     	mov AL,color
     	mov BH,0
     	mov CX,SI
     	inc SI
     	int 10h
     	pop CX
     loop h
     ret
horizontal 	endp
begin:	
	mov AH,00h
	mov AL,10h
	int 10h
	mov color,9
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
	mov color,4
	mov DX,110 ; y - координата начальная
	mov BL,100 ; число повторений
	mov CX,75; длина стороны
cycle_hor2: 
	mov SI,200 ;x  координата начальная
	push CX
	call horizontal
	inc DX
	pop CX
	inc CX
	add BL,-1
	cmp BL,0
jge cycle_hor2
	mov AH,08h
	int 21h
	mov AH,00h
	mov AL,03h
	int 10h
        mov AX,4C00h     ;завершаем работу программы
        int 21h	
text	ends
data        segment                 
color       db 0 
data ends    
stk segment stack 'stack'
	dw 128 dup(?)
stk ends
end begin

