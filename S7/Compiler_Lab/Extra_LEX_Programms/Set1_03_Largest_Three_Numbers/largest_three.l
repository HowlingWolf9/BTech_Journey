%{
/*
SET 1 - PROGRAM 03: LEX PROGRAM TO FIND LARGEST AMONG THREE NUMBERS

ALGORITHM:
1. Maintain an array `double numbers[3]` and an integer `count = 0`.
2. Define Lex regular expressions:
   - Match signed/unsigned integers and floating point numbers using `[-+]?[0-9]+(\.[0-9]+)?`.
   - Convert the matched string using `atof(yytext)` and store into `numbers[count++]`.
   - If `count` reaches 3, return 0 to finish lexical scanning.
   - Ignore whitespace, delimiters, and other characters.
3. In `main()`:
   - Prompt the user to enter three numbers separated by spaces or newlines.
   - Invoke `yylex()`.
   - If 3 numbers are successfully collected, compute `max = numbers[0]`, compare with `numbers[1]` and `numbers[2]`.
   - Print the largest number.
*/

#include <stdio.h>
#include <stdlib.h>

double numbers[3];
int count = 0;

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
[-+]?[0-9]+(\.[0-9]+)?  {
                            numbers[count++] = atof(yytext);
                            if (count == 3) {
                                return 0;
                            }
                        }
[ \t\n]+                ;
.                       ;
%%

int main(void) {
    printf("Enter three numbers: ");
    yylex();

    if (count == 3) {
        double max = numbers[0];
        if (numbers[1] > max) max = numbers[1];
        if (numbers[2] > max) max = numbers[2];

        printf("The three numbers are : %g, %g, %g\n", numbers[0], numbers[1], numbers[2]);
        printf("Largest number        : %g\n", max);
    } else {
        printf("Error: Expected 3 numbers, but received %d.\n", count);
    }

    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex largest_three.l
$ gcc lex.yy.c -o largest_three
$ ./largest_three
Enter three numbers: 45 120 78
The three numbers are : 45, 120, 78
Largest number        : 120

$ ./largest_three
Enter three numbers: -15.5 0 9.25
The three numbers are : -15.5, 0, 9.25
Largest number        : 9.25
*/
