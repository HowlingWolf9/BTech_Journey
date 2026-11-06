%{
/*
SET 2 - PROGRAM 02: LEX PROGRAM TO PRINT FIBONACCI SERIES UP TO A GIVEN LIMIT

ALGORITHM:
1. Initialize integer flag `matched = 0`.
2. Define Lex regular expression to match integer limit using `[-+]?[0-9]+`.
3. In the rule action:
   - Set `matched = 1`.
   - Convert `yytext` to integer `limit = atoll(yytext)`.
   - If `limit < 0`, display error and return 0.
   - Initialize `a = 0`, `b = 1`.
   - Loop while `a <= limit`:
     - Print `a`.
     - Compute next term `next = a + b`.
     - Update `a = b`, `b = next`.
   - Return 0 to finish scanning.
4. On newline `\n`, return 0.
5. In `main()`:
   - Prompt the user for the limit.
   - Invoke `yylex()`.
   - If `matched` is 0, print "Error: No limit entered."
*/

#include <stdio.h>
#include <stdlib.h>

int matched = 0;

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
[-+]?[0-9]+ {
                matched = 1;
                long long limit = atoll(yytext);

                if (limit < 0) {
                    printf("Error: Limit must be non-negative (%lld).\n", limit);
                    return 0;
                }

                long long a = 0, b = 1, next = 0;
                printf("Fibonacci series up to %lld:\n", limit);
                int first = 1;
                while (a <= limit) {
                    if (!first) {
                        printf(", ");
                    }
                    printf("%lld", a);
                    first = 0;
                    next = a + b;
                    a = b;
                    b = next;
                }
                printf("\n");
                return 0;
            }
\n          { return 0; }
[ \t]+      ;
.           ;
%%

int main(void) {
    printf("Enter the limit: ");
    yylex();

    if (!matched) {
        printf("Error: No limit entered.\n");
    }

    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex fibonacci.l
$ gcc lex.yy.c -o fibonacci
$ ./fibonacci
Enter the limit: 50
Fibonacci series up to 50:
0, 1, 1, 2, 3, 5, 8, 13, 21, 34

$ ./fibonacci
Enter the limit: -10
Error: Limit must be non-negative (-10).
*/
