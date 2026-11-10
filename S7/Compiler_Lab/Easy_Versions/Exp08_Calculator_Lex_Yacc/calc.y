%{
/*
EXPERIMENT 08: IMPLEMENTATION OF CALCULATOR USING LEX AND YACC (EASY VERSION)

ALGORITHM:
1. In Lex, match integers [0-9]+, assign atoi(yytext) to yylval, and return NUM.
2. In Yacc, specify operator precedence and associativity:
   - %left '+' '-'
   - %left '*' '/'
3. Define arithmetic evaluation grammar:
   - S -> E { print result; }
   - E -> E '+' E | E '-' E | E '*' E | E '/' E | '(' E ')' | NUM
4. In main(), call yyparse().
5. yyerror() prints "Invalid expression" upon syntax error.
*/
#include <stdio.h>

int yylex(void);
void yyerror(char *s) {
    printf("Invalid expression\n");
}
%}

%token NUM
%left '+' '-'
%left '*' '/'

%%
S:
    E {
        printf("Result = %d\n", $1);
        return 0;
    }
    ;

E:
    E '+' E     { $$ = $1 + $3; }
    | E '-' E   { $$ = $1 - $3; }
    | E '*' E   { $$ = $1 * $3; }
    | E '/' E   { $$ = $1 / $3; }
    | '(' E ')' { $$ = $2; }
    | NUM       { $$ = $1; }
    ;
%%

int main(void) {
    printf("Enter expression: ");
    yyparse();
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ yacc -d calc.y
$ flex calc.l
$ gcc y.tab.c lex.yy.c -o calc

Test 1: Precedence and parentheses
$ printf "10 + 2 * (5 - 1)\n" | ./calc
Enter expression: Result = 18

Test 2: Division and subtraction
$ printf "20 / 4 - 2\n" | ./calc
Enter expression: Result = 3
*/
