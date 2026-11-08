%{
#include "y.tab.h"
%}

%option noyywrap

%%
[a-zA-Z_]   return LETTER;
[0-9]       return DIGIT;
\n          return 0;
.           return yytext[0];
%%
