Text    segment         ;(1)��砫� ᥣ���� ������
        assume CS:text,DS:data  ;(2)
Begin:  mov AX,data     ;(3)���樠������ ᥣ���⭮��
        mov DS,AX       ;(4)ॣ���� DS
;�뢥��� �� ��࠭ ����� �ணࠬ�� prompt
       mov DX, offset prompt
       mov AH,9
       int 21h
        mov BX,offset txt               ;���樠������ ��������
        mov SI,0                        ;� �����᭮�� ॣ���஢

inpt:   mov AH,01h                      ;�㭪�� ����� ᨬ���� � �宬
        int 21h                 ;�맮� DOS
        cmp AL,0                ;����७�� ASCII - ��� ?
        je  ex_ascii            ;��, �� ������
                mov [BX][SI],AL         ;���, ᨬ��� � ����
                inc SI                  ;���६��� ������
                jmp inpt                ;� ��᪮��筮 ��������
ex_ascii:       mov AH,08h              ;���� ᨬ���� ��� ��
                int 21h                 ;�맮� DOS
                cmp AL,44h              ;<F10> ?
                je  exit                ;��, �� ��室
                jmp inpt                ;���, �� �த������� �����
exit:           mov AX, 4C00h           ;�����襭�� �ணࠬ��
                int 21h
text           ends
data        segment     ;(20)��砫� ᥣ���� ������
;���� ������ �ணࠬ��
prompt  db '>>$'
txt             db 80 dup (?)
data        ends        ;(22)����� ᥣ���� ������
stk     segment stack 'stack' ;(23)��砫� ᥣ���� �⥪�
        dw 128 dup (0)      ;(24)�⥪
stk     ends                ;(25)����� ᥣ���� �⥪�
        end begin           ;(26)����� ⥪�� �ணࠬ��
