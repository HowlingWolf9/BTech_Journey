/*
EXPERIMENT 14: CONSTANT PROPAGATION

ALGORITHM:
1. Maintain a symbol table to track variables that have constant integer values:
   - Variable name
   - Constant value
   - Flag indicating whether it currently holds a constant
2. Read Three-Address Code (TAC) statements of the form `LHS = RHS`:
   - RHS may be a single operand (e.g., `a = 5`) or a binary expression (e.g., `c = a + b`).
3. For each statement:
   a. If an operand in RHS is a variable present in the symbol table with a known constant,
      substitute the variable with its constant value (Constant Propagation).
   b. If both operands of an operator (+, -, *, /) are constants:
      - Evaluate the expression at compile time (Constant Folding).
      - Replace the expression with the calculated result.
      - Update the symbol table for LHS with this new constant value.
   c. If RHS evaluates to a single constant:
      - Record LHS as a constant in the symbol table.
   d. Otherwise (if RHS contains non-constant variables):
      - Invalidate or remove LHS from the constant symbol table.
4. Display the original statements and the resulting optimized statements.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX 50

struct Statement {
    char lhs[10];
    char op1[10];
    char op;       // '\0' if simple assignment
    char op2[10];
    char resultStr[50];
};

struct ConstantTable {
    char var[10];
    int val;
    int isConst;
};

struct ConstantTable symTab[MAX];
int symCount = 0;

int isNumber(const char *str) {
    if (!str || !*str) return 0;
    int i = 0;
    if (str[0] == '-' || str[0] == '+') i++;
    if (!str[i]) return 0;
    while (str[i]) {
        if (!isdigit(str[i])) return 0;
        i++;
    }
    return 1;
}

int getConstant(const char *var, int *val) {
    for (int i = 0; i < symCount; i++) {
        if (strcmp(symTab[i].var, var) == 0 && symTab[i].isConst) {
            *val = symTab[i].val;
            return 1;
        }
    }
    return 0;
}

void setConstant(const char *var, int val) {
    for (int i = 0; i < symCount; i++) {
        if (strcmp(symTab[i].var, var) == 0) {
            symTab[i].val = val;
            symTab[i].isConst = 1;
            return;
        }
    }
    strcpy(symTab[symCount].var, var);
    symTab[symCount].val = val;
    symTab[symCount].isConst = 1;
    symCount++;
}

void invalidateConstant(const char *var) {
    for (int i = 0; i < symCount; i++) {
        if (strcmp(symTab[i].var, var) == 0) {
            symTab[i].isConst = 0;
            return;
        }
    }
}

int evaluate(int val1, char op, int val2) {
    switch (op) {
        case '+': return val1 + val2;
        case '-': return val1 - val2;
        case '*': return val1 * val2;
        case '/': return (val2 != 0) ? (val1 / val2) : 0;
        default: return 0;
    }
}

int main(void) {
    int n;
    struct Statement stmts[MAX];

    printf("Enter number of statements: ");
    if (scanf("%d", &n) != 1 || n <= 0) {
        printf("Invalid input.\n");
        return 1;
    }

    printf("Enter TAC statements (e.g. a = 5, c = a + b):\n");
    for (int i = 0; i < n; i++) {
        char line[100];
        scanf(" %[^\n]", line);

        char lhs[10], eq[5], rest[50];
        if (sscanf(line, "%s %s %[^\n]", lhs, eq, rest) >= 3) {
            strcpy(stmts[i].lhs, lhs);
            char op1[10], op2[10], op;
            if (sscanf(rest, "%s %c %s", op1, &op, op2) == 3) {
                strcpy(stmts[i].op1, op1);
                stmts[i].op = op;
                strcpy(stmts[i].op2, op2);
            } else {
                if (sscanf(rest, "%s", stmts[i].op1) != 1) {
                    stmts[i].op1[0] = '\0';
                }
                stmts[i].op = '\0';
                stmts[i].op2[0] = '\0';
            }
        }
    }

    // Perform Constant Propagation & Folding
    for (int i = 0; i < n; i++) {
        int v1 = 0, v2 = 0;
        int op1IsConst = 0, op2IsConst = 0;

        // Check op1
        if (isNumber(stmts[i].op1)) {
            v1 = atoi(stmts[i].op1);
            op1IsConst = 1;
        } else if (getConstant(stmts[i].op1, &v1)) {
            sprintf(stmts[i].op1, "%d", v1);
            op1IsConst = 1;
        }

        // Check op2 if binary operation
        if (stmts[i].op != '\0') {
            if (isNumber(stmts[i].op2)) {
                v2 = atoi(stmts[i].op2);
                op2IsConst = 1;
            } else if (getConstant(stmts[i].op2, &v2)) {
                sprintf(stmts[i].op2, "%d", v2);
                op2IsConst = 1;
            }

            char out[100];
            // If both operands are constant, fold the expression
            if (op1IsConst && op2IsConst) {
                int res = evaluate(v1, stmts[i].op, v2);
                setConstant(stmts[i].lhs, res);
                sprintf(out, "%s = %d", stmts[i].lhs, res);
            } else {
                invalidateConstant(stmts[i].lhs);
                sprintf(out, "%s = %s %c %s", stmts[i].lhs, stmts[i].op1, stmts[i].op, stmts[i].op2);
            }
            strcpy(stmts[i].resultStr, out);
        } else {
            // Simple assignment
            char out[100];
            if (op1IsConst) {
                setConstant(stmts[i].lhs, v1);
                sprintf(out, "%s = %d", stmts[i].lhs, v1);
            } else {
                invalidateConstant(stmts[i].lhs);
                sprintf(out, "%s = %s", stmts[i].lhs, stmts[i].op1);
            }
            strcpy(stmts[i].resultStr, out);
        }
    }

    printf("\n--- Optimized Code (After Constant Propagation & Folding) ---\n");
    for (int i = 0; i < n; i++) {
        printf("%s\n", stmts[i].resultStr);
    }

    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc constant_propagation.c -o constant_propagation

Test 1: Constant propagation with folding
$ ./constant_propagation
Enter number of statements: 4
Enter TAC statements (e.g. a = 5, c = a + b):
a = 5
b = 10
c = a + b
d = c * 2

--- Optimized Code (After Constant Propagation & Folding) ---
a = 5
b = 10
c = 15
d = 30

Test 2: Partial constant propagation with variables
$ ./constant_propagation
Enter number of statements: 3
Enter TAC statements (e.g. a = 5, c = a + b):
a = 5
b = x + a
c = b * 2

--- Optimized Code (After Constant Propagation & Folding) ---
a = 5
b = x + 5
c = b * 2
*/
