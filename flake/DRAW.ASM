text	segment public 'code'
	assume CS:text, DS:data
public draw

horizontal	proc
h:	
	push	CX
	mov	AH,0Ch	
	mov	BH,0	
	mov	CX,SI
	int	10h
	inc	SI
	pop	CX
	loop	h
ret
horizontal	endp


vertical	proc
v:	
	push	CX
	mov	AH,0Ch	
	mov	BH,0	
	mov	CX,SI
	int	10h
	inc	DX 
	pop	CX
	loop	v
ret
vertical	endp 
 
diagonal1	proc
d1:	
	push	CX
	mov	AH,0Ch
	mov	BH,0	
	mov	CX,SI
	int	10h
	inc	SI
	inc DX
	pop	CX
	loop	d1
ret
diagonal1	endp

diagonal2	proc
d2:	
	push	CX
	mov	AH,0Ch
	mov	BH,0	
	mov	CX,SI
	int	10h
	dec	SI
	inc DX
	pop	CX
	loop	d2
ret
diagonal2	endp 

draw proc

	mov AH,00h
	mov AL,10h
	int 10h
	mov AL,color
	mov SI,x
	mov DX,y
	sub DX,25
	mov CX,50
	call vertical
	add color,3
	mov AL,color
	mov SI,x
	mov DX,y
	sub SI,25
	mov CX,50
	call horizontal
	sub color,3
	add color,1
	mov AL,color
	mov SI,x
	mov DX,y
	sub SI,25
	sub DX,25
	mov CX,50
	call diagonal1
	sub color,1
	add color,6
	mov AL,color
	mov SI,x
	mov DX,y
	add SI,25
	sub DX,25
	mov CX,50
	call diagonal2
	sub color,6			
ret				
draw endp

text ends
data        segment 
x dw 25
y dw 50             
color db 0
data ends  
end
