%{
/*
SET 2 - PROGRAM 01: LEX PROGRAM TO CHECK WHETHER A WORD IS A PALINDROME (EASY VERSION)

ALGORITHM:
1. Define Lex regular expression to match a word: [a-zA-Z0-9]+.
2. In the rule action:
   - Initialize palindrome flag pal = 1.
   - Loop with two pointers i = 0 and j = yyleng - 1 moving towards each other.
   - If yytext[i] != yytext[j], set pal = 0.
   - Print whether the word is a palindrome.
   - Return 0 to finish scanning.
3. In main(), prompt user for a word, call yylex(), and terminate.
*/
#include <stdio.h>
#include <string.h>
%}

%option noyywrap

%%
[a-zA-Z0-9]+  {
    int pal = 1;
    for (int i = 0, j = yyleng - 1; i < j; i++, j--) if (yytext[i] != yytext[j]) pal = 0;
    printf("%s is %s\n", yytext, pal ? "a Palindrome" : "NOT a palindrome");
    return 0;
}
\n|.          ;
%%

int main(void) {
    printf("Enter word: ");
    yylex();
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex palindrome.l
$ gcc lex.yy.c -o palindrome

Test 1: Palindrome
$ printf "madam\n" | ./palindrome
Enter word: madam is a Palindrome

Test 2: Not a palindrome
$ printf "compiler\n" | ./palindrome
Enter word: compiler is NOT a palindrome
*/
