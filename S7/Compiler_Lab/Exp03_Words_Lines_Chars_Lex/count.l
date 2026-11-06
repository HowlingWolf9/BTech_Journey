%{
/*
EXPERIMENT 03: LEX PROGRAM TO DISPLAY NUMBER OF WORDS, LINES AND CHARACTERS

ALGORITHM:
1. Initialize integer counters: `lines = 0`, `words = 0`, `chars = 0`.
2. Define regular expressions in Lex:
   - '\n' (newline): increment `lines` and `chars`.
   - '[^ \t\n]+' (word - continuous non-whitespace characters): increment `words` and add `yyleng` to `chars`.
   - '.' (any other single character): increment `chars`.
3. In main(), invoke `yylex()` to read input until EOF.
4. If input has characters and does not end with a newline, account for the final line.
5. Display the calculated counts of lines, words, and characters.
*/

#include <stdio.h>

int lines = 0;
int words = 0;
int chars = 0;
int last_char = '\n';

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
\n          { lines++; chars++; last_char = '\n'; }
[^ \t\n\r]+ { words++; chars += yyleng; last_char = yytext[yyleng - 1]; }
.           { chars++; last_char = yytext[0]; }
%%

int main(void) {
    printf("Enter text (Ctrl+D / EOF to end):\n");
    yylex();

    // If input had text and didn't end with newline, account for the final line
    if (chars > 0 && last_char != '\n') {
        lines++;
    }

    printf("\n--- Results ---\n");
    printf("Lines      : %d\n", lines);
    printf("Words      : %d\n", words);
    printf("Characters : %d\n", chars);

    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ flex count.l
$ gcc lex.yy.c -o count
$ ./count
Enter text (Ctrl+D / EOF to end):
Hello World
Compiler Design Lab

--- Results ---
Lines      : 2
Words      : 5
Characters : 32
*/
