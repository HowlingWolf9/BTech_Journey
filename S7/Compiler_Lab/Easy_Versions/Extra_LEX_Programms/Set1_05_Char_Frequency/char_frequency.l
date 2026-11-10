%{
/*
SET 1 - PROGRAM 05: LEX PROGRAM TO COUNT THE FREQUENCY OF A CHARACTER (EASY VERSION)

ALGORITHM:
1. Declare character variable ch and counter freq = 0.
2. Define Lex rules:
   - '\n' : return 0 to stop scanning on newline.
   - .    : if yytext[0] matches ch, increment freq.
3. In main():
   - Read target character ch and flush the remaining line buffer.
   - Prompt for sentence and invoke yylex().
   - Print the frequency of ch.
*/
#include <stdio.h>
char ch;
int freq = 0;
%}

%option noyywrap

%%
\n { return 0; }
.  {
    if (yytext[0] == ch) {
        freq++;
    }
}
%%

int main(void) {
    printf("Enter character: ");
    scanf(" %c", &ch);
    while (getchar() != '\n')
        ;

    printf("Enter sentence: ");
    yylex();

    printf("Frequency of '%c': %d\n", ch, freq);
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex char_frequency.l
$ gcc lex.yy.c -o char_frequency
$ printf "e\nengineering education\n" | ./char_frequency
Enter character: Enter sentence: Frequency of 'e': 4
*/
