/*
EXPERIMENT 01: IMPLEMENTATION OF LEXICAL ANALYZER USING C

ALGORITHM:
1. Open the input source code file (e.g., "input.c") in read mode.
2. Read the source code character by character until EOF:
   a. If whitespace, tab, or newline is encountered, skip it.
   b. If '/' is followed by '/', skip characters until newline (single-line comment).
   c. If '/' is followed by '*', skip characters until '* /' (multi-line comment).
   d. If an alphabet or '_' is encountered, accumulate alphanumeric characters into a buffer:
      - Compare the buffer against known C keywords.
      - If matched, display as Keyword; otherwise, display as Identifier.
   e. If a digit is encountered, accumulate digits and optional decimal point into a buffer:
      - Display as Constant / Number.
   f. If an operator symbol (+, -, *, /, =, <, >, !) is encountered:
      - Check next character for two-character operators (==, <=, >=, !=); display as Operator.
   g. If a delimiter/special character (;, ,, (, ), {, }, [, ]) is encountered:
      - Display as Delimiter / Special Character.
3. Close the file and terminate.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

const char *keywords[] = {
    "auto", "break", "case", "char", "const", "continue", "default", "do",
    "double", "else", "enum", "extern", "float", "for", "goto", "if",
    "int", "long", "register", "return", "short", "signed", "sizeof", "static",
    "struct", "switch", "typedef", "union", "unsigned", "void", "volatile", "while"
};

int isKeyword(char *word) {
    int total = sizeof(keywords) / sizeof(keywords[0]);
    for (int i = 0; i < total; i++) {
        if (strcmp(word, keywords[i]) == 0)
            return 1;
    }
    return 0;
}

int isDelimiter(char ch) {
    return (ch == ';' || ch == ',' || ch == '(' || ch == ')' ||
            ch == '{' || ch == '}' || ch == '[' || ch == ']');
}

int isOperator(char ch) {
    return (ch == '+' || ch == '-' || ch == '*' || ch == '/' || ch == '%' ||
            ch == '=' || ch == '<' || ch == '>' || ch == '!');
}

int main(int argc, char *argv[]) {
    const char *filename = (argc > 1) ? argv[1] : "input.c";
    FILE *fp = fopen(filename, "r");

    if (fp == NULL) {
        printf("Error: Cannot open input file %s\n", filename);
        return 1;
    }

    printf("%-20s %-20s\n", "Lexeme", "Token");
    printf("----------------------------------------\n");

    int ch;
    while ((ch = fgetc(fp)) != EOF) {
        // Skip whitespace
        if (isspace(ch)) {
            continue;
        }

        // Handle comments
        if (ch == '/') {
            int next = fgetc(fp);
            if (next == '/') {
                while ((ch = fgetc(fp)) != EOF && ch != '\n');
                continue;
            } else if (next == '*') {
                int prev = 0;
                while ((ch = fgetc(fp)) != EOF) {
                    if (prev == '*' && ch == '/')
                        break;
                    prev = ch;
                }
                continue;
            } else {
                ungetc(next, fp);
            }
        }

        // Identifier or Keyword
        if (isalpha(ch) || ch == '_') {
            char buffer[64];
            int idx = 0;
            buffer[idx++] = (char)ch;
            while ((ch = fgetc(fp)) != EOF && (isalnum(ch) || ch == '_')) {
                if (idx < 63)
                    buffer[idx++] = (char)ch;
            }
            buffer[idx] = '\0';
            ungetc(ch, fp);

            if (isKeyword(buffer)) {
                printf("%-20s %-20s\n", buffer, "Keyword");
            } else {
                printf("%-20s %-20s\n", buffer, "Identifier");
            }
            continue;
        }

        // Numbers (Constants)
        if (isdigit(ch)) {
            char buffer[64];
            int idx = 0;
            buffer[idx++] = (char)ch;
            int hasDot = 0;
            while ((ch = fgetc(fp)) != EOF && (isdigit(ch) || (!hasDot && ch == '.'))) {
                if (ch == '.') hasDot = 1;
                if (idx < 63)
                    buffer[idx++] = (char)ch;
            }
            buffer[idx] = '\0';
            ungetc(ch, fp);
            printf("%-20s %-20s\n", buffer, "Constant");
            continue;
        }

        // Delimiters
        if (isDelimiter(ch)) {
            char str[2] = {(char)ch, '\0'};
            printf("%-20s %-20s\n", str, "Delimiter");
            continue;
        }

        // Operators
        if (isOperator(ch)) {
            int next = fgetc(fp);
            if ((ch == '=' && next == '=') ||
                (ch == '<' && next == '=') ||
                (ch == '>' && next == '=') ||
                (ch == '!' && next == '=')) {
                char op[3] = {(char)ch, (char)next, '\0'};
                printf("%-20s %-20s\n", op, "Operator");
            } else {
                ungetc(next, fp);
                char op[2] = {(char)ch, '\0'};
                printf("%-20s %-20s\n", op, "Operator");
            }
            continue;
        }
    }

    fclose(fp);
    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc lexical_analyzer.c -o lexical_analyzer
$ ./lexical_analyzer input.c
Lexeme               Token               
----------------------------------------
int                  Keyword             
main                 Identifier          
(                    Delimiter           
)                    Delimiter           
{                    Delimiter           
int                  Keyword             
a                    Identifier          
=                    Operator            
10                   Constant            
;                    Delimiter           
float                Keyword             
b                    Identifier          
=                    Operator            
20.5                 Constant            
;                    Delimiter           
if                   Keyword             
(                    Delimiter           
a                    Identifier          
<                    Operator            
b                    Identifier          
)                    Delimiter           
{                    Delimiter           
a                    Identifier          
=                    Operator            
a                    Identifier          
+                    Operator            
1                    Constant            
;                    Delimiter           
}                    Delimiter           
return               Keyword             
0                    Constant            
;                    Delimiter           
}                    Delimiter           
*/
