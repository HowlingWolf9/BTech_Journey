%{
/*
EXPERIMENT 06: RECOGNIZE VALID ARITHMETIC EXPRESSION USING YACC (EASY VERSION)

ALGORITHM:
1. Define tokens NUMBER and ID in Lex.
2. In Yacc, specify operator precedence and associativity:
   - %left '+' '-'
   - %left '*' '/'
3. Define arithmetic expression grammar:
   - exp -> E { print "Valid Expression"; }
   - E   -> E '+' E | E '-' E | E '*' E | E '/' E | '(' E ')' | NUMBER | ID
4. In main(), call yyparse().
5. If expression is invalid, yyerror() prints "Invalid Expression".
*/
#include <stdio.h>

int yylex(void);
void yyerror(char *s) {
    printf("Invalid Expression\n");
}
%}

%token NUMBER ID
%left '+' '-'
%left '*' '/'

%%
exp:
    E {
        printf("Valid Expression\n");
        return 0;
    }
    ;

E:
    E '+' E
    | E '-' E
    | E '*' E
    | E '/' E
    | '(' E ')'
    | NUMBER
    | ID
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
$ yacc -d expr.y
$ flex expr.l
$ gcc y.tab.c lex.yy.c -o expr

Test 1: Valid Expression
$ printf "a + b * (c - 5)\n" | ./expr
Enter expression: Valid Expression

Test 2: Invalid Expression
$ printf "a + * b\n" | ./expr
Enter expression: Invalid Expression
*/
