%{
/*
SET 1 - PROGRAM 01: LEX PROGRAM TO RECOGNIZE SIMPLE OR COMPOUND SENTENCE

ALGORITHM:
1. Initialize integer counters/flags `is_compound = 0` and `word_count = 0`.
2. Define Lex regular expressions:
   - Match alphabetic words using `[a-zA-Z]+`.
   - Increment `word_count`.
   - Compare each word (case-insensitively) against coordinating conjunctions:
     "and", "but", "or", "so", "yet", "for", "nor".
   - If a match is found, set `is_compound = 1`.
   - On newline `\n`, return 0 to finish processing the input sentence.
   - Ignore any punctuation or whitespace using `.`.
3. In `main()`:
   - Prompt the user to enter a sentence.
   - Invoke `yylex()` to tokenize and analyze the sentence.
   - If `word_count == 0`, output "No sentence entered."
   - Else if `is_compound` is non-zero, output "Compound Sentence".
   - Otherwise, output "Simple Sentence".
*/

#include <stdio.h>
#include <string.h>
#include <strings.h>

int is_compound = 0;
int word_count = 0;

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
[a-zA-Z]+   {
                word_count++;
                if (strcasecmp(yytext, "and") == 0 ||
                    strcasecmp(yytext, "but") == 0 ||
                    strcasecmp(yytext, "or") == 0  ||
                    strcasecmp(yytext, "so") == 0  ||
                    strcasecmp(yytext, "yet") == 0 ||
                    strcasecmp(yytext, "for") == 0 ||
                    strcasecmp(yytext, "nor") == 0) {
                    is_compound = 1;
                }
            }
\n          { return 0; }
.           ;
%%

int main(void) {
    printf("Enter a sentence: ");
    yylex();

    if (word_count == 0) {
        printf("Result: No sentence entered.\n");
    } else if (is_compound) {
        printf("Result: The given sentence is a COMPOUND sentence.\n");
    } else {
        printf("Result: The given sentence is a SIMPLE sentence.\n");
    }

    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex simple_compound.l
$ gcc lex.yy.c -o simple_compound
$ ./simple_compound
Enter a sentence: I like apples but I prefer oranges.
Result: The given sentence is a COMPOUND sentence.

$ ./simple_compound
Enter a sentence: The cat slept on the mat.
Result: The given sentence is a SIMPLE sentence.

$ ./simple_compound
Enter a sentence: 
Result: No sentence entered.
*/
