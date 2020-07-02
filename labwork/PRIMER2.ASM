assume CS: code, DS:data

code segment
begin:
	mov AX, data
	mov DS, AX

	mov AH, 09h
	mov DX, offset message
	int 21h

	mov AH, 08h
	int 21h

	mov AX, 4C00h
	int 21h
code ends

data segment
message db 'OWL NEVER SLEEP!$'
data ends

steks segment stack
  dw 128 dup(0)
steks ends

end begin