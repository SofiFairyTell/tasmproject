Text	segment 'code'		;Начало общего сегмента команд
	assume CS:text, DS:data
;Процедура-подпрограмма остановки выполнения до нажатия произвольной клавиши 
stop 	proc
	mov AH,08h			;Функция ввода с клавиатуры
	int 21h			;Вызов DOS 
	ret				;Возврат в вызывающую программу
stop endp
;Главная процедура
main	proc
	mov AX,data			;Инициализация сегментного
	mov DS,AX			;регистра DS 
;Организуем бесконечный вывод на экран тестового сообщения 
begin:	mov AH,09h			;Функция вывода
	mov DX,offset message	;Адрес сообщения
	int 21h			;Вызов DOS
	call stop			;Вызов подпрограммы
	cmp AL,44h ;F10 
	je exit
jmp begin			;Бесконечный цикл
exit:           int 21h;
                mov AX,4C00h     ;завершаем работу программы
                int 21h
main		endp 
text		ends				;Конец общего сегмента команд
data		segment			;Начало сегмента данных
message	db '<> $' 
data		ends				;Конец сегмента данных
stk		segment	stack 'stack'
dw 128 dup (0)
stk		ends
end main
