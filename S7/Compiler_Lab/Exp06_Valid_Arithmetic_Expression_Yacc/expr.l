%{
#include "y.tab.h"
int yywrap(void) { return 1; }
%}

%option noinput nounput

%%
[0-9]+                      { return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*     { return ID; }
[ \t\r]                     { /* skip whitespace */ }
\n                          { return NL; }
.                           { return yytext[0]; }
%%
