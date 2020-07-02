Text    segment 'code'  
        assume CS:text,DS:data
                         
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
                        
main    proc
        mov AX,data         
        mov DS,AX            
                        
begin:  mov AH,09h              
        mov DX,offset message   
        int 21h             
        call stop          
        call main           
main    endp 
text    ends                  
data    segment             
message db '* $' 
data    ends                   
        end main


; text 	segment 'code'
;  	assume cs:text
;  line proc 
;  	h: 
;  		push cx
;  		mov ah,0ch
;  		mov al,9
;  		mov bh,0
;  		mov cx,si
;  		int 10h
;  		inc si
;  		pop cx
;  	loop h
;  	mov si, 200
;  	inc dx
;  	mov cx, 200
;  	add bl,-1
;  	cmp bl,0
;  	je exit_line;рекурсия реализована здесь
;  	call line ;если условие ранее не выполнилось то программа вызывает сама себя
;  exit_line:
;  	ret
;  line endp
;  begin:
;  	mov ah,00h
;  	mov al,10h
;  	int 10h
;  	mov bl,70
;  	mov si,200
;  	mov dx,110
;  	mov cx,200
;  	call line
;  	mov ah,08h
;  	int 21h
;  	mov ah,00h
;  	mov al,03h
;  	int 10h
;  	mov ax,4c00h
;  	int 21h
;  text ends
;  stk	segment stack 'stack'	;(39)Начало сегмента стека
;  	dw 128 dup (0)		;(40)Стек
;  stk	ends			;(41)Конец сегмента стека
;  end begin
