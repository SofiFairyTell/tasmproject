text    segment 'code'
        assume CS:text
begin: 	mov DS, AX      ;��⠭���� ����᪨� ०�� EGA
	mov AH,00h
	;mov �H,00h      ;(1)�㭪�� ������� ०���
	mov AL,10h      ;(2)����᪨� ०�� EGA
	int 10h         ;(3)�맮� BIOS 
;����㥬 ����� ����� � 横�� �� �
	mov SI,150      ;(4)��砫쭠� �-���न���
	mov CX,300      ;(5)��᫮ �祪 �� ��ਧ��⠫�
line:   push CX ;(6)���࠭�� ��� � �⥪�
	mov AH,0Ch      ;(7)�㭪�� �뢮�� ���ᥫ�
	mov AL,4        ;(8)���� ����
	mov BH,0        ;(9)�������࠭��
	mov CX,SI       ;(10)�-���न��� (��६�����)
	mov DX,180      ;(11)Y-���न��� (����⠭�)
	int 10h ;(12)�맮� BIOS
	inc SI          ;(13)���६��� �-���न����
	pop CX  ;(14)����⠭���� ���稪 蠣��
	loop line       ;(15)���� �� CX 蠣��
;��⠭���� �ணࠬ�� ��� ������� १���� �� ࠡ���
	mov AH,08h      ;(16)�㭪�� ����� � ���������� ��� ��
	int 21h         ;(17)�맮� DOS
	;��४��稬 ����������� ����� � ⥪�⮢� ०��
	mov AH,00h      ;(18)�㭪�� ������� ०���
	mov AL,03h      ;(19)����⮢� ०��
	int 10h ;(20)�맮� BIOS
	mov AX, 4C00h
	int 21h
text    ends                            ; 
stk     Segment stack 'stack'             
        dw  128 dup (0)             ; 
stk     ends                        ; 
        end begin                   ; 