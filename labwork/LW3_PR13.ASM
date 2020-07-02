Text        segment 'code'          
            assume CS:text,DS:data

shadow      proc
            mov CX,x
            mov DX,y
            mov AH,0Ch          
            mov AL,0        
            mov BH,0      
            int 10h                         
            ret                     
shadow      endp

draw        proc                        
            mov AH,0Ch                  
            mov AL,color                
            mov BH,0              
            mov CX,x                    
            mov DX,y                    
            int 10h                     
            ret                         
            draw endp                   
        
up          proc
            call shadow
            sub y,1 
            call draw
            ret                     
up          endp

down        proc
            call shadow
            add y,1 
            call draw                   
            ret                     
down        endp

left        proc
            call shadow
            sub x,1 
            call draw                       
            ret                     
left        endp

right       proc
            call shadow
            add x,1 
            call draw                       
            ret                       
right       endp

colorChange proc                        
            sub AL, 48 ; отбрасываем все числа которые не в 0
            mov color, AL
            call draw 
            ret                     
colorChange endp

main        proc
            mov AX,data             
            mov DS,AX           
            mov AX,00h              
            mov AL,10h              
            int 10h                 
            
            mov CX,x
            mov DX,y
            mov AH,0Ch          
            mov AL,color        
            mov BH,0     
            int 10h             
            
input:      mov AH,08h          
            int 21h                         
            cmp AL,44h ; f10
            je exit
            cmp AL,4Bh 
            je goLeft
            cmp AL,4Dh
            je goRight
            cmp AL,48h
            je  goUp
            cmp AL,50h
            je  goDown
            cmp AL,'0' ; исчезает
            jb input
            cmp AL,'9'
            ja input
            call colorChange
            jmp input

goLeft:     call left
            jmp input

goRight:    call right
            jmp input
            
goUp:       call up
            jmp input

goDown:     call down
            jmp input           
            
exit:       mov AH,00h          
            mov AL,03h          
            int 10h             
            mov AX,4C00h        
            int 21h             
main        endp 
text        ends                    
data        segment                 
x           dw 320
y           dw 175
color       db 14                        
data        ends                    
            end main
