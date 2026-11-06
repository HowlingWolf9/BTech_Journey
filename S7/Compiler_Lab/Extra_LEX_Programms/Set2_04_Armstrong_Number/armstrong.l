%{
/*
SET 2 - PROGRAM 04: LEX PROGRAM TO CHECK ARMSTRONG NUMBER

ALGORITHM:
1. Initialize integer flag `matched = 0`.
2. Define Lex regular expression to match a signed/unsigned number using `[-+]?[0-9]+`.
3. In the rule action:
   - Set `matched = 1`.
   - If negative, report that negative numbers cannot be Armstrong numbers, and return 0.
   - Strip leading '+' if present.
   - Parse integer `original = atoi(num_str)`.
   - Determine number of digits `d = strlen(num_str)`.
   - Compute the sum of each digit raised to the power `d`.
   - If computed sum equals `original`, output that it is an Armstrong number.
   - Otherwise, output that it is NOT an Armstrong number.
   - Return 0 to finish scanning.
4. On newline `\n`, return 0.
5. In `main()`:
   - Prompt user to enter a number.
   - Invoke `yylex()`.
   - If `matched` is 0, print "Error: No number entered."
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int matched = 0;

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
[-+]?[0-9]+ {
                matched = 1;
                if (yytext[0] == '-') {
                    printf("Result: Negative numbers cannot be Armstrong numbers.\n");
                    return 0;
                }

                char *num_str = yytext;
                if (yytext[0] == '+') {
                    num_str = yytext + 1;
                }

                int original = atoi(num_str);
                int d = (int)strlen(num_str);
                long long sum = 0;

                for (int i = 0; i < d; i++) {
                    int digit = num_str[i] - '0';
                    long long p = 1;
                    for (int j = 0; j < d; j++) {
                        p *= digit;
                    }
                    sum += p;
                }

                if (sum == (long long)original) {
                    printf("Result: %d is an ARMSTRONG number.\n", original);
                } else {
                    printf("Result: %d is NOT an Armstrong number (sum of powers = %lld).\n", original, sum);
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
$ flex armstrong.l
$ gcc lex.yy.c -o armstrong
$ ./armstrong
Enter a number: 153
Result: 153 is an ARMSTRONG number.

$ ./armstrong
Enter a number: 125
Result: 125 is NOT an Armstrong number (sum of powers = 134).

$ ./armstrong
Enter a number: -153
Result: Negative numbers cannot be Armstrong numbers.
*/
