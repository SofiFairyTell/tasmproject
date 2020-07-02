text	segment public 'code'
	assume CS:text, DS:data
extrn draw:proc	

public control 
control proc
	mov ah,06h
        mov dl,0ffh
        int 21h
        cmp al,13
        je zex
	cmp AL,72
	jne zelse1
	cmp y,25
	je znext0
	sub y,10
znext0:	call draw
	jmp zendifelse
zelse1:	
	cmp AL,80
	jne zelse2
	cmp y,350
	je znext1
	add y,10
znext1:	call draw
	jmp zendifelse
zelse2:	
	cmp AL,75
	jne zelse3
	cmp x,25
	je znext2
	sub x,10
znext2:	call draw
	jmp zendifelse
zelse3:
	cmp AL,77
	jne zelseexit
	cmp x,615
	je znext3
	add x,10
znext3:	call draw
	jmp zendifelse
zelseexit: 
	cmp AL,27
	jne zendifelse
	jmp exit
zex: mov stop,1
exit:	
	mov AH,00h
	mov AL,03h
	int 10h
	mov AX,4C00h
	int 21h
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