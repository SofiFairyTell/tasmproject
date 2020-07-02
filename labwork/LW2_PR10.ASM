text    segment  ;Начало сегмента команд
        assume CS:text,DS:data 
begin:  mov AX,data       ;Инициализация сегментного
        mov DS,AX         ;регистра DS
        mov BX, offset txt
        mov SI, 0
inpt:   mov AH, 01h
        int 21h
        cmp AL,0
        je ascii
        mov [BX][SI],AL
        inc SI
        jmp inpt 

ascii:  mov AH, 08h ;ввод символа без эха
        int 21h
        cmp AL,44h
        je outp
        jmp inpt

outp:   mov DX, offset next
        mov AH,09h
        int 21h
        add SI,-1
        jmp body

body:   cmp SI,0
        jl exit
        mov DL, [BX][SI]
        mov AH,2
        int 21h
        add SI, -1
        jmp body

exit:   mov AX,4C00h      
        int 21h           
text    ends            
data    segment  
next    db 10,13, '$'
txt     db 80 dup(?)       
data    ends            
stk     segment stack 'stack'   
        dw 128 dup (0)      
stk     ends                
end begin           ;Конец текста программы
