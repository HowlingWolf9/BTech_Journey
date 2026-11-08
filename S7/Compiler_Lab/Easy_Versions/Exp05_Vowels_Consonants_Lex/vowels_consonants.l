%{
/*
EXPERIMENT 05: LEX PROGRAM TO COUNT VOWELS AND CONSONANTS (EASY VERSION)

ALGORITHM:
1. Initialize integer counters: v = 0 (vowels), c = 0 (consonants).
2. Define Lex rules:
   - [aeiouAEIOU] : increment vowels (v).
   - [a-zA-Z]     : increment consonants (c).
   - '\n'         : return 0 to stop scanning on newline.
   - .            : ignore other characters.
3. In main(), prompt user, call yylex(), and print counts of vowels and consonants.
*/
#include <stdio.h>
int v = 0, c = 0;
%}

%option noyywrap

%%
[aeiouAEIOU]    { v++; }
[a-zA-Z]        { c++; }
\n              { return 0; }
.               ;
%%

int main() {
    printf("Enter string: ");
    yylex();
    printf("Vowels: %d\nConsonants: %d\n", v, c);
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex vowels_consonants.l
$ gcc lex.yy.c -o vowels_consonants
$ printf "Hello World\n" | ./vowels_consonants
Enter string: Vowels: 3
Consonants: 7
*/
