%{
/*
SET 2 - PROGRAM 06: LEX PROGRAM FOR PASSWORD VALIDATION

ALGORITHM:
1. Initialize integer flag `evaluated = 0`.
2. Define a helper function `check_password(pwd, len)`:
   - Initialize flags: `has_upper = 0`, `has_lower = 0`, `has_digit = 0`.
   - Iterate through characters up to `len`:
     - If character is uppercase (`isupper`), set `has_upper = 1`.
     - If character is lowercase (`islower`), set `has_lower = 1`.
     - If character is a digit (`isdigit`), set `has_digit = 1`.
   - Check requirements:
     a) Length >= 8
     b) `has_upper` == 1 && `has_lower` == 1
     c) `has_digit` == 1
   - If all conditions are met, report VALID password.
   - Otherwise, report INVALID password and indicate unmet conditions.
3. Define Lex regular expressions:
   - Match non-newline sequence `[^\r\n]+`, invoke `check_password(yytext, yyleng)`, set `evaluated = 1`, and return 0.
   - On newline `\n`: if `!evaluated`, validate empty string `check_password("", 0)`, set `evaluated = 1`, and return 0.
4. In `main()`:
   - Prompt user to enter a password.
   - Invoke `yylex()`.
   - If `!evaluated`, validate empty password `check_password("", 0)`.
*/

#include <stdio.h>
#include <ctype.h>
#include <string.h>

int evaluated = 0;

int yywrap(void) {
    return 1;
}

static void check_password(const char *pwd, int len) {
    int has_upper = 0;
    int has_lower = 0;
    int has_digit = 0;

    for (int i = 0; i < len; i++) {
        if (isupper((unsigned char)pwd[i])) has_upper = 1;
        if (islower((unsigned char)pwd[i])) has_lower = 1;
        if (isdigit((unsigned char)pwd[i])) has_digit = 1;
    }

    int valid = (len >= 8) && has_upper && has_lower && has_digit;

    if (valid) {
        printf("Result: Password is VALID.\n");
    } else {
        printf("Result: Password is INVALID.\n");
        printf("Reasons:\n");
        if (len < 8) {
            printf("  - Length is %d (must be at least 8 characters long)\n", len);
        }
        if (!has_upper) {
            printf("  - Missing at least one uppercase letter\n");
        }
        if (!has_lower) {
            printf("  - Missing at least one lowercase letter\n");
        }
        if (!has_digit) {
            printf("  - Missing at least one digit\n");
        }
    }
}
%}

%option noinput nounput

%%
[^\r\n]+    {
                evaluated = 1;
                check_password(yytext, yyleng);
                return 0;
            }
\n          {
                if (!evaluated) {
                    evaluated = 1;
                    check_password("", 0);
                    return 0;
                }
            }
.           ;
%%

int main(void) {
    printf("Enter password to validate: ");
    yylex();

    if (!evaluated) {
        check_password("", 0);
    }

    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ flex password_validation.l
$ gcc lex.yy.c -o password_validation
$ ./password_validation
Enter password to validate: Pass1234
Result: Password is VALID.

$ ./password_validation
Enter password to validate: pass
Result: Password is INVALID.
Reasons:
  - Length is 4 (must be at least 8 characters long)
  - Missing at least one uppercase letter
  - Missing at least one digit

$ ./password_validation
Enter password to validate: 
Result: Password is INVALID.
Reasons:
  - Length is 0 (must be at least 8 characters long)
  - Missing at least one uppercase letter
  - Missing at least one lowercase letter
  - Missing at least one digit
*/
