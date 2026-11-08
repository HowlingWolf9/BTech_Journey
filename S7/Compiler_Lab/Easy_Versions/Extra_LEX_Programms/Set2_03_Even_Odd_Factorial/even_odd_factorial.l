%{
/*
SET 2 - PROGRAM 03: LEX PROGRAM TO CHECK EVEN/ODD AND FIND FACTORIAL (EASY VERSION)

ALGORITHM:
1. Define Lex rule matching integers: [0-9]+.
2. In the rule action:
   - Parse n = atoi(yytext).
   - Check parity: if n % 2 == 0, output EVEN; else output ODD.
   - Calculate factorial: initialize fact = 1, multiply by each integer from 1 to n.
   - Display parity and calculated factorial.
   - Return 0 to finish scanning.
3. In main(), prompt user for a number, invoke yylex(), and terminate.
*/
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap

%%
[0-9]+  {
    int n = atoi(yytext);
    long fact = 1;
    for (int i = 1; i <= n; i++) fact *= i;
    printf("%d is %s\nFactorial of %d = %ld\n", n, (n % 2 == 0) ? "EVEN" : "ODD", n, fact);
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
$ flex even_odd_factorial.l
$ gcc lex.yy.c -o even_odd_factorial
$ printf "5\n" | ./even_odd_factorial
Enter number: 5 is ODD
Factorial of 5 = 120
*/
