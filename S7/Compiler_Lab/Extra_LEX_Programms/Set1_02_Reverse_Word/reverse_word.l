%{
/*
SET 1 - PROGRAM 02: LEX PROGRAM TO REVERSE A GIVEN WORD

ALGORITHM:
1. Initialize an integer flag `matched = 0`.
2. Define a Lex rule matching any non-whitespace sequence / word using `[^\t\n ]+`.
3. When a word is matched:
   - Set `matched = 1`.
   - Print "Reversed word: ".
   - Iterate in reverse from index `yyleng - 1` down to `0`.
   - Output each character with `putchar()`.
   - Print a newline and return 0.
4. On newline `\n`, return 0 to end scanning.
5. Ignore other characters.
6. In `main()`:
   - Prompt the user to enter a word.
   - Call `yylex()` to scan and process the input.
   - If `matched` is 0, print "No word entered."
*/

#include <stdio.h>

int matched = 0;

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
[^\t\n ]+   {
                matched = 1;
                printf("Reversed word: ");
                for (int i = yyleng - 1; i >= 0; i--) {
                    putchar(yytext[i]);
                }
                printf("\n");
                return 0;
            }
\n          { return 0; }
.           ;
%%

int main(void) {
    printf("Enter a word: ");
    yylex();

    if (!matched) {
        printf("No word entered.\n");
    }

    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex reverse_word.l
$ gcc lex.yy.c -o reverse_word
$ ./reverse_word
Enter a word: Compiler
Reversed word: relipmoC

$ ./reverse_word
Enter a word: Malayalam
Reversed word: mayalaM

$ ./reverse_word
Enter a word: 
No word entered.
*/
