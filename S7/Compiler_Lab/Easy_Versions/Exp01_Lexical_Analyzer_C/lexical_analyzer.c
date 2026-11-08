/*
EXPERIMENT 01: IMPLEMENTATION OF LEXICAL ANALYZER USING C (EASY VERSION)

ALGORITHM:
1. Open the source file "input.c" in read mode.
2. Read characters one by one until EOF:
   a. If whitespace, ignore and continue.
   b. If an alphabet or '_', accumulate characters into buffer:
      - Match against standard C keyword string using strstr().
      - If matched, display as Keyword; otherwise as Identifier.
   c. If a digit, accumulate consecutive digits into buffer and display as Constant.
   d. If character is found in +, -, *, /, =, <, >, display as Operator.
   e. If character matches ";,(){}", display as Delimiter.
3. Close the input file and terminate.
*/

#include <stdio.h>
#include <string.h>
#include <ctype.h>

int main(void) {
    FILE *fp = fopen("input.c", "r");
    char buf[50], t[55];
    int c;
    printf("%-15s %s\n------------------------------\n", "Lexeme", "Token");
    while ((c = fgetc(fp)) != EOF) {
        if (isspace(c)) continue;
        if (isalpha(c) || c == '_') {
            int i = 0;
            for (buf[i++] = c; isalnum(c = fgetc(fp)) || c == '_'; ) buf[i++] = c;
            buf[i] = 0; ungetc(c, fp);
            sprintf(t, " %s ", buf);
            printf("%-15s %s\n", buf, strstr(" int float char if else while return void ", t) ? "Keyword" : "Identifier");
        } else if (isdigit(c)) {
            int i = 0;
            for (buf[i++] = c; isdigit(c = fgetc(fp)); ) buf[i++] = c;
            buf[i] = 0; ungetc(c, fp);
            printf("%-15s Constant\n", buf);
        } else if (strchr("+-*/=<>", c)) printf("%-15c Operator\n", c);
        else if (strchr(";,(){}", c)) printf("%-15c Delimiter\n", c);
    }
    fclose(fp);
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc lexical_analyzer.c -o lexical_analyzer
$ ./lexical_analyzer
Lexeme          Token
------------------------------
int             Keyword
a               Identifier
=               Operator
10              Constant
;               Delimiter
if              Keyword
(               Delimiter
a               Identifier
>               Operator
5               Constant
)               Delimiter
return          Keyword
a               Identifier
;               Delimiter
*/
