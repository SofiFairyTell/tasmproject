Text    segment  ;Начало сегмента команд
        assume CS:text,DS:data 
begin:  mov AX,data       ;Инициализация сегментного
        mov DS,AX         ;регистра DS
        mov CX,10         ;Число шагов в цикле
        mov AX,5          
again:  cmp CX,AX       ;сравнить значения
        jb exit
        add symbol,1
        add CX,-1       ;уменьшить значение счетчика на 1
        jmp again
exit:   mov DX, offset symbol
        mov AH,9
        int 21h
        mov AX,4C00h      
        int 21h           
text    ends            
data    segment         
symbol db ('0$')        ;заполняемый массив
data    ends            
stk     segment stack 'stack'   
        dw 128 dup (0)      
stk     ends                
end begin           ;Конец текста программы
