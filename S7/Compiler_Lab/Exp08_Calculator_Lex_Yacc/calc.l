%{
#include "y.tab.h"
#include <stdlib.h>

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
[0-9]+(\.[0-9]+)?   { yylval.dval = atof(yytext); return NUM; }
[ \t\r]             { /* ignore whitespace */ }
\n                  { return NL; }
.                   { return yytext[0]; }
%%
