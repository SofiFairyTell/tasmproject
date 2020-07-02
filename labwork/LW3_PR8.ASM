text	segment 'code'
	assume CS:text, DS:data
horizontal 	proc
     h: 
     	push CX
     	mov AH, 0ch
     	mov AL,color
     	mov BH,0
     	mov CX,SI
     	int 10h
     	inc SI
     	pop CX
     loop h
     ret
horizontal 	endp
begin:	
	mov AH,00h
	mov AL,10h
	int 10h
	mov color,9
	mov SI,200; x  координата начальная
	mov DX,110 ; y - координата начальная
	mov BL,50 ; число повторений - высота
cycle_hor:
	mov CX,200
	push SI
	call horizontal
	add DX,-1
	pop SI
	inc SI
	add BL,-1
	cmp BL,0
jge cycle_hor
	mov color,7
	mov SI,200
	mov DX,200
	mov BL,50
cycle_hor2: 
	mov CX,200 ; установка новой координаты 
	push SI
	call horizontal
	inc DX
	pop SI
	inc SI
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
end begin

