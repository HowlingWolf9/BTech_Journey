%{
/*
EXPERIMENT 06: LEX SPECIFICATION FOR ARITHMETIC EXPRESSION (EASY VERSION)

ALGORITHM:
1. Define Lex rules to tokenize input for Yacc:
   - [0-9]+                  : return NUMBER token.
   - [a-zA-Z_][a-zA-Z0-9_]* : return ID token.
   - [ \t]                   : ignore whitespace.
   - '\n'                    : return 0 to signal end of expression.
   - .                       : return the operator/parenthesis character literal.
*/
#include "y.tab.h"
%}

%option noyywrap

%%
[0-9]+                  return NUMBER;
[a-zA-Z_][a-zA-Z0-9_]* return ID;
[ \t]                   ;
\n                      return 0;
.                       return yytext[0];
%%

/*
SAMPLE OUTPUT:
----------------------------------------
$ yacc -d expr.y
$ flex expr.l
$ gcc y.tab.c lex.yy.c -o expr
$ printf "a + b * c\n" | ./expr
Enter expression: Valid Expression
*/
