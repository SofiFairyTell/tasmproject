text segment 'code'	; (1) ��砫� ᥣ���� ������
	 assume CS: text, DS: data	; (2)  CS - �� ᥣ���� ������,
								;  DS - �� ᥣ���� ������
begin:	mov	AX, data	; (3) ���� ᥣ���� ������ ����㧨�
	mov	DS, AX	; (4) ᭠砫� � ��, ��⥬ � DS
	push	DS	; (5) ����㧨� � �⥪ ᮤ�ন��� DS
	pop	ES	; (6) ���㧨� ��� �� �⥪� � ES
	mov	AH, 9	; (7) �㭪�� DOS �뢮�� �� ��࠭
	mov	DX,offset message	; (8) ���� �뢮������ ᮮ�饭��
	int	21h 	; (9) �맮� DOS
	mov	AX,4C00h	; (10) �㭪�� DOS �����襭�� �ணࠬ��
					; � 㪠������ ���� �����襭�� 00h
	int	21h	;  (11) �맮� DOS
text	ends		;  (12) ����� ᥣ���� ������
data	segment	;  (13) ��砫� ᥣ���� ������
message	Db 'KNOLEDGE IS POWER ���� 2$'; (14) �뢮���� ⥪��
data	ends		;  (15) ����� ᥣ���� ������
	end	begin 	;  (16) ����� ⥪�� �ணࠬ�� � 㪠������  �窨 �室�
				;   �窨 �室�

