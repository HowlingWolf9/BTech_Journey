%{
/*
EXPERIMENT 08: LEX SPECIFICATION FOR ARITHMETIC CALCULATOR (EASY VERSION)

ALGORITHM:
1. Define Lex rules to tokenize input for Yacc:
   - [0-9]+ : convert string to integer using atoi(), assign to yylval, return NUM.
   - [ \t]  : ignore whitespace.
   - '\n'   : return 0 to signal end of expression.
   - .      : return character literal (operator or parenthesis).
*/
#include "y.tab.h"
#include <stdlib.h>
%}

%option noyywrap

%%
[0-9]+      { yylval = atoi(yytext); return NUM; }
[ \t]       ;
\n          return 0;
.           return yytext[0];
%%

/*
SAMPLE OUTPUT:
----------------------------------------
$ yacc -d calc.y
$ flex calc.l
$ gcc y.tab.c lex.yy.c -o calc
$ printf "10 + 2 * (5 - 1)\n" | ./calc
Enter expression: Result = 18
*/
