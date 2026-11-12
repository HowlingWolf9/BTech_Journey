/*
EXPERIMENT 13: SHIFT REDUCE PARSER (EASY VERSION)

ALGORITHM:
1. Store the 4 grammar reduction rules (rhs, len) in a struct table:
   {"i", 1}, {"(E)", 3}, {"E*E", 3}, {"E+E", 3}.
2. Initialize stack with "$" and append "$" to the input string.
3. In a loop:
   a. Check the rule table in order for a suffix matching the stack top,
      deferring "E+E" when the next input symbol is '*' for precedence.
   b. If a rule matches, replace the matched suffix on the stack with "E",
      print the Reduce action, and continue.
   c. If no reduction applies:
      - If stack is "$E" and input is "$", print "ACCEPT" and terminate.
      - If input is "$", print "REJECT" and terminate.
      - Otherwise, SHIFT the next input symbol onto the stack and print "SHIFT".
*/

#include <stdio.h>
#include <string.h>

char s[50] = "$", in[50];
int ip = 0;

void print(const char *act) {
    printf("%-15s %-15s %s\n", s, in + ip, act);
}

int main(void) {
    struct {
        const char *rhs;
        int len;
    } r[] = {{"i", 1}, {"(E)", 3}, {"E*E", 3}, {"E+E", 3}};

    printf("Enter input string (e.g. i+i*i): ");
    scanf("%s", in);
    strcat(in, "$");

    printf("\n%-15s %-15s %s\n", "Stack", "Input", "Action");
    printf("--------------------------------------------\n");

    while (1) {
        int l = (int)strlen(s), red = 0;

        for (int i = 0; i < 4 && !red; i++) {
            if (l >= r[i].len && !strcmp(s + l - r[i].len, r[i].rhs) &&
                !(i == 3 && in[ip] == '*')) {
                char act[20];
                strcpy(s + l - r[i].len, "E");
                sprintf(act, "Reduce: E -> %s", r[i].rhs);
                print(act);
                red = 1;
            }
        }
        if (red) {
            continue;
        }
        if (!strcmp(s, "$E") && in[ip] == '$') {
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
