#include<stdio.h>
#include<conio.h>
void main()
{
	int num1, num2, gcd;
	clrscr();
	printf("Enter First Number: ");
	scanf("%d",&num1);
	printf("Enter Second Number: ");
	scanf("%d",&num2);
	
	asm mov bx, num2
	asm mov cx, num1

	asm cmp bx, cx
	asm jz Equal
	asm jnc B

	C:
		asm SUB cx, bx
		asm cmp bx, cx
		asm jz Equal
		asm jc C

	B:
		asm SUB bx, cx
		asm cmp bx, cx
		asm jz Equal
		asm jnc B	
		asm jc C

	Equal:
		asm mov gcd, bx

	printf("GCD is: %d", gcd);
	getch();
}