/*
EXPERIMENT 15: INTERMEDIATE CODE GENERATION (EASY VERSION)

ALGORITHM:
1. Read an assignment statement of the form LHS = RHS (e.g. x = a + b * c).
2. Split statement into LHS and RHS at '='.
3. Convert the RHS infix expression to postfix using an operator stack:
   - Operators '*' and '/' have higher precedence (2) than '+' and '-' (1).
4. Evaluate the postfix expression using an operand stack:
   - Push operands onto the stack.
   - For each operator, pop two operands, allocate temporary variable t1, t2, ...,
     emit TAC instruction, record quadruple (op, arg1, arg2, res), and push result.
5. Emit final assignment LHS = top of stack, and record in quadruple table.
6. Display the Three Address Code and Quadruple Table.
*/

#include <stdio.h>
#include <string.h>
#include <ctype.h>

struct Quad {
    char op[5];
    char a1[10];
    char a2[10];
    char res[10];
} q[50];

int qcnt = 0;

int prec(char c) {
    if (c == '+' || c == '-') {
        return 1;
    }
    if (c == '*' || c == '/') {
        return 2;
    }
    return 0;
}

int main(void) {
    char in[100], lhs[20], rhs[100], post[100];
    printf("Enter expression (e.g. x = a + b * c): ");
    scanf(" %[^\n]", in);

    char *eq = strchr(in, '=');
    *eq = '\0';
    sscanf(in, "%s", lhs);
    strcpy(rhs, eq + 1);

    char stk[100];
    int top = -1;
    int k = 0;

    for (int i = 0; rhs[i]; i++) {
        char c = rhs[i];
        if (isspace(c)) {
            continue;
        }

        if (isalnum(c)) {
            post[k++] = c;
        } else if (c == '(') {
            stk[++top] = c;
        } else if (c == ')') {
            while (top >= 0 && stk[top] != '(') {
                post[k++] = stk[top--];
            }
            top--;
        } else {
            while (top >= 0 && prec(stk[top]) >= prec(c)) {
                post[k++] = stk[top--];
            }
            stk[++top] = c;
        }
    }
    while (top >= 0) {
        post[k++] = stk[top--];
    }
    post[k] = '\0';

    printf("\n--- Three Address Code (TAC) ---\n");
    char ostk[50][10];
    int otop = -1;
    int t = 1;

    for (int i = 0; post[i]; i++) {
        char c = post[i];
        if (isalnum(c)) {
            sprintf(ostk[++otop], "%c", c);
        } else {
            char *op2 = ostk[otop--];
            char *op1 = ostk[otop--];
            char tmp[10];
            sprintf(tmp, "t%d", t++);
            printf("%s = %s %c %s\n", tmp, op1, c, op2);

            sprintf(q[qcnt].op, "%c", c);
            strcpy(q[qcnt].a1, op1);
            strcpy(q[qcnt].a2, op2);
            strcpy(q[qcnt++].res, tmp);
            strcpy(ostk[++otop], tmp);
        }
    }

    printf("%s = %s\n", lhs, ostk[otop]);
    strcpy(q[qcnt].op, "=");
    strcpy(q[qcnt].a1, ostk[otop]);
    strcpy(q[qcnt].a2, "-");
    strcpy(q[qcnt++].res, lhs);

    printf("\n--- Quadruple Table ---\n");
    printf("%-6s %-10s %-10s %-10s %-10s\n", "Index", "Operator", "Argument 1", "Argument 2", "Result");
    printf("----------------------------------------------------\n");
    for (int i = 0; i < qcnt; i++) {
        printf("%-6d %-10s %-10s %-10s %-10s\n", i, q[i].op, q[i].a1, q[i].a2, q[i].res);
    }
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc intermediate_code_gen.c -o intermediate_code_gen
$ printf "x = a + b * c\n" | ./intermediate_code_gen
Enter expression (e.g. x = a + b * c): 
--- Three Address Code (TAC) ---
t1 = b * c
t2 = a + t1
x = t2

--- Quadruple Table ---
Index  Operator   Argument 1 Argument 2 Result    
----------------------------------------------------
0      *          b          c          t1        
1      +          a          t1         t2        
2      =          t2         -          x         
*/
