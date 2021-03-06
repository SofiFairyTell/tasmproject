Text	segment 'code'		;(1)Начало сегмента команд
assume CS:text,DS:data	;(2)
draw 	proc					;(3)Объявление процедуры - подпрограммы
	mov AH,0Ch			;(4)Функция вывода пиксела
	mov AL,color		;(5)Цвет
	mov BH,vpage		;(6)Видеостраница
	mov CX,x			;(7)X - координата
	mov DX,y			;(8)Y - координата
	int 10h			;(9)Вызов BIOS
	ret				;(10)Команда выхода из подпрограммы
draw endp					;(11)Конец процедуры
; Главная процедура, с которой начинается выполнение программы
main 	proc					;(12)Объявление главной процедуры
	mov AX,data			;(13)Инициализация сегментного
	mov DS,AX			;(14)регистра DS
; Установим графический режим EGA
	mov AH,00h			;(15)Функция задания режима
	mov AL,10h			;(16)Графический режим EGA
	int 10h			;(17)Вызов BIOS
; Нарисуем горизонтальную линию в цикле по X
	mov CX,300			;(18)Число точек по горизонтали
line:	push CX			;(19)Сохраним его в стеке
	call draw			;(20)Вызов подпрограммы
	inc x				;(21)Инкремент X - координаты
	pop CX			;(22)Восстановим счетчик шагов
loop line			;(23)Цикл из CX шагов
; Нарисуем наклонную линию
	mov x,10			;(7)Восстановим начальное значение Х 
	mov CX,250			;(8)Число точек 
line1:	push CX			;(9)Сохраним его в стеке 
	push x			;(10)Отправим значение X 
	pop y				;(11)в ячейку Y
	call draw			;(12)Вызов подпрограммы
	inc x				;(13)Инкремент Х-координаты
	pop CX			;(14)Восстановим счетчик шагов
loop line1			;(15)Цикл из СХ шагов
	mov CX,300			;(16)Число точек по горизонтали
	mov x,10			;(17)Восстановим исходное значение Х 
	mov y,10			;(18)Восстановим исходное значение Y 
	mov CX,300			;(19)Число точек
line2:	push CX			;(20)Сохраним его в стеке
	call draw			;(21)Вызов подпрограммы
	inc y				;(22)Инкремент Y-коордииаты
	pop CX			;(23)Восстановим счетчик шагов
loop line2			;(24)Цикл из СХ шагов
;Остановим программу для наблюдения результата ее работы
	mov AH,08h			;(24)Функция ввода с клавиатуры
	int 21h			;(25)Вызов DOS
; Переключим видеоадаптер назад в текстовый режим
	;mov AH,00h			;(26)Функция задания режима
	mov AX,3			;(27)Текстовый режим
	int 10h			;(28)Вызов BIOS
	mov AX,4C00h		;(29)Завершение программы
	int 21h			;(30)
main endp					;(31)Конец главной процедуры
text ends					;(32)Конец сегмента команд
data segment				;(33)Начало сегмента данных
x dw 10			;(34)Текущая X - координата
y dw 10			;(35)Текущая Y - координата
color	db 14			;(36)Цвет точек
vpage	db 0			;(37)Видеостраница
data ends					;(38)Конец сегмента данных
stack	segment stack			;(39)Начало сегмента стека
	dw 128 dup (0)		;(40)Стек
stack	ends					;(41)Конец сегмента стека
	end	main			;(42) Конец текста программы

