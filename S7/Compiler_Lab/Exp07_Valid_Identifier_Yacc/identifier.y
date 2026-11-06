%{
/*
EXPERIMENT 07: YACC SPECIFICATION TO RECOGNIZE VALID IDENTIFIER

ALGORITHM:
1. Define token patterns in Lex:
   - Match letter or underscore [a-zA-Z_]: return LETTER.
   - Match digit [0-9]: return DIGIT.
   - Match newline \n: return NL.
   - Match any other character: return character itself.
2. In YACC, define identifier grammar:
   - input -> var NL  (Success action: print "Valid Identifier")
   - var   -> LETTER rest
   - rest  -> rest LETTER
            | rest DIGIT
            | epsilon (empty)
3. If an input fails to derive from the grammar, yyerror() prints "Invalid Identifier".
4. Prompt user, call yyparse(), and return 0.
*/

#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%token LETTER DIGIT NL

%%
start: input
     ;

input: var line_end
     ;

line_end: NL
        | /* empty */
        ;

var: LETTER rest
   ;

rest: rest LETTER
    | rest DIGIT
    | /* empty */
    ;
%%

void yyerror(const char *s) {
    (void)s;
    printf("Invalid Identifier\n");
}

int main(void) {
    printf("Enter an identifier: ");
    if (yyparse() == 0) {
        printf("Valid Identifier\n");
    }
    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ yacc -d identifier.y
$ flex identifier.l
$ gcc y.tab.c lex.yy.c -o identifier

Test 1: Valid Identifier
$ ./identifier
Enter an identifier: count_1
Valid Identifier

Test 2: Invalid Identifier
$ ./identifier
Enter an identifier: 1count
Invalid Identifier
*/
