Text    segment         ;(1)Начало сегмента команд
        assume CS:text,DS:data  ;(2)
Begin:  mov AX,data     ;(3)Инициализация сегментного
        mov DS,AX       ;(4)регистра DS
contrl: mov AH,09h                      ;Будем в цикле
                mov DX,offset string    ;выводить на экран
                int 21h                 ;строку string
                mov CX,0                        ;Программная
qqq:            loop qqq                        ;задержка
                mov AH,06h                      ;Функция прямого ввода
                mov DL,0FFh                     ;Режим ввода
                int 21h                 ;Вызов DOS
                jnz symb                        ;Если символ есть, переход
                jmp contrl                      ;Символа нет, продолжить цикл
symb:           cmp AL,0                        ;Расширенный код ASCII ?
                jne contrl                      ;Нет, продолжить цикл
                mov AH,06h                      ;Да, надо ввести второй байт
                mov DL,0FFh                     ;Режим ввода
                int 21h                 ;Вызов DOS
                cmp AL,10h                      ;Нажато <Alt>/<Q> ?
                je  exit                        ;Да, на выход
                jmp contrl                      ;Нет, продолжить цикл
exit:           mov AX, 4C00h           ;Завершение программы
                int 21h
text           ends
data        segment     ;(20)Начало сегмента данных
;Поля данных программы
string  db 'Выполняется цикл$'
data        ends        ;(22)Конец сегмента данных
stk     segment stack 'stack' ;(23)Начало сегмента стека
        dw 128 dup (0)      ;(24)Стек
stk     ends                ;(25)Конец сегмента стека
        end begin           ;(26)Конец текста программы
