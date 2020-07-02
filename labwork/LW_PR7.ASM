Text    segment			  	;Начало сегмента команд
assume CS: text, DS:data
Begin:  mov AX,data			;Инициализация сегментного
		mov DS,AX				;регистра DS
		mov AH,09				;Функция DOS вывода на экран
		mov DX,offset message	;Адрес выводимого сообщения
int 21h				;Вызов DOS
mov AX,4C00h			;Завершение программмы
int 21h
text    ends				;Конец сегмента команд
data    segment				;Начало сегмента данных
message db 25 dup (7),20*12 dup (32)
		db 35 dup (32),201,9 dup (205),187,10,13
		db 35 dup (32),186,65,84,69,78,84,73,79,78, 33,186,10,13 
		db 35 dup (32),200,9 dup (205),188,10,13, 10*20 dup (32),'$'
data    ends				;Конец сегмента данных
stk     segment stack 'stack'		;Начало сегмента стека
	  dw 128 dup (0)			;Стек
stk     ends				;Конец сегмента стека
	  end begin				;Конец текста программы
