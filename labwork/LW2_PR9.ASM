Text    segment  ;��砫� ᥣ���� ������
        assume CS:text,DS:data 
begin:  mov AX,data       ;���樠������ ᥣ���⭮��
        mov DS,AX         ;ॣ���� DS
        mov CL,10         ;��᫮ 蠣�� � 横��
                  
again:  cmp s,CL       ;�ࠢ���� ���祭��
        ja exit 
        add s,2
        mov DX, offset symbol
        mov AH,9
        int 21h
        jmp again
exit:   mov AX,4C00h      
        int 21h           
text    ends            
data    segment         
symbol  db ('00$')        ;������塞� ���ᨢ
s       db 5, '$'
data    ends            
stk     segment stack 'stack'   
        dw 128 dup (0)      
stk     ends                
end begin           ;����� ⥪�� �ணࠬ��
