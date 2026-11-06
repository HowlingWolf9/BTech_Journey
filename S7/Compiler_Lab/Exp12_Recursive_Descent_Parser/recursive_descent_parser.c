/*
EXPERIMENT 12: RECURSIVE DESCENT PARSER

ALGORITHM:
1. Define the context-free grammar (without left recursion):
   E  -> T E'
   E' -> + T E' | epsilon
   T  -> F T'
   T' -> * F T' | epsilon
   F  -> ( E ) | i (identifier)
2. Implement a recursive function for each non-terminal (E, Eprime, T, Tprime, F):
   - E(): calls T(), then Eprime().
   - Eprime(): if next token is '+', consume it, call T(), then Eprime(); else return 1 (epsilon).
   - T(): calls F(), then Tprime().
   - Tprime(): if next token is '*', consume it, call F(), then Tprime(); else return 1 (epsilon).
   - F(): if next token is '(', consume it, call E(), check for matching ')'; else if token is 'i', consume it.
3. In main(), read input string, append '$' if not present, and call E().
4. If E() returns success and input pointer reaches '$' (or end), accept; else reject.
*/

#include <stdio.h>
#include <string.h>
#include <ctype.h>

char input[100];
int pos = 0;

int E(void);
int Eprime(void);
int T(void);
int Tprime(void);
int F(void);

int E(void) {
    if (T()) {
        if (Eprime())
            return 1;
    }
    return 0;
}

int Eprime(void) {
    if (input[pos] == '+') {
        pos++;
        if (T()) {
            if (Eprime())
                return 1;
        }
        return 0;
    }
    // Epsilon production
    return 1;
}

int T(void) {
    if (F()) {
        if (Tprime())
            return 1;
    }
    return 0;
}

int Tprime(void) {
    if (input[pos] == '*') {
        pos++;
        if (F()) {
            if (Tprime())
                return 1;
        }
        return 0;
    }
    // Epsilon production
    return 1;
}

int F(void) {
    if (input[pos] == '(') {
        pos++;
        if (E()) {
            if (input[pos] == ')') {
                pos++;
                return 1;
            }
        }
        return 0;
    } else if (input[pos] == 'i') {
        pos++;
        return 1;
    }
    return 0;
}

int main(void) {
    printf("Grammar:\n");
    printf("  E  -> T E'\n");
    printf("  E' -> + T E' | e\n");
    printf("  T  -> F T'\n");
    printf("  T' -> * F T' | e\n");
    printf("  F  -> ( E ) | i\n\n");

    printf("Enter input string (use 'i' for identifier, e.g. i+i*i): ");
    if (scanf("%s", input) != 1) {
        printf("Error reading input.\n");
        return 1;
    }

    int len = strlen(input);
    if (input[len - 1] != '$') {
        input[len] = '$';
        input[len + 1] = '\0';
    }

    pos = 0;
    if (E() && input[pos] == '$') {
        printf("String is Accepted (Successfully parsed)\n");
    } else {
        printf("String is Rejected (Syntax error)\n");
    }

    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc recursive_descent_parser.c -o recursive_descent_parser

Test 1: Valid string i+i*i
$ ./recursive_descent_parser
Enter input string (use 'i' for identifier, e.g. i+i*i): i+i*i
String is Accepted (Successfully parsed)

Test 2: Valid string with parentheses (i+i)*i
$ ./recursive_descent_parser
Enter input string (use 'i' for identifier, e.g. i+i*i): (i+i)*i
String is Accepted (Successfully parsed)

Test 3: Invalid string i++i
$ ./recursive_descent_parser
Enter input string (use 'i' for identifier, e.g. i+i*i): i++i
String is Rejected (Syntax error)
*/
