#include <stdio.h>
#include <conio.h>

void main()
{
	
	int num1, num2, choice, res, quo;
	clrscr();
	do
	{
		printf(" **MAIN MENU**\n");
		printf("1. Addition \n2. Subtraction \n3. Multiplication \n4. Division \n5.Exit\n");
		printf("Enter Your Choice: ");
		scanf("%d",&choice);
		printf("Enter First Number: ");
		scanf("%d",&num1);
		printf("Enter Second Number: ");
		scanf("%d",&num2);
		switch(choice)
		{
			case 1:
					asm mov ax, num1
					asm mov bx, num2
					asm ADD ax, bx
					asm mov res, ax
					printf("Addition of the Numbers is: %d", res); 
					break;

			case 2:
					asm mov ax, num1
					asm mov bx, num2
					asm SUB ax, bx
					asm mov res, ax
					printf("Subtraction of the Numbers is: %d", res); 
					break;

			case 3:
					asm mov ax, num1
					asm mov bx, num2
					asm MUL bx
					asm mov res, ax
					printf("Product of the Numbers is: %d", res); 
					break;

			case 4:
					asm mov ax, num1
					asm mov bx, num2
					asm DIV bx
					asm mov quo, ax
					printf("Addition of the Numbers is: %d", quo); 
					break;

			case 5:
					break;

			default:
					printf("Invalid Choice\n");
		}
	} while(choice!=5);

}