%{
/*
SET 1 - PROGRAM 08: LEX PROGRAM TO COUNT POSITIVE AND NEGATIVE INTEGERS AND FLOATS (EASY VERSION)

ALGORITHM:
1. Initialize integer counters: pi = 0, ni = 0, pf = 0, nf = 0.
2. Define Lex rules (floats checked before integers):
   - \+?[0-9]+\.[0-9]+ : increment positive float counter (pf).
   - -[0-9]+\.[0-9]+   : increment negative float counter (nf).
   - \+?[0-9]+         : increment positive integer counter (pi).
   - -[0-9]+           : increment negative integer counter (ni).
   - '\n'              : return 0 to end scanning on newline.
   - [ \t]+|.          : ignore whitespace and other characters.
3. In main(), prompt user for numbers, call yylex(), and print counts.
*/
#include <stdio.h>
int pi = 0, ni = 0, pf = 0, nf = 0;
%}

%option noyywrap

%%
\+?[0-9]+\.[0-9]+   { pf++; }
-[0-9]+\.[0-9]+     { nf++; }
\+?[0-9]+           { pi++; }
-[0-9]+             { ni++; }
\n                  { return 0; }
[ \t]+|.            ;
%%

int main(void) {
    printf("Enter numbers: ");
    yylex();

    printf("Positive Integers: %d\n", pi);
    printf("Negative Integers: %d\n", ni);
    printf("Positive Floats: %d\n", pf);
    printf("Negative Floats: %d\n", nf);
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex count_pos_neg.l
$ gcc lex.yy.c -o count_pos_neg
$ printf "12 -5 3.14 -0.5 +7\n" | ./count_pos_neg
Enter numbers: Positive Integers: 2
Negative Integers: 1
Positive Floats: 1
Negative Floats: 1
*/
