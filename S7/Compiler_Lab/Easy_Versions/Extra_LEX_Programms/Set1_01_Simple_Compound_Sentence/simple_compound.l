%{
/*
SET 1 - PROGRAM 01: LEX PROGRAM TO RECOGNIZE SIMPLE OR COMPOUND SENTENCE (EASY VERSION)

ALGORITHM:
1. Initialize integer flag compound = 0.
2. Define Lex rules:
   - [a-zA-Z]+ : Match each whole word and compare case-insensitively with coordinating
     conjunctions ("and", "but", "or", "so", "yet", "for", "nor").
   - If a conjunction is matched, set compound = 1.
   - On newline '\n', return 0 to stop scanning.
   - Ignore other characters.
3. In main(), prompt user, invoke yylex(), and display "Compound Sentence" or "Simple Sentence".
*/
#include <stdio.h>
#include <string.h>
int compound = 0;
%}

%option noyywrap

%%
[a-zA-Z]+   {
    char *c[] = {"and", "but", "or", "so", "yet", "for", "nor", NULL};
    for (int i = 0; c[i]; i++) {
        if (!strcasecmp(yytext, c[i])) {
            compound = 1;
        }
    }
}
\n          { return 0; }
.           ;
%%

int main(void) {
    printf("Enter sentence: ");
    yylex();

    if (compound) {
        printf("Compound Sentence\n");
    } else {
        printf("Simple Sentence\n");
    }
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex simple_compound.l
$ gcc lex.yy.c -o simple_compound

Test 1: Compound sentence
$ printf "I went to the store and I bought milk\n" | ./simple_compound
Enter sentence: Compound Sentence

Test 2: Simple sentence
$ printf "The forest is green\n" | ./simple_compound
Enter sentence: Simple Sentence
*/
