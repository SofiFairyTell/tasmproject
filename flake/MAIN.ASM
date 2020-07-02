text	segment public 'code'
	assume CS:text,DS:data
extrn draw:proc	
extrn ChangeColor:proc
extrn Screen:proc

main proc
	mov AX,data
	mov DS,AX
	call draw
start:	mov AH,08h
	int 21h
	cmp AL,72
	jne else1	
	;cmp y,25
	cmp y,50
	je next0	
	sub y,10
next0:	
	call draw
	jmp endifelse
else1:	
	cmp AL,80
	jne else2
	;cmp y,325
	cmp y,300
	je next1
	add y,10
next1:	
	call draw
	jmp endifelse
else2:	
	cmp AL,75
	jne else3
	cmp x,25
	je next2
	sub x,10
next2:	call draw
	jmp endifelse
else3:
	cmp AL,77
	jne elsecolor
	;cmp x,615
	cmp x,600
	je next3
	add x,10
next3:	call draw
	jmp endifelse
elsecolor: cmp AL,13
	jne elseexit
	call ChangeColor
	jmp endifelse	
elseexit: cmp AL,27
	jne endifelse
	jmp exit
endifelse: jmp start
exit:	
	mov AH,00h
	mov AL,03h
	int 10h
	mov AX,4C00h
	int 21h
main endp
text ends 
data        segment 
x dw 25
y dw 0             
color db 2
data ends  
end main
