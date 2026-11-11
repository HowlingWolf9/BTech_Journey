/*
EXPERIMENT 13: SHIFT REDUCE PARSER (EASY VERSION)

ALGORITHM:
1. Define the grammar:
   E -> E + E
   E -> E * E
   E -> ( E )
   E -> i
2. Initialize stack with "$" and append "$" to input string.
3. In a loop:
   a. Check for reduction conditions on the stack top:
      - If top matches 'i', reduce to 'E'.
      - If top matches "(E)", reduce to 'E'.
      - If top matches "E*E", reduce to 'E'.
      - If top matches "E+E" and next input symbol is not '*', reduce to 'E'.
   b. If reduction occurs, print stack, input, and "Reduce: ...", then continue.
   c. If no reduction:
      - If stack is "$E" and input is "$", print "ACCEPT" and terminate.
      - If input is "$", print "REJECT" and terminate.
      - Otherwise, SHIFT next input symbol onto stack and print "SHIFT".
*/

#include <stdio.h>
#include <string.h>

char s[50] = "$", in[50];
int ip = 0;

void print(const char *act) {
    printf("%-15s %-15s %s\n", s, in + ip, act);
}

int main(void) {
    printf("Enter input string (e.g. i+i*i): ");
    scanf("%s", in);
    strcat(in, "$");

    printf("\n%-15s %-15s %s\n", "Stack", "Input", "Action");
    printf("--------------------------------------------\n");

    while (1) {
        int len = strlen(s);
        char *top3 = s + (len >= 3 ? len - 3 : 0);

        if (s[len - 1] == 'i') {
            s[len - 1] = 'E';
            print("Reduce: E -> i");
        } else if (!strcmp(top3, "(E)") || !strcmp(top3, "E*E") ||
                   (!strcmp(top3, "E+E") && in[ip] != '*')) {
            char act[20];
            sprintf(act, "Reduce: E -> %.3s", top3);
            strcpy(top3, "E");
            print(act);
        } else if (!strcmp(s, "$E") && in[ip] == '$') {
            print("ACCEPT");
            break;
        } else if (in[ip] == '$') {
            printf("REJECT\n");
            break;
        } else {
            strncat(s, in + ip++, 1);
            print("SHIFT");
        }
    }
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc shift_reduce_parser.c -o shift_reduce_parser
$ printf "i+i*i\n" | ./shift_reduce_parser
Enter input string (e.g. i+i*i): 
Stack           Input           Action
--------------------------------------------
$i              +i*i$           SHIFT
$E              +i*i$           Reduce: E -> i
$E+             i*i$            SHIFT
$E+i            *i$             SHIFT
$E+E            *i$             Reduce: E -> i
$E+E*           i$              SHIFT
$E+E*i          $               SHIFT
$E+E*E          $               Reduce: E -> i
$E+E            $               Reduce: E -> E*E
$E              $               Reduce: E -> E+E
$E              $               ACCEPT
*/
