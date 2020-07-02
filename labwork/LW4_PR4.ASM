text 	segment 'code'
	assume cs:text, ds:data
stop    proc
        mov AH,08h      
        int 21h         
        cmp AL,44h ; f10
        je exit
        ret             
exit:   
	mov AX,4C00h        
        int 21h     
stop    endp

dely 	proc 
	push cx
	push bx
	push bp
	push ax
	push dx
	mov cx,18
	zd: 
		push cx
		mov bp,0
		mov bx,1
		cikl1:
			inc bp
			mov ah,00h
			int 1Ah
			cmp bp,1
			je ii
			jmp ii1
		ii: 	add bx,dx
		ii1: 	cmp bx,dx
			jne cikl1
			pop cx
		loop 	zd
		pop 	cx
		pop bx
		pop bp
		pop ax
		pop dx
		ret
	endp 
main 	proc 
	mov ax,data
	mov ds,ax
repeating:
	mov dx,offset string
	mov AH,09h
	int 21h
	call dely
	call stop
	inc string+4
	cmp string+4,'9'
	jg change
	jmp repeating
	change:
		mov string+4,'0'
		inc string+3
		cmp string+3,'6'
		jl repeating
		mov string+3,'0'
		inc string+1
		cmp string+1,'9'
		jle repeating
		mov string+1,'0'
		inc string
		cmp string,'9'
		jle repeating
	;exit:
	;	mov ax,4c00h
	;	int 21h
main 	endp
text 	ends 
data segment 'data'
	string db '00:00',13,'$'
data ends
end main 
