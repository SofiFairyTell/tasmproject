Text    segment			  	;Начало сегмента команд
assume CS:text,DS:data
begin: mov AX,data			;Инициализация сегментного
    mov DS,AX				    ;регистра DS
    mov AH,09				    ;Функция DOS вывода на экран
    mov DX,offset message		;Адрес выводимого сообщения
    int 21h				        ;Вызов DOS
    mov AX,4C00h			    ;Завершение программмы
    int 21h
text    ends				;Конец сегмента команд
data    segment				;Начало сегмента данных
message db 3 dup (' '), '*',10,13
        db 2 dup (' '), '/|\',10,13
        db ' ', '//|\\',10,13
        db  '///|\\\',10,13
        db 2 dup (' '), '_|_$'
data    ends				;Конец сегмента данных
stk     segment stack 'stack';Начало сегмента стека
        dw 128 dup (0)		;Стек
stk     ends				;Конец сегмента стека
end begin				    ;Конец текста программы