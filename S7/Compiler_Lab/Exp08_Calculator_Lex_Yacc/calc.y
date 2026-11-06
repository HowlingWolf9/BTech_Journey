%{
/*
EXPERIMENT 08: IMPLEMENTATION OF CALCULATOR USING LEX AND YACC

ALGORITHM:
1. In Lex specification:
   - Identify floating-point or integer numbers: convert with atof() into yylval.dval and return token NUM.
   - Match and ignore whitespace.
   - Match newline \n and return NL.
   - Return any single operator character directly.
2. In YACC specification:
   - Define %union with double dval.
   - Declare operator precedence:
     * %left '+' '-'
     * %left '*' '/'
     * %right UMINUS
   - Define grammar rules for evaluating expressions:
     * Addition: expr '+' expr -> $$ = $1 + $3
     * Subtraction: expr '-' expr -> $$ = $1 - $3
     * Multiplication: expr '*' expr -> $$ = $1 * $3
     * Division: expr '/' expr -> check $3 != 0, else $$ = $1 / $3
     * Unary minus: '-' expr %prec UMINUS -> $$ = -$2
     * Parentheses: '(' expr ')' -> $$ = $2
     * Number: NUM -> $$ = $1
   - Upon encountering NL, print the calculated result.
3. In main(), invoke yyparse().
*/

#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%union {
    double dval;
}

%token <dval> NUM
%token NL
%type <dval> expr

%left '+' '-'
%left '*' '/'
%right UMINUS

%%
start: input
     ;

input: expr line_end {
    printf("Result = %g\n", $1);
}
;

line_end: NL
        | /* empty */
        ;

expr: expr '+' expr             { $$ = $1 + $3; }
    | expr '-' expr             { $$ = $1 - $3; }
    | expr '*' expr             { $$ = $1 * $3; }
    | expr '/' expr             {
                                    if ($3 == 0) {
                                        printf("Error: Division by zero\n");
                                        exit(1);
                                    }
                                    $$ = $1 / $3;
                                }
    | '(' expr ')'              { $$ = $2; }
    | '-' expr %prec UMINUS     { $$ = -$2; }
    | NUM                       { $$ = $1; }
    ;
%%

void yyerror(const char *s) {
    (void)s;
    printf("Syntax Error: Invalid expression\n");
}

int main(void) {
    printf("Enter expression to evaluate: ");
    yyparse();
    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ yacc -d calc.y
$ flex calc.l
$ gcc y.tab.c lex.yy.c -o calc

Test 1: Precedence and Parentheses
$ ./calc
Enter expression to evaluate: 10 + 2 * (5 - 1)
Result = 18

Test 2: Floating point arithmetic
$ ./calc
Enter expression to evaluate: 15 / 3 + 4.5
Result = 9.5

Test 3: Division by zero
$ ./calc
Enter expression to evaluate: 10 / 0
Error: Division by zero
*/
