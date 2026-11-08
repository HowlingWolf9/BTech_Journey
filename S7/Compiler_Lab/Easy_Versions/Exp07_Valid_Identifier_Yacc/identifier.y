%{
/*
EXPERIMENT 07: RECOGNIZE VALID IDENTIFIER USING YACC (EASY VERSION)

ALGORITHM:
1. Define tokens LETTER and DIGIT in Lex.
2. In Yacc, define grammar for identifier:
   - start -> ID { print "Valid Identifier"; }
   - ID    -> LETTER REST
   - REST  -> REST LETTER | REST DIGIT | (empty)
3. Define yyerror() to print "Invalid Identifier".
4. In main(), call yyparse().
*/
#include <stdio.h>
int yylex();
void yyerror(char *s) { printf("Invalid Identifier\n"); }
%}

%token LETTER DIGIT

%%
start: ID { printf("Valid Identifier\n"); return 0; } ;
ID: LETTER REST ;
REST: REST LETTER | REST DIGIT | ;
%%

int main() {
    printf("Enter identifier: ");
    yyparse();
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ yacc -d identifier.y
$ flex identifier.l
$ gcc y.tab.c lex.yy.c -o identifier

Test 1: Valid Identifier
$ printf "var_123\n" | ./identifier
Enter identifier: Valid Identifier

Test 2: Invalid Identifier
$ printf "123var\n" | ./identifier
Enter identifier: Invalid Identifier
*/
