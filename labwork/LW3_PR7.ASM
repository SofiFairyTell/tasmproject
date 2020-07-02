;Вызывающий модуль (файл lw3_pr7.ASM)
text	segment public 'code'
	assume CS:text,DS:data
extrn stop:proc		;Будет вызываться внешняя процедура stop
;Главная процедура 
main	proc
	mov AX,data
	mov DS,AX
;Организуем вывод на экран строк текста 
begin:	
	mov AH,09h
	mov DX,offset message
	int 21h
	call stop			;Вызов подпрограммы
	cmp AL,44h ;F10 
	je exit
jmp begin 
exit:   int 21h;
        mov AX,4C00h     ;завершаем работу программы
        int 21h	
main 	endp
text	ends
data	segment
message	db '/ * / $'
data	ends
stk	segment stack 'stack'
	dw 128 dup (0) 
stk	ends
end main			;Оператор end с точкой входа
