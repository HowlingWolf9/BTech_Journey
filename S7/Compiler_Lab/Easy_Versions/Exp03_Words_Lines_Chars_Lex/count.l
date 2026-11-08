%{
/*
EXPERIMENT 03: LEX PROGRAM TO COUNT WORDS, LINES AND CHARACTERS (EASY VERSION)

ALGORITHM:
1. Initialize integer counters: l = 0 (lines), w = 0 (words), c = 0 (characters).
2. Define Lex rules:
   - '\n'        : increment lines (l) and characters (c).
   - '[^ \t\n]+' : increment words (w) and add token length (yyleng) to characters (c).
   - '.'         : increment characters (c).
3. In main(), call yylex() to scan standard input.
4. Print the final counts of lines, words, and characters.
*/
#include <stdio.h>
int l = 0, w = 0, c = 0;
%}

%option noyywrap

%%
\n          { l++; c++; }
[^ \t\n]+   { w++; c += yyleng; }
.           { c++; }
%%

int main() {
    printf("Enter text:\n");
    yylex();
    printf("\nLines: %d\nWords: %d\nCharacters: %d\n", l, w, c);
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex count.l
$ gcc lex.yy.c -o count
$ printf "Hello World\nCompiler Lab\n" | ./count
Enter text:

Lines: 2
Words: 4
Characters: 25
*/
