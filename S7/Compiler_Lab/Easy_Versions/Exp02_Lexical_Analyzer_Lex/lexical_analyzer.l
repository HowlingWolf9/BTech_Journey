%{
/*
EXPERIMENT 02: IMPLEMENTATION OF LEXICAL ANALYZER USING LEX (EASY VERSION)

ALGORITHM:
1. Define Lex regular expressions for C tokens:
   - Keywords: "int", "float", "char", "if", "else", "while", "return", "void"
   - Numbers: [0-9]+(\.[0-9]+)?
   - Identifiers: [a-zA-Z_][a-zA-Z0-9_]*
   - Operators: +, -, *, /, =, <, >
   - Delimiters: ;, ,, (, ), {, }
   - Whitespace: ignore
2. In main(), open "input.c", set yyin, and print table header.
3. Call yylex() to tokenize the input file.
4. Terminate.
*/
#include <stdio.h>
%}

%option noyywrap

%%
"int"|"float"|"char"|"if"|"else"|"while"|"return"|"void"   { printf("%-15s Keyword\n", yytext); }
[0-9]+(\.[0-9]+)?                                          { printf("%-15s Number\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*                                     { printf("%-15s Identifier\n", yytext); }
[+\-*/=<>]                                                 { printf("%-15s Operator\n", yytext); }
[;,(){}]                                                   { printf("%-15s Delimiter\n", yytext); }
[ \t\n]+|.                                                 ;
%%

int main() {
    yyin = fopen("input.c", "r");
    printf("%-15s Token\n------------------------------\n", "Lexeme");
    yylex();
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex lexical_analyzer.l
$ gcc lex.yy.c -o lexical_analyzer
$ ./lexical_analyzer
Lexeme          Token
------------------------------
int             Keyword
x               Identifier
=               Operator
10              Number
;               Delimiter
float           Keyword
y               Identifier
=               Operator
3.14            Number
;               Delimiter
if              Keyword
(               Delimiter
x               Identifier
>               Operator
5               Number
)               Delimiter
return          Keyword
y               Identifier
;               Delimiter
*/
