Text    segment  ;Начало сегмента команд
        assume CS:text,DS:data 
Begin:  mov AX,data       ;Инициализация сегментного
        mov DS,AX         ;регистра DS
        mov CX,10         ;Число шагов в цикле
        mov AH,9          ;цикл, в который входит 4 команды
        mov DX, offset symbols 
fill:   int 21h
        loop fill
        mov AX,4C00h      
        int 21h           
text    ends            
data    segment         
symbols db ('@$')        
data    ends                ;(22)Конец сегмента данных
stk     segment stack 'stack'   ;(23)Начало сегмента стека
        dw 128 dup (0)      ;(24)Стек
stk     ends                ;(25)Конец сегмента стека
end begin           ;(26)Конец текста программы
