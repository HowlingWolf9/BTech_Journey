%{
/*
EXPERIMENT 06: YACC SPECIFICATION TO RECOGNIZE VALID ARITHMETIC EXPRESSION

ALGORITHM:
1. Define tokens in Lex: NUMBER for digits, ID for variable names, and NL for newline.
2. In YACC, define token precedence and associativity:
   - Left-associative: '+', '-'
   - Left-associative: '*', '/'
3. Define grammar rules for arithmetic expressions:
   - expr -> expr '+' expr
           | expr '-' expr
           | expr '*' expr
           | expr '/' expr
           | '(' expr ')'
           | NUMBER
           | ID
4. If expression parses successfully followed by newline (NL), display "Valid arithmetic expression".
5. If syntax error occurs, yyerror() displays "Invalid arithmetic expression".
*/

#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER ID NL
%left '+' '-'
%left '*' '/'

%%
start: input
     ;

input: expr line_end
     ;

line_end: NL
        | /* empty */
        ;

expr: expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '(' expr ')'
    | NUMBER
    | ID
    ;
%%

void yyerror(const char *s) {
    (void)s;
    printf("Invalid arithmetic expression\n");
}

int main(void) {
    printf("Enter an arithmetic expression: ");
    if (yyparse() == 0) {
        printf("Valid arithmetic expression\n");
    }
    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ yacc -d expr.y
$ flex expr.l
$ gcc y.tab.c lex.yy.c -o expr

Test 1: Valid Expression
$ ./expr
Enter an arithmetic expression: a + b * (c - 5)
Valid arithmetic expression

Test 2: Invalid Expression
$ ./expr
Enter an arithmetic expression: a + * b
Invalid arithmetic expression
*/
