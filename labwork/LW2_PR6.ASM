 Text    segment                         
         assume CS:text,DS:data          
 Begin:          mov AX,data                     
                 mov DS,AX
 again:          mov AH,01h         ;(1)Функция ввода с клавиатуры
                 int 21h            ;(2)Вызов DOS
                 cmp AL,44h                 
                 je  exit 
                 cmp AL,'4'         ;(3)Введен символ > '4'
                 ja  again          ;(4)Да, повторим ввод
                 cmp AL,'3'         ;(5)Введен символ < '3'
                 jb  again          ;(6)Да, повторим ввод
                 mov color,AL       ;(7)Введен допустимый код, 
 ;перешлем его в строку
 
 symb2:  mov AH,01h                      ;(8)Функция ввода с клавиатуры
                 int 21h                 ;(9)Вызов DOS
                 cmp AL,'7'                      ;(10)Введен символ > '7'
                 ja  symb2                       ;(11)Да, повторим ввод
                 cmp AL,'0'                      ;(12)Введен символ < '0'
                 jb  symb2                       ;(13)Да, повторим ввод
                 mov color+1,AL          ;(14)Введен допустимый код, 
 ;перешлем его в строку
                 mov AH,9                        ;(15)Функция DOS вывода на экран
                 mov DX,offset message   ;(16)Адрес выводимого сообщения
                 int 21h                 ;(17)Вызов DOS
                 jmp again                       ;(18)Бесконечный цикл повторения
 exit:           mov AH,09h; 
                 mov DX,offset conec     ;(17)Адрес выводимой строки
                 int 21h                 ;(18)
                 mov AH,09h                      ;(16)Функция вывода
                 mov DX,offset reset     ;(17)Адрес выводимой строки
                 int 21h                 ;(18)
                 mov AX,4C00h     ;завершаем работу программы
                 int 21h
 Text ends
 ;Поля данных
 data segment
 conec   db 27, '[37;40m',10,13,'The end$'
 clear   db 27,'[2j'                     
 message db 27,'['                       
 color   db '00'                
         db 'm',27,10,13
         db 27,'[12;4m',201,9 dup (205),187,10,13
         db 27,'[13;4m',186,'Внимание!',186,10,13
         db 27,'[14;4m',200,9 dup (205),188,10,13     
         db 27,'[Om',27,'[25;1H$'
 reset   db 27,'[Om$';(23)Esc-последовательность отмены цвета
 data ends
 stk     segment stack 'stack'           
         dw 128 dup (0)      
 stk     ends                
         end begin
