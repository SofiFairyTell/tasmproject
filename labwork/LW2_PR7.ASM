Text    segment  ;��砫� ᥣ���� ������
        assume CS:text,DS:data 
Begin:  mov AX,data       ;���樠������ ᥣ���⭮��
        mov DS,AX         ;ॣ���� DS
        mov CX,10         ;��᫮ 蠣�� � 横��
        mov AH,9          ;横�, � ����� �室�� 4 �������
        mov DX, offset symbols 
fill:   int 21h
        loop fill
        mov AX,4C00h      
        int 21h           
text    ends            
data    segment         
symbols db ('@$')        
data    ends                ;(22)����� ᥣ���� ������
stk     segment stack 'stack'   ;(23)��砫� ᥣ���� �⥪�
        dw 128 dup (0)      ;(24)�⥪
stk     ends                ;(25)����� ᥣ���� �⥪�
end begin           ;(26)����� ⥪�� �ணࠬ��
