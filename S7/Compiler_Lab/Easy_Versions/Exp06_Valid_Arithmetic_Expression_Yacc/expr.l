%{
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
