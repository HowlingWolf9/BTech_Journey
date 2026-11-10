%{
/*
EXPERIMENT 04: LEX PROGRAM TO CONVERT SUBSTRING abc TO ABC (EASY VERSION)

ALGORITHM:
1. Define Lex rules:
   - Match "abc": print "ABC".
   - Match any other character (.|\n): echo original character.
2. In main(), prompt user and call yylex() to scan standard input.
3. Terminate.
*/
#include <stdio.h>
%}

%option noyywrap

%%
abc     { printf("ABC"); }
.|\n    { ECHO; }
%%

int main(void) {
    printf("Enter string: ");
    yylex();
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex replace_abc.l
$ gcc lex.yy.c -o replace_abc
$ printf "abc xyz 123abc\n" | ./replace_abc
Enter string: ABC xyz 123ABC
*/
