%{
/*
SET 1 - PROGRAM 07: LEX PROGRAM TO ACCEPT A STRING STARTING WITH A VOWEL (EASY VERSION)

ALGORITHM:
1. Define Lex rules using start-of-line anchor (^):
   - ^[aeiouAEIOU][^\n]* : string begins with vowel; display "Accepted: Starts with a vowel" and return 0.
   - [^\n]+              : string does not begin with vowel; display "Rejected: Does not start with a vowel" and return 0.
2. In main(), prompt user for a string, invoke yylex(), and terminate.
*/
#include <stdio.h>
%}

%option noyywrap

%%
^[aeiouAEIOU][^\n]*   {
                          printf("Accepted: Starts with a vowel\n");
                          return 0;
                      }
[^\n]+                {
                          printf("Rejected: Does not start with a vowel\n");
                          return 0;
                      }
\n|.                  ;
%%

int main(void) {
    printf("Enter string: ");
    yylex();
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex starting_vowel.l
$ gcc lex.yy.c -o starting_vowel

Test 1: Starts with vowel
$ printf "apple\n" | ./starting_vowel
Enter string: Accepted: Starts with a vowel

Test 2: Does not start with vowel
$ printf "banana\n" | ./starting_vowel
Enter string: Rejected: Does not start with a vowel
*/
