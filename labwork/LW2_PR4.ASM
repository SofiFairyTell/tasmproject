Text    segment         ;(1)��砫� ᥣ���� ������
        assume CS:text,DS:data  ;(2)
Begin:  mov AX,data     ;(3)���樠������ ᥣ���⭮��
        mov DS,AX       ;(4)ॣ���� DS
contrl: mov AH,09h                      ;�㤥� � 横��
                mov DX,offset string    ;�뢮���� �� ��࠭
                int 21h                 ;��ப� string
                mov CX,0                        ;�ணࠬ����
qqq:            loop qqq                        ;����প�
                mov AH,06h                      ;�㭪�� ��אַ�� �����
                mov DL,0FFh                     ;����� �����
                int 21h                 ;�맮� DOS
                jnz symb                        ;�᫨ ᨬ��� ����, ���室
                jmp contrl                      ;������� ���, �த������ 横�
symb:           cmp AL,0                        ;����७�� ��� ASCII ?
                jne contrl                      ;���, �த������ 横�
                mov AH,06h                      ;��, ���� ����� ��ன ����
                mov DL,0FFh                     ;����� �����
                int 21h                 ;�맮� DOS
                cmp AL,10h                      ;����� <Alt>/<Q> ?
                je  exit                        ;��, �� ��室
                jmp contrl                      ;���, �த������ 横�
exit:           mov AX, 4C00h           ;�����襭�� �ணࠬ��
                int 21h
text           ends
data        segment     ;(20)��砫� ᥣ���� ������
;���� ������ �ணࠬ��
string  db '�믮������ 横�$'
data        ends        ;(22)����� ᥣ���� ������
stk     segment stack 'stack' ;(23)��砫� ᥣ���� �⥪�
        dw 128 dup (0)      ;(24)�⥪
stk     ends                ;(25)����� ᥣ���� �⥪�
        end begin           ;(26)����� ⥪�� �ணࠬ��
