%{
/*
EXPERIMENT 07: LEX SPECIFICATION FOR IDENTIFIER RECOGNITION (EASY VERSION)

ALGORITHM:
1. Define Lex rules to tokenize input for Yacc:
   - [a-zA-Z_] : return LETTER token.
   - [0-9]     : return DIGIT token.
   - '\n'      : return 0 to signal end of identifier.
   - .         : return the character literal.
*/
#include "y.tab.h"
%}

%option noyywrap

%%
[a-zA-Z_]   return LETTER;
[0-9]       return DIGIT;
\n          return 0;
.           return yytext[0];
%%

/*
SAMPLE OUTPUT:
----------------------------------------
$ yacc -d identifier.y
$ flex identifier.l
$ gcc y.tab.c lex.yy.c -o identifier
$ printf "var_123\n" | ./identifier
Enter identifier: Valid Identifier
*/
