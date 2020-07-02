;Вызываемый модуль (файл lw3_pr7a.ASM) 
text 	segment public 'code'	;Подпрограмма stop должна войти
 	;в сегмент text
	assume CS:text		;Регистр DS здесь не используется
public stop			;Процедура общего пользования 
stop	proc
	mov AH,08h
	int 21h

	ret				;Возврат в вызывающую программу 
stop	endp
text	ends				;Конец сегмента команд
end				;Оператор end без точки входа
