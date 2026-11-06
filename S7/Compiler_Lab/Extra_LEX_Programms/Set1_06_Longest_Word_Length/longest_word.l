%{
/*
SET 1 - PROGRAM 06: LEX PROGRAM TO FIND THE LENGTH OF THE LONGEST WORD

ALGORITHM:
1. Initialize `max_len = 0` and a buffer `longest_word[256]` initialized to empty.
2. Define Lex regular expressions:
   - Match words using `[a-zA-Z]+`.
   - If `yyleng > max_len`:
     - Update `max_len = yyleng`.
     - Copy `yytext` into `longest_word`.
   - On newline `\n`, return 0 to finish processing the string.
   - Ignore single characters/spaces.
3. In `main()`:
   - Prompt the user to enter a string.
   - Call `yylex()`.
   - Print the longest word and its length.
*/

#include <stdio.h>
#include <string.h>

int max_len = 0;
char longest_word[256] = "";

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
[a-zA-Z]+   {
                if (yyleng > max_len) {
                    max_len = yyleng;
                    strncpy(longest_word, yytext, sizeof(longest_word) - 1);
                    longest_word[sizeof(longest_word) - 1] = '\0';
                }
            }
\n          { return 0; }
.           ;
%%

int main(void) {
    printf("Enter a string: ");
    yylex();

    if (max_len > 0) {
        printf("Longest word : %s\n", longest_word);
        printf("Length       : %d\n", max_len);
    } else {
        printf("No words found.\n");
    }

    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex longest_word.l
$ gcc lex.yy.c -o longest_word
$ ./longest_word
Enter a string: Natural language processing and compiler optimization
Longest word : optimization
Length       : 12
*/
