text	segment 'code'
	assume CS:text
left 	proc
     l: 
     	push CX
     	mov AH, 0ch
     	mov AL,9 ; установка цвета
     	mov BH,0
     	mov CX,SI
     	int 10h
     	add SI,-2
     	pop CX
     loop l
     ret
left 	endp
right 	proc
     r: 
     	push CX
     	mov AH, 0ch
     	mov AL,4 ; установка цвета
     	mov BH,0
     	mov CX,SI
     	int 10h
     	add SI,2
     	pop CX
     loop r
     ret
right 	endp
begin:	
	mov AH,00h
	mov AL,10h
	int 10h
	mov DX,110 ; y - координата начальная
	mov BL,50 ; число повторений
	mov CX,1; длина стороны
cycle_left:
	mov SI,300 ; x - начальная координата 
	push CX
	call left
	pop CX
	inc CX
	add DX,3
	add BL,-1
	cmp BL,0
jge cycle_left
	mov DX,110 ; y - координата начальная
	mov BL,50 ; число повторений
	mov CX,1; длина стороны
cycle_right: 
	push CX
	mov SI,300 ;x  координата начальная
	call right
	pop CX
	inc CX
	add DX,3
	add BL,-1
	cmp BL,0
jge cycle_right
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

