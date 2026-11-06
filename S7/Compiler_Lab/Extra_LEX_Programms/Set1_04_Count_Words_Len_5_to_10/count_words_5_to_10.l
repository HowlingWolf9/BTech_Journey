%{
/*
SET 1 - PROGRAM 04: LEX PROGRAM TO COUNT WORDS WITH LENGTH > 5 AND < 10

ALGORITHM:
1. Initialize an integer counter `count = 0`.
2. Define Lex regular expressions:
   - Match alphabetic words using `[a-zA-Z]+`.
   - If `yyleng > 5 && yyleng < 10` (length 6, 7, 8, or 9):
     - Increment `count`.
     - Print the matching word and its length.
   - On newline `\n`, return 0 to end line scanning.
   - Ignore any punctuation or whitespace using `.`.
3. In `main()`:
   - Prompt the user to enter a string.
   - Call `yylex()`.
   - Display the total count of matched words.
*/

#include <stdio.h>

int count = 0;

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
[a-zA-Z]+   {
                if (yyleng > 5 && yyleng < 10) {
                    count++;
                    printf("  Matched: \"%s\" (Length: %d)\n", yytext, yyleng);
                }
            }
\n          { return 0; }
.           ;
%%

int main(void) {
    printf("Enter a string: ");
    yylex();

    printf("\nTotal words with 5 < length < 10: %d\n", count);
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex count_words_5_to_10.l
$ gcc lex.yy.c -o count_words_5_to_10
$ ./count_words_5_to_10
Enter a string: Compiler design laboratory teaches students parsing techniques
  Matched: "Compiler" (Length: 8)
  Matched: "design" (Length: 6)
  Matched: "teaches" (Length: 7)
  Matched: "students" (Length: 8)
  Matched: "parsing" (Length: 7)

Total words with 5 < length < 10: 5
*/
