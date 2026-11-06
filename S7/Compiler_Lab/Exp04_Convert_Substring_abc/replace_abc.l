%{
/*
EXPERIMENT 04: CONVERT SUBSTRING abc TO ABC

ALGORITHM:
1. Define the lexical rules in Lex:
   - Match the target literal string "abc": output replacement "ABC".
   - Match any other character or newline (.|\n): echo the character unchanged using putchar(yytext[0]).
2. In main():
   - Prompt the user to enter an input string.
   - Invoke `yylex()` to perform the substitution streamingly until EOF.
3. Return 0 and exit.
*/

#include <stdio.h>

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
"abc"       { printf("ABC"); }
.|\n        { putchar(yytext[0]); }
%%

int main(void) {
    printf("Enter input string: ");
    yylex();
    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ flex replace_abc.l
$ gcc lex.yy.c -o replace_abc
$ ./replace_abc
Enter input string: abc xyz abc123abc
ABC xyz ABC123ABC
*/
