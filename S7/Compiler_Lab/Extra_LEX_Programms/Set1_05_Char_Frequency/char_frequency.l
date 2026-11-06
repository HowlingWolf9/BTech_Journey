%{
/*
SET 1 - PROGRAM 05: LEX PROGRAM TO COUNT THE FREQUENCY OF A CHARACTER

ALGORITHM:
1. Declare global variables: `target_char` and `frequency = 0`.
2. Define Lex regular expressions:
   - Match any single character `.` using the rule:
     If `yytext[0] == target_char`, increment `frequency`.
   - On newline `\n`, return 0 to stop scanning the sentence.
3. In `main()`:
   - Prompt the user to enter the target character.
   - Read the character and consume the remaining trailing newline.
   - Prompt the user to enter the sentence.
   - Call `yylex()`.
   - Display the total occurrences of `target_char`.
*/

#include <stdio.h>

char target_char;
int frequency = 0;

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
\n          { return 0; }
.           {
                if (yytext[0] == target_char) {
                    frequency++;
                }
            }
%%

int main(void) {
    int ch;
    printf("Enter the character to find: ");
    if (scanf(" %c", &target_char) != 1) {
        printf("Invalid character input.\n");
        return 1;
    }

    // Clear rest of the line from standard input
    while ((ch = getchar()) != '\n' && ch != EOF);

    printf("Enter the sentence: ");
    yylex();

    printf("Frequency of '%c' in the sentence: %d\n", target_char, frequency);
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex char_frequency.l
$ gcc lex.yy.c -o char_frequency
$ ./char_frequency
Enter the character to find: e
Enter the sentence: hello everyone everywhere
Frequency of 'e' in the sentence: 8
*/
