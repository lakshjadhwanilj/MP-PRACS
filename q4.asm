Data Segment
	msg db 10,13, " ** MAIN MENU ** $"
	msg1 db 10,13, "1. Input String $"
	msg2 db 10,13, "2. Output String $"
	msg3 db 10,13, "3. Length of String $"
	msg4 db 10,13, "4. Print Reverse String $"
	msg5 db 10,13, "5. Exit $"
	msg6 db 10,13, "Enter Your Choice: $"
	choice db ?
	msg7 db 10,13, "Enter String: $"
	msg8 db 10,13, "Entered String is: $"
	msg9 db 10,13, "Length of String is: $"
	len db ?
	msg10 db 10,13, "Reverse of String is: $"
Data Ends
Code Segment
	
	Assume CS: Code, DS: Data

	start:

		mov ax, data
		mov ds, ax

		Menu:

			mov dx, offset msg
			mov ah, 09h
			int 21h

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

			mov dx, offset msg6
			mov ah, 09h
			int 21h

			mov ah, 01h 					; taking choice
			int 21h
			Call input
			mov choice, al

			cmp choice, 05h
			jnz ChoiceMade

			jmp exit

			ChoiceMade:

				cmp choice, 01h
				jnz DisplayStr

				Accept:

					mov dx, offset msg7
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
						mov [di], al
						inc di
						inc si
						jmp back

						done:
							mov len, cl

					jmp Menu

				DisplayStr:

					cmp choice, 02h
					jnz LengthStr

					mov dx, offset msg8
					mov ah, 09h
					int 21h

					mov cl, len
					mov ch, 00h
					mov si, 1000h

					Disp:

						mov dl, [si]
						mov ah, 02h
						int 21h
						inc si
						loop Disp

					jmp Menu

				LengthStr:

					cmp choice, 03h
					jnz Reverse

					mov dx, offset msg9
					mov ah, 09h
					int 21h

					mov bl, len
					and bl, 0f0h
					ror bl, 04h
					Call output

					mov bl, len
					and bl, 0fh
					Call output

					jmp Menu

				Reverse:

					cmp choice, 04h
					jnz exit

					mov dx, offset msg10
					mov ah, 09h
					int 21h

					mov cl, len
					mov ch, 00h
					mov si, 1000h
					add si, cx
					dec si

					rev:
						mov dl, [si]
						mov ah, 02h
						int 21h
						dec si
						loop rev

					jmp Menu

			exit:
				mov ah, 4ch						; terminating program
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