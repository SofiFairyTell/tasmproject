Text    segment			  	;Начало сегмента команд
assume CS:text,DS:data
Begin:  mov AX,data			;Инициализация сегментного
mov DS,AX				    ;регистра DS
mov AH,09				    ;Функция DOS вывода на экран
mov DX,offset message		;Адрес выводимого сообщения
int 21h				        ;Вызов DOS
mov AX,4C00h			    ;Завершение программмы
int 21h
text    ends				;Конец сегмента команд
data    segment				;Начало сегмента данных
;прорисовка рисунка "ёлочка"
    message db 20*12 dup (' ')
    db 9, 8 dup (' '), 42,  10,13
    db 9, 7 dup (' '), 3 dup (42),  10,13
    db 9, 6 dup (' '), 5 dup (42),  10,13
    db 9, 5 dup (' '), 7 dup (42),  10,13
    db 9, 4 dup (' '), 9 dup (42),  10,13
    db 9, 3 dup (' '), 11 dup (42), 10,13
    db 9, 2 dup (' '), 13 dup (42),  10,13
    db 9, 8 dup (' '), 2 dup (42), ('$'),  10,13
data    ends				;Конец сегмента данных
stk     segment stack 'stack';Начало сегмента стека
	  dw 128 dup (0)		;Стек
stk     ends				;Конец сегмента стека
	  end begin				;Конец текста программы