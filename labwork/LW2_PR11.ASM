text    segment  ;��砫� ᥣ���� ������
        assume CS:text,DS:data 
begin:  mov AX,data       ;���樠������ ᥣ���⭮��
        mov DS,AX         ;ॣ���� DS
        
        
inpt:   mov AH, 07h ;���� ᨬ����� � �宬
        int 21h
        cmp AL,0
        je ascii; �᫨ ��� ��ࢮ�� ᨬ���� ࠢ�� 0, � ��३� �� ����
        cmp AL,'9'
        ja inpt ; �᫨ ����� � �� ��ࠡ��뢠�� � ������� � inpt
        cmp AL, '1' ; �᫨ ����� � ������� � inpt
        jb inpt
        mov CX,0
        mov CL,AL
        mov DX, offset next
        mov AH, 09h
        int 21h
        mov DX, offset star
fill:   cmp CL,'0'
        jbe inpt
        add CL,-1
        mov AH, 09h
        int 21h
        jmp fill

ascii:  mov AH, 08h ;���� ᨬ���� ��� �� ������ ����
        int 21h
        cmp AL,44h
        je exit
        jmp inpt

exit:   mov AX,4C00h      
        int 21h           
text    ends            
data    segment  
next    db 10,13, '$'
star    db '*$'       
data    ends            
stk     segment stack 'stack'   
        dw 128 dup (0)      
stk     ends                
end begin           ;����� ⥪�� �ணࠬ��
