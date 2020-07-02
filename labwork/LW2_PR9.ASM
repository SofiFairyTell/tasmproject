Text    segment  ;Начало сегмента команд
        assume CS:text,DS:data 
begin:  mov AX,data       ;Инициализация сегментного
        mov DS,AX         ;регистра DS
        mov CL,10         ;Число шагов в цикле
                  
again:  cmp s,CL       ;сравнить значения
        ja exit 
        add s,2
        mov DX, offset symbol
        mov AH,9
        int 21h
        jmp again
exit:   mov AX,4C00h      
        int 21h           
text    ends            
data    segment         
symbol  db ('00$')        ;заполняемый массив
s       db 5, '$'
data    ends            
stk     segment stack 'stack'   
        dw 128 dup (0)      
stk     ends                
end begin           ;Конец текста программы
