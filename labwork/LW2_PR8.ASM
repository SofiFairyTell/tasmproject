Text    segment  ;��砫� ᥣ���� ������
        assume CS:text,DS:data 
begin:  mov AX,data       ;���樠������ ᥣ���⭮��
        mov DS,AX         ;ॣ���� DS
        mov CX,10         ;��᫮ 蠣�� � 横��
        mov AX,5          
again:  cmp CX,AX       ;�ࠢ���� ���祭��
        jb exit
        add symbol,1
        add CX,-1       ;㬥����� ���祭�� ���稪� �� 1
        jmp again
exit:   mov DX, offset symbol
        mov AH,9
        int 21h
        mov AX,4C00h      
        int 21h           
text    ends            
data    segment         
symbol db ('0$')        ;������塞� ���ᨢ
data    ends            
stk     segment stack 'stack'   
        dw 128 dup (0)      
stk     ends                
end begin           ;����� ⥪�� �ணࠬ��
