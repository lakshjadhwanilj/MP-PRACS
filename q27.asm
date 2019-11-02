Data Segment
	msg1 db 10,13, "Enter Size of Array: $"
	len db ?
	msg2 db 10,13, "Enter Element: $"
	msg3 db 10,13, "Enter Element to be Searched: $"
	val db ?
	msg4 db 10,13, "Number of occurences: $"
	count db ?
Data Ends
Code Segment
	Assume CS: Code, DS: Data

	start:
		
		mov ax, data
		mov ds, ax

		mov dx, offset msg1
		mov ah, 09h
		int 21h

		mov ah, 01h
		int 21h
		Call input
		mov len, al

		mov si, 1000h
		mov cl, len
		mov ch, 00h

		labelElement:

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
			
			mov [si], bl
			inc si

			loop labelElement

		mov dx, offset msg3
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

		mov val, bl

		mov si, 1000h
		mov cl, len
		mov ch, 00h
		mov al, 00h

		labelFind:

			mov bl, [si]
			cmp bl, val
			jnz labelNotFound

			inc al

			labelNotFound:
				inc si

			loop labelFind

		mov bl, al
		mov count, bl

		mov dx, offset msg4
		mov ah, 09h
		int 21h

		mov bl, count
		Call output

		mov ah, 4ch
		int 21h

		input proc
			cmp al, 41h
			jc labelIn
			sub al, 07h

			labelIn:
				sub al, 30h

			ret
			endp

		output proc
			cmp bl, 0ah
			jc labelOut
			add bl, 07h

			labelOut:
				add bl, 30h

			mov dl, bl
			mov ah, 02h
			int 21h

			ret
			endp

Code Ends
	end start