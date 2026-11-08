%{
/*
SET 2 - PROGRAM 02: LEX PROGRAM TO PRINT FIBONACCI SERIES UP TO A GIVEN LIMIT (EASY VERSION)

ALGORITHM:
1. Define Lex rule matching an integer limit: [0-9]+.
2. In the rule action:
   - Parse limit = atoi(yytext).
   - Initialize a = 0, b = 1.
   - Print "Fibonacci series up to <limit>:".
   - Loop while a <= limit:
     * Print current term a.
     * Compute next = a + b, then update a = b, b = next.
   - Return 0 to finish scanning.
3. In main(), prompt user for limit, invoke yylex(), and terminate.
*/
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap

%%
[0-9]+  {
    int limit = atoi(yytext), a = 0, b = 1;
    printf("Fibonacci series up to %d:\n", limit);
    while (a <= limit) {
        printf("%d ", a);
        int next = a + b; a = b; b = next;
    }
    printf("\n");
    return 0;
}
\n|.    ;
%%

int main(void) {
    printf("Enter limit: ");
    yylex();
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex fibonacci.l
$ gcc lex.yy.c -o fibonacci
$ printf "50\n" | ./fibonacci
Enter limit: Fibonacci series up to 50:
0 1 1 2 3 5 8 13 21 34 
*/
