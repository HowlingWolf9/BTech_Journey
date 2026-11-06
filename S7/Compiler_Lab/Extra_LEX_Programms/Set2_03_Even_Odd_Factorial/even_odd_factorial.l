%{
/*
SET 2 - PROGRAM 03: LEX PROGRAM TO CHECK EVEN/ODD AND FIND FACTORIAL

ALGORITHM:
1. Initialize integer flag `matched = 0`.
2. Define Lex regular expression to match a signed/unsigned integer using `[-+]?[0-9]+`.
3. In the rule action:
   - Set `matched = 1`.
   - Convert string to integer `int n = atoi(yytext)`.
   - Check parity:
     - If `n % 2 == 0`, output that `n` is EVEN.
     - Else, output that `n` is ODD.
   - Calculate factorial:
     - If `n < 0`, report that factorial is not defined for negative numbers.
     - Else if `n > 20`, report 64-bit integer overflow.
     - Else:
       - Initialize `fact = 1`.
       - For `i = 2` to `n`, compute `fact = fact * i`.
       - Output the calculated factorial.
   - Return 0 to finish scanning.
4. On newline `\n`, return 0.
5. In `main()`:
   - Prompt user to enter a number.
   - Invoke `yylex()`.
   - If `matched` is 0, print "Error: No number entered."
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
                int n = atoi(yytext);

                if (n % 2 == 0) {
                    printf("Parity    : %d is EVEN\n", n);
                } else {
                    printf("Parity    : %d is ODD\n", n);
                }

                if (n < 0) {
                    printf("Factorial : Factorial is not defined for negative numbers.\n");
                } else if (n > 20) {
                    printf("Factorial : Overflow for values > 20 in 64-bit unsigned integer.\n");
                } else {
                    unsigned long long fact = 1;
                    for (int i = 2; i <= n; i++) {
                        fact *= i;
                    }
                    printf("Factorial : %d! = %llu\n", n, fact);
                }
                return 0;
            }
\n          { return 0; }
[ \t]+      ;
.           ;
%%

int main(void) {
    printf("Enter a number: ");
    yylex();

    if (!matched) {
        printf("Error: No number entered.\n");
    }

    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex even_odd_factorial.l
$ gcc lex.yy.c -o even_odd_factorial
$ ./even_odd_factorial
Enter a number: 5
Parity    : 5 is ODD
Factorial : 5! = 120

$ ./even_odd_factorial
Enter a number: 8
Parity    : 8 is EVEN
Factorial : 8! = 40320

$ ./even_odd_factorial
Enter a number: -5
Parity    : -5 is ODD
Factorial : Factorial is not defined for negative numbers.
*/
