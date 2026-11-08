/*
EXPERIMENT 12: RECURSIVE DESCENT PARSER (EASY VERSION)

ALGORITHM:
1. Define the grammar rules (without left recursion):
   E  -> T E'
   E' -> + T E' | epsilon
   T  -> F T'
   T' -> * F T' | epsilon
   F  -> ( E ) | i
2. Implement recursive functions for each non-terminal:
   - E(): calls T(), then Eprime().
   - Eprime(): if input[pos] == '+', pos++, calls T() and Eprime(); else returns 1 (epsilon).
   - T(): calls F(), then Tprime().
   - Tprime(): if input[pos] == '*', pos++, calls F() and Tprime(); else returns 1 (epsilon).
   - F(): if input[pos] == '(', pos++, calls E() and matches ')'; else matches 'i'.
3. In main(), read input string, invoke E(), and check if all input symbols are consumed.
4. Output "String is Accepted" if valid, else "String is Rejected".
*/

#include <stdio.h>

char in[50];
int pos = 0;

int E(void);
int Eprime(void);
int T(void);
int Tprime(void);
int F(void);

int E(void)      { return T() && Eprime(); }
int Eprime(void) { return in[pos] == '+' ? (pos++, T() && Eprime()) : 1; }
int T(void)      { return F() && Tprime(); }
int Tprime(void) { return in[pos] == '*' ? (pos++, F() && Tprime()) : 1; }
int F(void)      { return in[pos] == '(' ? (pos++, E() && in[pos++] == ')') : (in[pos] == 'i' ? (pos++, 1) : 0); }

int main(void) {
    printf("Enter input string (e.g. i+i*i): ");
    scanf("%s", in);
    puts(E() && !in[pos] ? "String is Accepted" : "String is Rejected");
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc recursive_descent_parser.c -o recursive_descent_parser

Test 1: Valid string
$ printf "i+i*i\n" | ./recursive_descent_parser
Enter input string (e.g. i+i*i): String is Accepted

Test 2: Invalid string
$ printf "i++i\n" | ./recursive_descent_parser
Enter input string (e.g. i+i*i): String is Rejected
*/
