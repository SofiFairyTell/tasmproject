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
message db 80*18 dup (' ')
db 9,'Another group consist of specific ascepcts',10,13,' of implementation'
db'in Assembler and haedware and system capabilities of',10,13,'a Personal computer:',10,13
db 9,'- input/output programming;',10,13
db 9,'- BIOS and function DOS;',10,13
db 9,'- memory managment.$'
data    ends				;Конец сегмента данных
stk     segment stack 'stack'		;Начало сегмента стека
	  dw 128 dup (0)			;Стек
stk     ends				;Конец сегмента стека
	  end begin				;Конец текста программы
