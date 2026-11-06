%{
/*
SET 1 - PROGRAM 07: LEX PROGRAM TO ACCEPT A STRING STARTING WITH A VOWEL

ALGORITHM:
1. Initialize integer flag `matched = 0`.
2. Define Lex regular expressions using line anchors (`^`):
   - `^[aeiouAEIOU][^\n]*`:
     Matches strings that start with an uppercase or lowercase vowel.
     Action: Print "ACCEPTED: String starts with a vowel.", set `matched = 1`, and return 0.
   - `^[^aeiouAEIOU\n][^\n]*`:
     Matches strings starting with any character other than a vowel or newline.
     Action: Print "REJECTED: String does not start with a vowel.", set `matched = 1`, and return 0.
   - `^\n`:
     Matches an empty line. Print "REJECTED: Empty string.", set `matched = 1`, and return 0.
3. In `main()`:
   - Prompt user to enter a string.
   - Call `yylex()`.
   - If `!matched`, output "REJECTED: Empty input".
*/

#include <stdio.h>

int matched = 0;

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
^[aeiouAEIOU][^\n]*     {
                            matched = 1;
                            printf("Result: ACCEPTED (String \"%s\" starts with vowel '%c')\n", yytext, yytext[0]);
                            return 0;
                        }
^[^aeiouAEIOU\n][^\n]*  {
                            matched = 1;
                            printf("Result: REJECTED (String \"%s\" starts with '%c', which is not a vowel)\n", yytext, yytext[0]);
                            return 0;
                        }
^\n                     {
                            matched = 1;
                            printf("Result: REJECTED (Empty string)\n");
                            return 0;
                        }
.|\n                    ;
%%

int main(void) {
    printf("Enter a string: ");
    yylex();

    if (!matched) {
        printf("Result: REJECTED (Empty input)\n");
    }

    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex starting_vowel.l
$ gcc lex.yy.c -o starting_vowel
$ ./starting_vowel
Enter a string: Apple
Result: ACCEPTED (String "Apple" starts with vowel 'A')

$ ./starting_vowel
Enter a string: banana
Result: REJECTED (String "banana" starts with 'b', which is not a vowel)

$ ./starting_vowel
Enter a string: 
Result: REJECTED (Empty string)
*/
