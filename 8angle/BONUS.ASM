text	segment public 'code'
	assume CS:text, DS:data
public draw 	;объявление процедуры для вызова в других файлах

;процедуры рисования линий фигуры
horizontal	proc
h:	
	push	CX 	;загрузить в стек
	mov	AH,0Ch	
	mov	BH,0	;установка видеостраницы
	mov	CX,SI
	int	10h 	;вывод точки
	inc	SI 	;сдвиг по координатt X
	pop	CX 	;извлечь из стека
	loop	h
ret
horizontal	endp

vertical	proc
v:	
	push	CX
	mov	AH,0Ch	
	mov	BH,0	;установка видеостраницы	
	mov	CX,SI
	int	10h 	;вывод точки
	inc	DX 	;сдвиг по координатt Y
	pop	CX
	loop	v
ret
vertical	endp 
 
diagonal1	proc
d1:	
	push	CX
	mov	AH,0Ch
	mov	BH,0	;установка видеостраницы	
	mov	CX,SI
	int	10h 	;вывод точки
	inc	SI 	;сдвиг по координатt X
	inc 	DX 	;сдвиг по координате Y
	pop	CX
	loop	d1
ret
diagonal1	endp

diagonal2	proc 
d2:	
	push	CX 	;загрузить в стек 
	mov	AH,0Ch
	mov	BH,0	;установка видеостраницы	
	mov	CX,SI 	
	int	10h	;вывод точки
	dec	SI 	;сдвиг по координатt X
	inc DX 		;сдвиг по координате Y
	pop	CX 	; восстановить значение
	loop	d2
ret
diagonal2	endp 

draw proc
	mov AH,00h
	mov AL,10h
	int 10h
	call draw2
;рисуем диагональные линии с наклоном вправо	
	add color,1
	mov AL,color
	mov SI,x	;установка начальной координаты
	mov DX,y	;установка начальной координаты
	add SI,50 	;сдвиг по X
	mov CX,25 	;установка длины линии
	call diagonal2 ;для верхней
	mov SI,x 	;установка начальной координаты
	mov DX,y 	;установка начальной координаты
	add SI,125	;сдвиг по X
	add DX,75	;сдвиг по Y
	mov CX,25
	call diagonal2 ;для нижней
	sub color,1 ;возвращение в исходное состояние цвет
; рисуем горизонтальную верхнюю и нижнюю линиии
        add color,2
	mov AL,color
	mov SI,x 	;установка начальной координаты
	mov DX,y 	;установка начальной координаты
	add SI,50 	;сдвиг по X
	mov CX,50
	call horizontal ;для верхней
	mov SI,x 	;сдвиг по X
	mov DX,y 	;сдвиг по Y
	add SI,50 	;сдвиг по X
	add DX,100 	;сдвиг по Y
	mov CX,50	;установка длины линии
	call horizontal ;для нижней
	sub color,2
;рисуем вертикальные линии 
	add color,3
	mov AL,color
	mov SI,x
	mov DX,y
	add SI,25
	add DX,25
	mov CX,50
	call vertical ;для левой
	mov SI,x
	mov DX,y
	add DX,25
	add SI,125
	mov CX,50
	call vertical ;для правой
	sub color,3
;рисуем диагональные линии с наклоном влево
        add color,6
	mov AL,color
	mov SI,x
	mov DX,y
	add SI,25
	add DX,75
	mov CX,25
	call diagonal1 ;для верхней
	mov SI,x
	mov DX,y
	add SI,100
	mov CX,25
	call diagonal1 ;для нижней
	sub color,6
ret				
draw endp

; процедура рисования внутреннего 4-угольниика
draw2 proc
	mov AH,00h
	mov AL,10h
	int 10h
;рисуем диагональные линии с наклоном вправо	
	add color,1
	mov AL,color
	mov SI,x	;установка начальной координаты
	mov DX,y	;установка начальной координаты
	add SI,75	;сдвиг по X
	mov CX,25	;установка длины линии
	call diagonal2 ;для верхней
	mov SI,x 	;установка начальной координаты
	mov DX,y 	;установка начальной координаты
	add SI,100	;сдвиг по X
	add DX,75	;сдвиг по Y
	mov CX,25
	call diagonal2 ;для нижней
	sub color,1 ;возвращение в исходное состояние цвет
;рисуем вертикальные линии 
	add color,3
	mov AL,color
	mov SI,x
	mov DX,y
	add SI,50
	add DX,25
	mov CX,50
	call vertical ;для левой
	mov SI,x
	mov DX,y
	add DX,25
	add SI,100
	mov CX,50
	call vertical ;для правой
	sub color,3
;рисуем диагональные линии с наклоном влево
        add color,6
	mov AL,color
	mov SI,x
	mov DX,y
	add SI,50
	add DX,75
	mov CX,25
	call diagonal1 ;для верхней
	mov SI,x
	mov DX,y
	add SI,75
	mov CX,25
	call diagonal1 ;для нижней
	sub color,6
ret				
draw2 endp

text ends
data        segment 
x dw 0 	;начальные координаты X и Y
y dw 0             
color db 0 	;установка переменной цвета
data ends  
end
