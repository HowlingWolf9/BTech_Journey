%{
/*
SET 2 - PROGRAM 05: LEX PROGRAM TO FIND THE SUM OF DIGITS OF A GIVEN NUMBER

ALGORITHM:
1. Initialize integer flag `matched = 0`.
2. Define Lex regular expression to match a signed/unsigned sequence of digits using `[-+]?[0-9]+`.
3. In the rule action:
   - Set `matched = 1`.
   - Initialize integer `sum = 0`.
   - Start from index 1 if sign character (`+`/`-`) is present, else index 0.
   - Iterate through every digit in `yytext` up to `yyleng - 1`.
   - Accumulate `sum += yytext[i] - '0'`.
   - Display the original number and the calculated sum of digits.
   - Return 0 to finish scanning.
4. On newline `\n`, return 0.
5. In `main()`:
   - Prompt user to enter a number.
   - Invoke `yylex()`.
   - If `matched` is 0, print "Error: No number entered."
*/

#include <stdio.h>

int matched = 0;

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
[-+]?[0-9]+ {
                matched = 1;
                int sum = 0;
                int start = (yytext[0] == '-' || yytext[0] == '+') ? 1 : 0;
                for (int i = start; i < yyleng; i++) {
                    sum += yytext[i] - '0';
                }
                printf("Number        : %s\n", yytext);
                printf("Sum of digits : %d\n", sum);
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
$ flex sum_of_digits.l
$ gcc lex.yy.c -o sum_of_digits
$ ./sum_of_digits
Enter a number: 12345
Number        : 12345
Sum of digits : 15

$ ./sum_of_digits
Enter a number: 9876
Number        : 9876
Sum of digits : 30

$ ./sum_of_digits
Enter a number: -9876
Number        : -9876
Sum of digits : 30
*/
