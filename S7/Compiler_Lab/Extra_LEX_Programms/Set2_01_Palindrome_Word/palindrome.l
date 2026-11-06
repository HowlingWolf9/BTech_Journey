%{
/*
SET 2 - PROGRAM 01: LEX PROGRAM TO CHECK WHETHER A WORD IS A PALINDROME

ALGORITHM:
1. Initialize integer flag `matched = 0`.
2. Define a Lex rule matching any word using `[a-zA-Z0-9]+`.
3. When a word is matched:
   - Set `matched = 1`.
   - Initialize two indices: `left = 0`, `right = yyleng - 1`.
   - Flag `is_palindrome = 1`.
   - Compare characters at `left` and `right` (case-insensitively using `tolower`).
   - If any pair does not match, set `is_palindrome = 0` and break.
   - Advance `left` forward and `right` backward.
   - Display whether the word is a palindrome, and return 0.
4. On newline `\n`, return 0 to stop scanning.
5. In `main()`:
   - Prompt user to enter a word.
   - Invoke `yylex()`.
   - If `matched` is 0, print "No word entered."
*/

#include <stdio.h>
#include <ctype.h>
#include <string.h>

int matched = 0;

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
[a-zA-Z0-9]+    {
                    matched = 1;
                    int left = 0;
                    int right = yyleng - 1;
                    int is_palindrome = 1;

                    while (left < right) {
                        if (tolower((unsigned char)yytext[left]) != tolower((unsigned char)yytext[right])) {
                            is_palindrome = 0;
                            break;
                        }
                        left++;
                        right--;
                    }

                    if (is_palindrome) {
                        printf("Result: \"%s\" is a PALINDROME.\n", yytext);
                    } else {
                        printf("Result: \"%s\" is NOT a palindrome.\n", yytext);
                    }
                    return 0;
                }
\n              { return 0; }
[ \t]+          ;
.               ;
%%

int main(void) {
    printf("Enter a word: ");
    yylex();

    if (!matched) {
        printf("No word entered.\n");
    }

    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex palindrome.l
$ gcc lex.yy.c -o palindrome
$ ./palindrome
Enter a word: Madam
Result: "Madam" is a PALINDROME.

$ ./palindrome
Enter a word: Computer
Result: "Computer" is NOT a palindrome.

$ ./palindrome
Enter a word: 
No word entered.
*/
