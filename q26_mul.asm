Data Segment
	msg db 10,13, "Multiplication Without Instruction $"
	msg1 db 10,13, "Enter First Number: $"
	num1 db ?
	msg2 db 10,13, "Enter Second Number: $"
	num2 db ?
	msg3 db 10,13, "Product is: $"
	product dw ?
Data Ends
Code Segment

	Assume CS: Code, DS: Data

	start:

		mov ax, data
		mov ds, ax

		mov dx, offset msg
		mov ah, 09h
		int 21h

		mov dx, offset msg1
		mov ah, 09h
		int 21h

		mov ah, 01h
		int 21h
		Call input
		mov bl, al
		rol bl, 04h

		mov ah, 01h
		int 21h
		Call input
		add bl, al

		mov num1, bl

		mov dx, offset msg2
		mov ah, 09h
		int 21h

		mov ah, 01h
		int 21h
		Call input
		mov bl, al
		rol bl, 04h

		mov ah, 01h
		int 21h
		Call input
		add bl, al

		mov num2, bl

		mov ax, 0000h
		mov bx, 0000h
		mov bl, num1
		mov cl, num2
		mov ch, 00h
		

		Addition:

			add ax, bx

			loop Addition

		mov bx, ax
		mov product, bx
		mov dx, offset msg3
		mov ah, 09h
		int 21h

		mov bx, product
		and bx, 0f000h
		ror bx, 0ch
		Call output

		mov bx, product
		and bx, 0f00h
		ror bx, 08h
		Call output

		mov bx, product
		and bx, 0f0h
		ror bx, 04h
		Call output

		mov bx, product
		and bx, 0fh
		Call output		

		mov ah, 4ch
		int 21h	

		input proc
			cmp al, 41h
			jc Inp
			sub al, 07h

			Inp:
				sub al, 30h

			ret
			endp

		output proc
			cmp bl, 0ah
			jc Outp
			add bl, 07h

			Outp:
				add bl, 30h

			mov dl, bl
			mov ah, 02h
			int 21h

			ret
			endp
Code Ends
	end start