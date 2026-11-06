%{
/*
EXPERIMENT 05: LEX PROGRAM TO FIND NO OF VOWELS AND CONSONANTS

ALGORITHM:
1. Initialize integer counters: `vowels = 0` and `consonants = 0`.
2. Define regular expressions in Lex:
   - Match any vowel [aeiouAEIOU]: increment `vowels`.
   - Match any other English letter [a-zA-Z]: increment `consonants`.
   - Match any other character (digits, whitespace, punctuation): ignore.
3. In main():
   - Prompt user for input.
   - Call `yylex()` to scan input until EOF or newline.
   - Display the total count of vowels and consonants.
*/

#include <stdio.h>

int vowels = 0;
int consonants = 0;

int yywrap(void) {
    return 1;
}
%}

%option noinput nounput

%%
[aeiouAEIOU]    { vowels++; }
[a-zA-Z]        { consonants++; }
\n              { return 0; }
.               ;
%%

int main(void) {
    printf("Enter a string: ");
    yylex();

    printf("Number of vowels     : %d\n", vowels);
    printf("Number of consonants : %d\n", consonants);

    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ flex vowels_consonants.l
$ gcc lex.yy.c -o vowels_consonants
$ ./vowels_consonants
Enter a string: Hello World
Number of vowels     : 3
Number of consonants : 7
*/
