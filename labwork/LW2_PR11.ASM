text    segment  ;Начало сегмента команд
        assume CS:text,DS:data 
begin:  mov AX,data       ;Инициализация сегментного
        mov DS,AX         ;регистра DS
        
        
inpt:   mov AH, 07h ;ввод символов с эхом
        int 21h
        cmp AL,0
        je ascii; если код первого символа равен 0, то перейти на метку
        cmp AL,'9'
        ja inpt ; если больше то не обрабатывать и вернутся к inpt
        cmp AL, '1' ; если меньше то вернутся к inpt
        jb inpt
        mov CX,0
        mov CL,AL
        mov DX, offset next
        mov AH, 09h
        int 21h
        mov DX, offset star
fill:   cmp CL,'0'
        jbe inpt
        add CL,-1
        mov AH, 09h
        int 21h
        jmp fill

ascii:  mov AH, 08h ;ввод символа без эха повторный ввод
        int 21h
        cmp AL,44h
        je exit
        jmp inpt

exit:   mov AX,4C00h      
        int 21h           
text    ends            
data    segment  
next    db 10,13, '$'
star    db '*$'       
data    ends            
stk     segment stack 'stack'   
        dw 128 dup (0)      
stk     ends                
end begin           ;Конец текста программы
