%{
/*
SET 1 - PROGRAM 08: LEX PROGRAM TO COUNT POSITIVE AND NEGATIVE INTEGERS AND FLOATS

ALGORITHM:
1. Initialize four integer counters:
   - `pos_int = 0` (positive integers)
   - `neg_int = 0` (negative integers)
   - `pos_float = 0` (positive floating point numbers)
   - `neg_float = 0` (negative floating point numbers)
2. Define Lex regular expressions (order matters: float patterns precede integer patterns):
   - `\+?[0-9]+\.[0-9]+`: Positive float, increment `pos_float`.
   - `-[0-9]+\.[0-9]+`: Negative float, increment `neg_float`.
   - `\+?[0-9]+`: Positive integer, increment `pos_int`.
   - `-[0-9]+`: Negative integer, increment `neg_int`.
   - `\n`: return 0 to end scanning on newline.
   - Ignore whitespace and other non-numeric characters using `[ \t]+` and `.`.
3. In `main()`:
   - Prompt user to enter numbers.
   - Invoke `yylex()`.
   - Print the four counts.
*/

#include <stdio.h>

int pos_int = 0;
int neg_int = 0;
int pos_float = 0;
int neg_float = 0;

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
\+?[0-9]+\.[0-9]+   { pos_float++; }
-[0-9]+\.[0-9]+     { neg_float++; }
\+?[0-9]+           { pos_int++; }
-[0-9]+             { neg_int++; }
\n                  { return 0; }
[ \t]+              ;
.                   ;
%%

int main(void) {
    printf("Enter numbers separated by space: ");
    yylex();

    printf("\n--- Summary of Numbers ---\n");
    printf("Positive Integers : %d\n", pos_int);
    printf("Negative Integers : %d\n", neg_int);
    printf("Positive Floats   : %d\n", pos_float);
    printf("Negative Floats   : %d\n", neg_float);

    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex count_pos_neg.l
$ gcc lex.yy.c -o count_pos_neg
$ ./count_pos_neg
Enter numbers separated by space: 25 -10 +45 -3 3.14 -0.05 +99.99 -8.5

--- Summary of Numbers ---
Positive Integers : 2
Negative Integers : 2
Positive Floats   : 2
Negative Floats   : 2
*/
