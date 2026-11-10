%{
/*
SET 1 - PROGRAM 03: LEX PROGRAM TO FIND LARGEST AMONG THREE NUMBERS (EASY VERSION)

ALGORITHM:
1. Maintain an array a[3] and counter c = 0.
2. Define Lex regular expression to match numbers: [-+]?[0-9]+(\.[0-9]+)?
   - Store atof(yytext) into a[c++].
   - If c reaches 3, return 0 to stop scanning.
3. In main(), prompt user for three numbers, invoke yylex().
4. Find the maximum among a[0], a[1], and a[2], and display the largest number.
*/
#include <stdio.h>
#include <stdlib.h>
double a[3];
int c = 0;
%}

%option noyywrap

%%
[-+]?[0-9]+(\.[0-9]+)? {
    a[c++] = atof(yytext);
    if (c == 3) {
        return 0;
    }
}
[ \t\n]+|. ;
%%

int main(void) {
    printf("Enter three numbers: ");
    yylex();

    double max = a[0];
    if (a[1] > max) {
        max = a[1];
    }
    if (a[2] > max) {
        max = a[2];
    }

    printf("Largest number: %g\n", max);
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex largest_three.l
$ gcc lex.yy.c -o largest_three
$ printf "25.5 89.2 42.0\n" | ./largest_three
Enter three numbers: Largest number: 89.2
*/
