%{
/*
SET 2 - PROGRAM 05: LEX PROGRAM TO FIND THE SUM OF DIGITS OF A GIVEN NUMBER (EASY VERSION)

ALGORITHM:
1. Define Lex regular expression to match an integer: [0-9]+.
2. In the rule action:
   - Initialize integer sum = 0.
   - Loop through characters from index 0 to yyleng - 1:
     * Add integer value of digit (yytext[i] - '0') to sum.
   - Display the computed sum of digits.
   - Return 0 to finish scanning.
3. In main(), prompt user for a number, invoke yylex(), and terminate.
*/
#include <stdio.h>
%}

%option noyywrap

%%
[0-9]+  {
    int sum = 0;
    for (int i = 0; i < yyleng; i++) sum += yytext[i] - '0';
    printf("Sum of digits = %d\n", sum);
    return 0;
}
\n|.    ;
%%

int main(void) {
    printf("Enter number: ");
    yylex();
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex sum_of_digits.l
$ gcc lex.yy.c -o sum_of_digits
$ printf "98765\n" | ./sum_of_digits
Enter number: Sum of digits = 35
*/
