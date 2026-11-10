%{
/*
SET 1 - PROGRAM 06: LEX PROGRAM TO FIND THE LENGTH OF THE LONGEST WORD (EASY VERSION)

ALGORITHM:
1. Initialize integer max = 0 and buffer longest[100] = "".
2. Define Lex rules:
   - [a-zA-Z]+ : if yyleng > max, update max = yyleng and copy yytext to longest.
   - '\n'      : return 0 to finish scanning on newline.
   - .         : ignore other characters.
3. In main(), prompt user for a string, call yylex(), and print the longest word and length.
*/
#include <stdio.h>
#include <string.h>
int max = 0;
char longest[100];
%}

%option noyywrap

%%
[a-zA-Z]+   {
                if (yyleng > max) {
                    max = yyleng;
                    strcpy(longest, yytext);
                }
            }
\n          { return 0; }
.           ;
%%

int main(void) {
    printf("Enter a string: ");
    yylex();

    printf("Longest word: %s\n", longest);
    printf("Length: %d\n", max);
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex longest_word.l
$ gcc lex.yy.c -o longest_word
$ printf "Compiler design and optimization techniques\n" | ./longest_word
Enter a string: Longest word: optimization
Length: 12
*/
