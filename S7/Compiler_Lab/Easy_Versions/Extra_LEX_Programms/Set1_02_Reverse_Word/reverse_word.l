%{
/*
SET 1 - PROGRAM 02: LEX PROGRAM TO REVERSE A GIVEN WORD (EASY VERSION)

ALGORITHM:
1. Define a Lex rule matching any non-whitespace word using [^ \t\n]+.
2. In the rule action:
   - Print "Reversed word: ".
   - Loop from index yyleng - 1 down to 0, printing each character.
   - Return 0 to finish scanning.
3. In main(), prompt user for a word, call yylex(), and terminate.
*/
#include <stdio.h>
%}

%option noyywrap

%%
[^ \t\n]+ {
    printf("Reversed word: ");
    for (int i = yyleng - 1; i >= 0; i--) {
        putchar(yytext[i]);
    }
    printf("\n");
    return 0;
}
\n|. ;
%%

int main(void) {
    printf("Enter word: ");
    yylex();
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex reverse_word.l
$ gcc lex.yy.c -o reverse_word
$ printf "compiler\n" | ./reverse_word
Enter word: Reversed word: relipmoc
*/
