%{
/*
SET 2 - PROGRAM 04: LEX PROGRAM TO CHECK ARMSTRONG NUMBER (EASY VERSION)

ALGORITHM:
1. Define Lex rule matching an integer: [0-9]+.
2. In the rule action:
   - Obtain number of digits d = yyleng.
   - Parse original number n = atoi(yytext).
   - Initialize sum = 0, temporary copy t = n.
   - While t > 0:
     * Extract digit r = t % 10.
     * Compute r raised to power d and add to sum.
     * Update t = t / 10.
   - If sum == n, output that n is an Armstrong number, else NOT.
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
    int t = n;
    int sum = 0;
    int d = yyleng;

    while (t) {
        int r = t % 10;
        int p = 1;
        for (int i = 0; i < d; i++) {
            p *= r;
        }
        sum += p;
        t /= 10;
    }

    printf("%d is %s\n", n, (sum == n) ? "an Armstrong number" : "NOT an Armstrong number");
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
$ flex armstrong.l
$ gcc lex.yy.c -o armstrong

Test 1: Armstrong number
$ printf "153\n" | ./armstrong
Enter number: 153 is an Armstrong number

Test 2: Not an Armstrong number
$ printf "123\n" | ./armstrong
Enter number: 123 is NOT an Armstrong number
*/
