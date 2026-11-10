%{
/*
SET 1 - PROGRAM 04: LEX PROGRAM TO COUNT WORDS WITH LENGTH > 5 AND < 10 (EASY VERSION)

ALGORITHM:
1. Initialize counter c = 0.
2. Define Lex rules:
   - [a-zA-Z]+ : if yyleng > 5 and yyleng < 10, increment c and print word with its length.
   - '\n'      : return 0 to stop scanning on newline.
   - .         : ignore any other character.
3. In main(), prompt user, invoke yylex(), and print total count.
*/
#include <stdio.h>
int c = 0;
%}

%option noyywrap

%%
[a-zA-Z]+ {
    if (yyleng > 5 && yyleng < 10) {
        c++;
        printf("  Matched: \"%s\" (Length: %d)\n", yytext, yyleng);
    }
}
\n { return 0; }
.  ;
%%

int main(void) {
    printf("Enter a string: ");
    yylex();
    printf("Total words with 5 < length < 10: %d\n", c);
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex count_words_5_to_10.l
$ gcc lex.yy.c -o count_words_5_to_10
$ printf "Compiler design lab teaches students parsing techniques\n" | ./count_words_5_to_10
Enter a string:   Matched: "Compiler" (Length: 8)
  Matched: "design" (Length: 6)
  Matched: "teaches" (Length: 7)
  Matched: "students" (Length: 8)
  Matched: "parsing" (Length: 7)
Total words with 5 < length < 10: 5
*/
