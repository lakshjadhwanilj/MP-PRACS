; I did a simple trick for concatenation of 2 strings
; I stored the first string from si -> 1000h
; And then stored the next string from the last position of si, left by first string 😜
; Also note that q13 and q21 are same except for the menu driven part
Data Segment
	msg db 10,13, "Enter String: $"
	msg1 db 10,13, "MENU $"
	msg2 db 10,13, "1. Concatenate Strings $"
	msg3 db 10,13, "2. Print String $"
	msg4 db 10,13, "3. Exit $"
	msg5 db 10,13, "Enter Your Choice: $"
	choice db ?
	msg6 db 10,13, "Concatenated String is: $"
	len1 db ?
	len2 db ?
Data Ends
Code Segment
	
	Assume CS: Code, DS: Data

	start:

		mov ax, data
		mov ds, ax

		Menu:

			mov dx, offset msg1
			mov ah, 09h
			int 21h

			mov dx, offset msg2
			mov ah, 09h
			int 21h

			mov dx, offset msg3
			mov ah, 09h
			int 21h

			mov dx, offset msg4
			mov ah, 09h
			int 21h

			mov dx, offset msg5
			mov ah, 09h
			int 21h

			mov ah, 01h
			int 21h
			Call input
			mov choice, al

			cmp choice, 03h
			jnz ChoiceMade
			jmp exit

			ChoiceMade:
				cmp choice, 01h
				jnz DisplayStr
				mov dx, offset msg 					; entering 1st string
				mov ah, 09h
				int 21h

				mov si, 1000h
				mov di, 1000h
				mov cx, 0000h

				back:
					mov ah, 01h
					int 21h
					cmp al, 0dh
					je done
					inc cx
					mov [si], al
					inc si
					jmp back

					done:
						mov len1, cl

				mov dx, offset msg 					; entering 2nd string
				mov ah, 09h
				int 21h

				mov cx, 0000h

				back2:
					mov ah, 01h
					int 21h
					cmp al, 0dh
					je done2
					inc cx
					mov [si], al
					inc si
					jmp back2

					done2:
						mov len2, cl

				jmp Menu

				DisplayStr:
					cmp choice, 02h
					jnz exit

					mov dx, offset msg6 					
					mov ah, 09h
					int 21h

					mov bl, len1
					mov cl, len2
					add bl, cl

					mov ch, 00h
					mov cl, bl
					mov si, 1000h

					Displ:
						mov dl, [si]
						mov ah, 02h
						int 21h
						inc si
						loop Displ

					jmp Menu

			exit:
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
Code Ends
	end start
