 Text    segment                         
         assume CS:text,DS:data          
 Begin:          mov AX,data                     
                 mov DS,AX
 again:          mov AH,01h         ;(1)�㭪�� ����� � ����������
                 int 21h            ;(2)�맮� DOS
                 cmp AL,44h                 
                 je  exit 
                 cmp AL,'4'         ;(3)������ ᨬ��� > '4'
                 ja  again          ;(4)��, ����ਬ ����
                 cmp AL,'3'         ;(5)������ ᨬ��� < '3'
                 jb  again          ;(6)��, ����ਬ ����
                 mov color,AL       ;(7)������ �����⨬� ���, 
 ;���諥� ��� � ��ப�
 
 symb2:  mov AH,01h                      ;(8)�㭪�� ����� � ����������
                 int 21h                 ;(9)�맮� DOS
                 cmp AL,'7'                      ;(10)������ ᨬ��� > '7'
                 ja  symb2                       ;(11)��, ����ਬ ����
                 cmp AL,'0'                      ;(12)������ ᨬ��� < '0'
                 jb  symb2                       ;(13)��, ����ਬ ����
                 mov color+1,AL          ;(14)������ �����⨬� ���, 
 ;���諥� ��� � ��ப�
                 mov AH,9                        ;(15)�㭪�� DOS �뢮�� �� ��࠭
                 mov DX,offset message   ;(16)���� �뢮������ ᮮ�饭��
                 int 21h                 ;(17)�맮� DOS
                 jmp again                       ;(18)��᪮���� 横� ����७��
 exit:           mov AH,09h; 
                 mov DX,offset conec     ;(17)���� �뢮����� ��ப�
                 int 21h                 ;(18)
                 mov AH,09h                      ;(16)�㭪�� �뢮��
                 mov DX,offset reset     ;(17)���� �뢮����� ��ப�
                 int 21h                 ;(18)
                 mov AX,4C00h     ;�����蠥� ࠡ��� �ணࠬ��
                 int 21h
 Text ends
 ;���� ������
 data segment
 conec   db 27, '[37;40m',10,13,'The end$'
 clear   db 27,'[2j'                     
 message db 27,'['                       
 color   db '00'                
         db 'm',27,10,13
         db 27,'[12;4m',201,9 dup (205),187,10,13
         db 27,'[13;4m',186,'��������!',186,10,13
         db 27,'[14;4m',200,9 dup (205),188,10,13     
         db 27,'[Om',27,'[25;1H$'
 reset   db 27,'[Om$';(23)Esc-��᫥����⥫쭮��� �⬥�� 梥�
 data ends
 stk     segment stack 'stack'           
         dw 128 dup (0)      
 stk     ends                
         end begin
