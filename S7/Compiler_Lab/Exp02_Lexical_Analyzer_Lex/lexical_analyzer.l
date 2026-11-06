%{
/*
EXPERIMENT 02: IMPLEMENTATION OF LEXICAL ANALYZER USING LEX

ALGORITHM:
1. Define regular expressions in LEX for various C language tokens:
   - Single-line comments: //.*
   - Multi-line comments: multi-line comment pattern
   - Whitespace: [ \t\n]+ (skip/ignore)
   - Keywords: int, float, char, double, void, if, else, while, for, return, break, do
   - Identifiers: [a-zA-Z_][a-zA-Z0-9_]*
   - Constants / Numbers: [0-9]+(\.[0-9]+)?
   - Operators: ==, <=, >=, !=, =, +, -, *, /, <, >
   - Delimiters / Special characters: ;, ,, (, ), {, }, [, ]
2. For each matched pattern, print formatted token type and lexeme.
3. In main(), open input file ("input.c" or argv[1]), point yyin to it, call yylex(), and close file.
*/

#include <stdio.h>
#include <stdlib.h>

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
\/\/[^\n]*                              { /* Ignore single-line comments */ }
\/\*([^*]|\*+[^*/])*\*+\/              { /* Ignore multi-line comments */ }
[ \t\n]+                                { /* Ignore whitespace */ }

"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while" {
    printf("%-20s %-20s\n", yytext, "Keyword");
}

[0-9]+(\.[0-9]+)? {
    printf("%-20s %-20s\n", yytext, "Constant");
}

"=="|"<="|">="|"!="|"+"|"-"|"*"|"/"|"%"|"="|"<"|">" {
    printf("%-20s %-20s\n", yytext, "Operator");
}

[;,(){}\[\]] {
    printf("%-20s %-20s\n", yytext, "Delimiter");
}

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("%-20s %-20s\n", yytext, "Identifier");
}

. {
    printf("%-20s %-20s\n", yytext, "Unknown Character");
}
%%

int main(int argc, char *argv[]) {
    const char *filename = (argc > 1) ? argv[1] : "input.c";
    FILE *fp = fopen(filename, "r");
    if (!fp) {
        printf("Error: Could not open file %s\n", filename);
        return 1;
    }

    yyin = fp;
    printf("%-20s %-20s\n", "Lexeme", "Token");
    printf("----------------------------------------\n");
    yylex();

    fclose(fp);
    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ flex lexical_analyzer.l
$ gcc lex.yy.c -o lexical_analyzer
$ ./lexical_analyzer input.c
Lexeme               Token               
----------------------------------------
int                  Keyword             
main                 Identifier          
(                    Delimiter           
)                    Delimiter           
{                    Delimiter           
int                  Keyword             
x                    Identifier          
=                    Operator            
10                   Constant            
;                    Delimiter           
float                Keyword             
y                    Identifier          
=                    Operator            
3.14                 Constant            
;                    Delimiter           
if                   Keyword             
(                    Delimiter           
x                    Identifier          
>=                   Operator            
5                    Constant            
)                    Delimiter           
{                    Delimiter           
y                    Identifier          
=                    Operator            
y                    Identifier          
+                    Operator            
1.0                  Constant            
;                    Delimiter           
}                    Delimiter           
return               Keyword             
0                    Constant            
;                    Delimiter           
}                    Delimiter           
*/
