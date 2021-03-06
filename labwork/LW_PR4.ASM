text segment 'code'	; (1) Начало сегмента команд
	assume CS: text, DS: data	; (2) CS – на сегмент команд,
			;  DS – на сегмент данных
begin:	mov	AX, data	; (3) Адрес сегмента данных загрузим
	mov	DS, AX	; (4) сначала в АХ, затем в DS
	push	DS	; (5) Загрузим в стек содержимое DS
	pop	ES	; (6) Выгрузим его из стека в ES
	mov	AH, 9	; (7) Функция DOS вывода на экран
	mov	DX,offset message	; (8) Адрес выводимого сообщения
	int	21h 	; (9) Вызов DOS
	mov	AX,4C00h	; (10) Функция DOS завершения программы
	int	21h	;  (11) Вызов DOS
text	ends		;  (12) Конец сегмента команд
data	segment	;  (13) Начало сегмента данных
message	db 'KNOLEDGE IS POWER 3$'	; (14) Выводимый текст
data	ends		;  (15) Конец сегмента данных
stk	segment stack ;  (16) Начало сегмента стека
	dw	128 dup(0)	; (17) Под стек отведено 128 слов
stk	ends		; (18) конец сегмента стека
	end	begin 	;  (19) Конец текста программы 
