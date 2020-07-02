Text    segment         ;(1)Начало сегмента команд
        assume CS:text,DS:data  ;(2)
Begin:  mov AX,data     ;(3)Инициализация сегментного
        mov DS,AX       ;(4)регистра DS
;Выведем на экран запрос программы prompt
       mov DX, offset prompt
       mov AH,9
       int 21h
        mov BX,offset txt               ;Инициализация базового
        mov SI,0                        ;и индексного регистров

inpt:   mov AH,01h                      ;Функция ввода символа с эхом
        int 21h                 ;Вызов DOS
        cmp AL,0                ;Расширенный ASCII - код ?
        je  ex_ascii            ;Да, на анализ
                mov [BX][SI],AL         ;Нет, символ в буфер
                inc SI                  ;Инкремент индекса
                jmp inpt                ;И бесконечно повторять
ex_ascii:       mov AH,08h              ;Ввод символа без эха
                int 21h                 ;Вызов DOS
                cmp AL,44h              ;<F10> ?
                je  exit                ;Да, на выход
                jmp inpt                ;Нет, на продолжение ввода
exit:           mov AX, 4C00h           ;Завершение программы
                int 21h
text           ends
data        segment     ;(20)Начало сегмента данных
;Поля данных программы
prompt  db '>>$'
txt             db 80 dup (?)
data        ends        ;(22)Конец сегмента данных
stk     segment stack 'stack' ;(23)Начало сегмента стека
        dw 128 dup (0)      ;(24)Стек
stk     ends                ;(25)Конец сегмента стека
        end begin           ;(26)Конец текста программы
