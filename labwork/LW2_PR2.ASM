Text    segment         ;(1)��砫� ᥣ���� ������
        assume CS:text,DS:data  ;(2)
Begin:  mov AX,data     ;(3)���樠������ ᥣ���⭮��
        mov DS,AX       ;(4)ॣ���� DS
;�����⮢�� �� ����室���� ��� �࣠����樨 横��
        mov CX,10       ;(5)��᫮ 蠣�� � 横��
cycle:  push CX         ;(2)���࠭�� ��� ���稪 � �⥪�
;�뢥��� �� ��࠭ ����஫��� �⮪� �� ��� ᨬ�����
        mov AH,09h                      ;(3)
        mov DX,offset string    ;(4)
        int 21h                 ;(5)
;�࣠���㥬 �ணࠬ���� ����প�
        mov CX,100      ;(6)���稪 ���譥�� 横��
outer:  push CX         ;(7)���࠭�� ��� � �⥪�
        mov CX,65535    ;(8)���稪 ����७���� 横��
inner:  loop inner      ;(9)����ਬ ������� loop 65535 ࠧ
        pop CX          ;(10)����⠭���� ���譨� ���稪
        loop outer      ;(11)����ਬ �� �� 100 ࠧ
        pop CX          ;(12)����⠭���� ���稪 ����-横��
        loop cycle      ;(13)����ਬ ����-横� CX=10 ࠧ
;�����訬 �ணࠬ��
        mov AX,4C00h    ;(17)
        int 21h         ;(18)
text        ends        ;(19)����� ᥣ���� ������
data        segment     ;(20)��砫� ᥣ���� ������
;���� ������ �ணࠬ��
string  db '<>$'        ;(21)

data        ends        ;(22)����� ᥣ���� ������
stk     segment stack 'stack' ;(23)��砫� ᥣ���� �⥪�
        dw 128 dup (0)      ;(24)�⥪
stk     ends                ;(25)����� ᥣ���� �⥪�
        end begin           ;(26)����� ⥪�� �ணࠬ��
