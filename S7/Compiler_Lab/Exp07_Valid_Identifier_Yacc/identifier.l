%{
#include "y.tab.h"
int yywrap(void) { return 1; }
%}

%option noinput nounput

%%
[a-zA-Z_]   { return LETTER; }
[0-9]       { return DIGIT; }
\r          { /* ignore CR */ }
\n          { return NL; }
.           { return yytext[0]; }
%%
