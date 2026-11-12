/*
EXPERIMENT 14: CONSTANT PROPAGATION (EASY VERSION)

ALGORITHM:
1. Maintain a struct table s[20] storing each statement's LHS variable (k),
   known constant value string (v), and formatted output line (out).
2. Read n Three-Address Code statements of the form LHS = RHS:
   - Simple assignments (lhs = op1) or binary expressions (lhs = op1 op op2).
3. For each statement i:
   a. Scan earlier entries j < i: propagate any known constant s[j].v into op1/op2,
      and clear s[j].v if s[i].k redefines s[j].k.
   b. If a binary expression has two integer operands, fold the arithmetic result
      into op1 and reduce the statement to a simple assignment.
   c. If the RHS of a simple assignment is an integer constant, store it in s[i].v;
      format the optimized statement into s[i].out.
4. Display all optimized statements s[i].out.
*/

#include <stdio.h>
#include <string.h>

int main(void) {
    struct {
        char k[10], v[16], out[50];
    } s[20];
    int n;

    printf("Enter number of statements: ");
    scanf("%d", &n);
    printf("Enter TAC statements (e.g. a = 5, c = a + b):\n");

    for (int i = 0; i < n; i++) {
        char line[50], op1[16] = "", op2[16] = "", op = 0;
        *s[i].k = *s[i].v = *s[i].out = 0;
        scanf(" %[^\n]", line);

        int tok = sscanf(line, "%s = %s %c %s", s[i].k, op1, &op, op2);
        if (tok == 2 || tok == 4) {
            for (int j = 0; j < i; j++) {
                if (*s[j].v) {
                    if (!strcmp(op1, s[j].k)) {
                        strcpy(op1, s[j].v);
                    }
                    if (!strcmp(op2, s[j].k)) {
                        strcpy(op2, s[j].v);
                    }
                }
                if (!strcmp(s[i].k, s[j].k)) {
                    *s[j].v = 0;
                }
            }

            int v1 = 0, v2 = 0;
            if (tok == 4 && sscanf(op1, "%d", &v1) == 1 &&
                sscanf(op2, "%d", &v2) == 1) {
                int ans = 0;
                if (op == '+') {
                    ans = v1 + v2;
                } else if (op == '-') {
                    ans = v1 - v2;
                } else if (op == '*') {
                    ans = v1 * v2;
                } else if (op == '/' && v2 != 0) {
                    ans = v1 / v2;
                }
                sprintf(op1, "%d", ans);
                tok = 2;
            }

            if (tok == 2) {
                if (sscanf(op1, "%d", &v1) == 1) {
                    strcpy(s[i].v, op1);
                }
                sprintf(line, "%s = %s", s[i].k, op1);
            } else {
                sprintf(line, "%s = %s %c %s", s[i].k, op1, op, op2);
            }
            strcpy(s[i].out, line);
        }
    }

    printf("\n--- Optimized Code (Constant Propagation & Folding) ---\n");
    for (int i = 0; i < n; i++) {
        printf("%s\n", s[i].out);
    }
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc constant_propagation.c -o constant_propagation
$ ./constant_propagation
Enter number of statements: 5
Enter TAC statements (e.g. a = 5, c = a + b):
a = 5
b = 10
c = a + b
d = c * 2
e = d + x

--- Optimized Code (Constant Propagation & Folding) ---
a = 5
b = 10
c = 15
d = 30
e = 30 + x
*/
