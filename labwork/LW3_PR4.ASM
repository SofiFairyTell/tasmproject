text    segment 'code'
        assume CS:text, DS:data
begin: 	mov DS, AX      
;��⠭���� ����᪨� ०�� 103h SVGA
	mov AH,4Fh	;(1)�㭪�� �맮�� Video BIOS Extention
	mov AL,02h	;(2)����㭪�� ��⠭���� ����᪮�� ०���
	mov BX,103h	;(3)����᪨� ०�� SVGA
	int 10h		;(4)���뢠��� BIOS
	cmp AH,0	;(5)�� �訡��
	jne errmes1	;(6)���室 �� ᮮ�饭��
;��⠭���� � ॣ���� 150 ⠡���� 梥⮢ ������ 梥� ���ᨬ��쭮� �મ��
	mov AH,10h	;(13)�㭪�� �ࠢ����� ॣ���ࠬ� �������
	mov AL,10h	;(14)����㭪�� ��⠭���� ॣ���� 梥⮢
	mov BX,150	;(15)����� ॣ���� ⠡���� 梥⮢(0-255)
	mov DH,0	;(16)��⥭ᨢ����� ��᭮�� 梥� (6 ���)
	mov CH,127	;(17)��⥭ᨢ����� �������� 梥� (6 ���)
	mov CL,0	;(18)��⥭ᨢ����� ᨭ��� 梥� (6 ���)
	int 10h		;(19)���뢠��� BIOS
;����㥬 ����� ����� � 横�� �� �
	mov SI,0	;(20)��砫쭠� �-���न���
	mov CX,800	;(21)��᫮ �祪 �� ��ਧ��⠫�
line:	push CX		;(22)���࠭�� ��� � �⥪�
	mov AH,0Ch	;(23)�㭪�� �뢮�� ���ᥫ�
	mov AL,150	;(24)���� ������
	mov BH,0	;(25)�������࠭��
	mov CX,SI	;(26)�-���न��� (��६�����)
	mov DX,300	;(27)Y-���न��� (����⠭�)
	int 10h		;(28)�맮� BIOS
	inc SI		;(29)���६��� �-���न����
	pop CX		;(30)����⠭������� ���稪� 蠣��
	loop line		;(31)���� �� CX 蠣��
;��⠭���� �ணࠬ�� ��� ������� १���⮢ �� ࠡ���
	mov AH,08h	;(32)�㭪�� ����� � ���������� ��� ��
	int 21h		;(33)�맮� DOS
;��४��稬 ����������� ����� � ⥪�⮢� ०��
	mov AX,3	;(34)��⠭���� ⥪�⮢��� ०���
	int 10h		;(35)�맮� BIOS
	jmp output	;(36)
errmes1:
	mov AH,09h	;(37)�㭪�� �뢮�� ᮮ�饭��
	mov DX,offset message	;(38)���饭�� ᮮ�饭��
	int 21h		;(39)�맮� DOS
output:
	mov AH,09h
	mov DX, offset msg
	int 21h
exit:
	mov AX,4C00h
	int 21h
text    ends 
data segment
 msg     db 'The end$'                
 message db 'Error$'                       
data ends                           ; 
stk     segment stack 'stack'             
        dw  128 dup (0)             ; 
stk     ends                        ; 
        end begin                   ; 
