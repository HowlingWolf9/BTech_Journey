%{
/*
SET 1 - PROGRAM 01: LEX PROGRAM TO RECOGNIZE SIMPLE OR COMPOUND SENTENCE (EASY VERSION)

ALGORITHM:
1. Initialize integer flag compound = 0.
2. Define Lex rules:
   - Match coordinating conjunctions ("and", "but", "or", "so", "yet", "for", "nor").
   - Set compound = 1 when a conjunction is matched.
   - On newline '\n', return 0 to end scanning.
   - Ignore other characters.
3. In main(), prompt user, call yylex(), and display "Compound Sentence" or "Simple Sentence".
*/
#include <stdio.h>
int compound = 0;
%}

%option noyywrap

%%
[aA][nN][dD]|[bB][uU][tT]|[oO][rR]|[sS][oO]|[yY][eE][tT]|[fF][oO][rR]|[nN][oO][rR] { compound = 1; }
\n      { return 0; }
.       ;
%%

int main(void) {
    printf("Enter sentence: ");
    yylex();
    puts(compound ? "Compound Sentence" : "Simple Sentence");
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
$ printf "The quick brown fox jumps\n" | ./simple_compound
Enter sentence: Simple Sentence
*/
