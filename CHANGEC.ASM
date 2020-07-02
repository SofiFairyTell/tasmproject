text	segment public 'code'
	assume CS:text, DS:data
extrn draw:proc	
extrn control:proc

public ChangeColor 
dely    macro time
        local zd,c1,cikl,ii,ii1
        push cx
        push bx
        push bp
        push ax
        push dx
        mov cx,time
zd:     push cx
        mov bp,0
        mov bx,1
        call control
cikl:  	inc BP
        mov ah,00h       
        int 1Ah
        cmp BP,1
        je ii
        jmp ii1
ii:     add bx,dx
ii1:                   
        cmp bx,dx
        jne cikl
        pop cx
        loop zd
        pop cx
        pop bx
        pop bp
        pop ax
        pop dx
endm

ChangeColor   proc
                mov bp,0
		mov stop,0           
mig:                                             		
	cmp color,15
	je firstcolor
	cmp color,14
	je firstcolor
	cmp color,9
	je dontbkcolor
	cmp color,12
	je dontbkcolor
	inc color
	jmp enddontbkcolor
dontbkcolor: add color,2
	jmp enddontbkcolor	
firstcolor: mov color,1
enddontbkcolor:                
		call draw	
                dely 18
		cmp stop,1
		je ex      
               	inc bp
		cmp bp,7
                	je  ex	
                	jmp mig
ex:                        
          ret                 
ChangeColor   endp

text ends
data        segment 
x dw 0
y dw 0              
color db 0
stop db 0
data ends  
end