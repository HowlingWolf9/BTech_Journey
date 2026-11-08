%{
/*
SET 2 - PROGRAM 06: LEX PROGRAM FOR PASSWORD VALIDATION (EASY VERSION)

ALGORITHM:
1. Define Lex regular expression to match password: [^\n]+.
2. In the rule action:
   - Check password criteria:
     * Length must be >= 8.
     * Must contain at least one uppercase letter (isupper).
     * Must contain at least one lowercase letter (islower).
     * Must contain at least one digit (isdigit).
   - If all conditions are satisfied, print "Valid Password"; otherwise print "Invalid Password".
   - Return 0 to stop scanning.
3. In main(), prompt user for password, call yylex(), and terminate.
*/
#include <stdio.h>
#include <ctype.h>
%}

%option noyywrap

%%
[^\n]+  {
    int u = 0, l = 0, d = 0;
    for (int i = 0; yytext[i]; i++) {
        if (isupper(yytext[i])) u = 1;
        if (islower(yytext[i])) l = 1;
        if (isdigit(yytext[i])) d = 1;
    }
    puts(yyleng >= 8 && u && l && d ? "Valid Password" : "Invalid Password");
    return 0;
}
\n|.    ;
%%

int main(void) {
    printf("Enter password: ");
    yylex();
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex password_validation.l
$ gcc lex.yy.c -o password_validation

Test 1: Valid password
$ printf "Secret123\n" | ./password_validation
Enter password: Valid Password

Test 2: Invalid password (too short / no uppercase)
$ printf "pass1\n" | ./password_validation
Enter password: Invalid Password
*/
