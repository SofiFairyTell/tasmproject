text	segment 'code'
	assume CS:text,DS:data
stop    proc
        mov AH,08h      
        int 21h         
        cmp AL,44h ; f10
        je exit
        ret             
exit:   
	mov AX,4C00h        
        int 21h     
stop    endp

new_65h proc
;��楤�� ��������� �� ��࠭ 梥⭮�� ���� ��� �������᪮�
;���⪨ ��࠭� �� 室� �믮������ �ணࠬ��
	mov  	AH, 06h     ;�㭪�� ������� ����
	mov   	AL,0         ;����� ᮧ����� ����
	mov  	BH,1Bh     ;��ਡ�� ��� ᨬ����� � ����: ᢥ⫮-����� ᨬ����, ᨭ�� 䮭
	mov   	CX,0       ;���न���� ���孥�� ������ 㣫� 0,0
	mov  	DH,24       ;������ �-���न���
	mov  	DL,79       ;�ࠢ�� �-���न���
	int  	10h              ;���뢠��� BIOS
iret
new_65h   endp
main  proc

	mov   AX,data
	mov   DS,AX 
;�������� ����� ���뢠��� ���짮��⥫� ���ᮬ ��襣� ��ࠡ��稪�
begin:	mov   AH,25h     ;�㭪�� ���������� ����� ���뢠���
	mov   AL,65h     ;����� �����
	mov   DX,offset new_65h ;���饭�� �ਪ������� ��ࠡ��稪�
	push DS              ;���࠭�� DS
	push CS              ;����ந� DS �� ᥣ���� ������ (�
	pop DS                ;���஬ ��室���� ��� ��ࠡ��稪)
	int   21h               ;�맮��� DOS
	pop   DS              ;����⠭���� DS
;�㤥� � 横�� �뢮���� �� ��࠭ ��ப� � �।���⥫쭮� ���⪮� ��࠭� 
gogo:	int   65h               ;�맮� �ਪ������� ��ࠡ��稪� (���⪠
                                            ;��࠭� ��। �뢮��� ⥪��) 
;����樮���㥬 �����
	mov   AH,02h     ;�㭪�� ����樮��஢����
	mov   BH,0         ;�������࠭��
	mov   DH,line     ;��ப�
	mov   DL,coloumn ;�⮫���
	int   	10h               ;���뢠��� BIOS 
;�뢥��� �� ��࠭ ��ப� ᨬ�����
	mov  AH,0Ah      ;�㭪�� �뢮�� ᨬ���� ��� ��ਡ��
	mov  AL,sym       ;������
	mov  BH,0            ;�������࠭��
	mov  CX,60          ;�����樥�� ����७��
	int   10h                 ;���뢠��� BIOS 
;������� ᨬ��� � ������ � ��横��� �ணࠬ�� � ������������
 ;�����襭�� �� ������ ������ <Ctri>/C
	inc   sym             ;������騩 ᨬ��� �� ⠡��� ASCII
	inc  line               ;�������� ��ப� ��࠭�
	call stop
	;mov   AH,08h     ;�㭪�� ����� ��� ��, ������ <Ctri>/C
	;int   21h
jmp  gogo            ;��᪮���� 横� 
main endp                            ;���� ������
text ends
data  segment 
	line db 2                               ;��ப� 
	coloumn db 10	             ;�⮫��� 
	sym db 01h                           ;�뢮���� ᨬ���
data ends
end main 