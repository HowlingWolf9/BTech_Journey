/*
EXPERIMENT 14: CONSTANT PROPAGATION (EASY VERSION)

ALGORITHM:
1. Maintain a symbol table of variable names and their known constant values.
2. Read n Three-Address Code statements of the form LHS = RHS:
   - Statements can be simple assignments (lhs = op1) or binary expressions (lhs = op1 op op2).
3. For each statement:
   a. Look up op1 and op2 in the constant table; substitute if known (Constant Propagation).
   b. If both operands evaluate to constants, perform the operation at compile time (Constant Folding) and record LHS as a constant.
   c. If a single constant is assigned, record LHS as a constant.
   d. Otherwise, invalidate LHS in the constant table.
4. Display the resulting optimized statements.
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

char vars[20][10];
int vals[20], is_c[20], n_vars = 0;

int get_val(char *s, int *v) {
    if (isdigit(s[0]) || (s[0] == '-' && isdigit(s[1]))) {
        *v = atoi(s);
        return 1;
    }
    for (int i = 0; i < n_vars; i++) {
        if (!strcmp(vars[i], s) && is_c[i]) {
            *v = vals[i];
            return 1;
        }
    }
    return 0;
}

void set_val(char *s, int v, int c) {
    for (int i = 0; i < n_vars; i++) {
        if (!strcmp(vars[i], s)) {
            vals[i] = v;
            is_c[i] = c;
            return;
        }
    }
    strcpy(vars[n_vars], s);
    vals[n_vars] = v;
    is_c[n_vars++] = c;
}

int main(void) {
    int n;
    printf("Enter number of statements: ");
    scanf("%d", &n);
    printf("Enter TAC statements (e.g. a = 5, c = a + b):\n");

    char res[20][50];
    for (int i = 0; i < n; i++) {
        char line[50], lhs[10], op1[10], op2[10], op;
        scanf(" %[^\n]", line);

        if (sscanf(line, "%s = %s %c %s", lhs, op1, &op, op2) == 4) {
            int v1, v2;
            int c1 = get_val(op1, &v1);
            int c2 = get_val(op2, &v2);

            if (c1) {
                sprintf(op1, "%d", v1);
            }
            if (c2) {
                sprintf(op2, "%d", v2);
            }

            if (c1 && c2) {
                int ans = 0;
                if (op == '+') {
                    ans = v1 + v2;
                } else if (op == '-') {
                    ans = v1 - v2;
                } else if (op == '*') {
                    ans = v1 * v2;
                } else if (op == '/') {
                    ans = (v2 != 0) ? (v1 / v2) : 0;
                }

                set_val(lhs, ans, 1);
                sprintf(res[i], "%s = %d", lhs, ans);
            } else {
                set_val(lhs, 0, 0);
                sprintf(res[i], "%s = %s %c %s", lhs, op1, op, op2);
            }
        } else if (sscanf(line, "%s = %s", lhs, op1) == 2) {
            int v1;
            int c1 = get_val(op1, &v1);
            if (c1) {
                set_val(lhs, v1, 1);
                sprintf(res[i], "%s = %d", lhs, v1);
            } else {
                set_val(lhs, 0, 0);
                sprintf(res[i], "%s = %s", lhs, op1);
            }
        }
    }

    printf("\n--- Optimized Code (Constant Propagation & Folding) ---\n");
    for (int i = 0; i < n; i++) {
        printf("%s\n", res[i]);
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
