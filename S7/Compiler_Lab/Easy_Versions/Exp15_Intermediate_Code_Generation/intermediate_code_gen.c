/*
EXPERIMENT 15: INTERMEDIATE CODE GENERATION (EASY VERSION)

ALGORITHM:
1. Read an assignment statement into lhs and rhs via scanf scansets (e.g. x = a + b * c).
2. Convert rhs from infix to postfix using operator stack stk[] and prec():
   - '*' and '/' have precedence 2; '+' and '-' have precedence 1; others 0.
3. Evaluate postfix using token buffer tok[][] and operand pointer stack ostk[]:
   - For an operand, store it in tok[i] and push its pointer onto ostk[].
   - For an operator, build a struct Quad compound literal in q[qcnt] pointing to
     ostk[otop - 1] and ostk[otop], format t1, t2, ... into q[qcnt].res, print TAC,
     and push q[qcnt++].res onto ostk[].
4. Emit final assignment lhs = ostk[otop] and record ('=', ostk[otop], "-", lhs) in q[qcnt++].
5. Display the Quadruple Table from q[0..qcnt-1].
*/

#include <stdio.h>
#include <string.h>
#include <ctype.h>

struct Quad {
    char op, *a1, *a2, res[10];
} q[50];

int prec(char c) {
    return (c == '*' || c == '/') ? 2 : (c == '+' || c == '-');
}

int main(void) {
    char lhs[20], rhs[100], post[100], stk[100];
    int top = -1, k = 0;

    printf("Enter expression (e.g. x = a + b * c): ");
    scanf(" %[^= \t] = %[^\n]", lhs, rhs);

    for (int i = 0; rhs[i]; i++) {
        char c = rhs[i];
        if (isspace((unsigned char)c)) {
            continue;
        }
        if (isalnum((unsigned char)c)) {
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
    char tok[50][2] = {{0}}, *ostk[50];
    int otop = -1, qcnt = 0, t = 1;

    for (int i = 0; post[i]; i++) {
        char c = post[i];
        if (isalnum((unsigned char)c)) {
            tok[i][0] = c;
            ostk[++otop] = tok[i];
        } else {
            q[qcnt] = (struct Quad){c, ostk[otop - 1], ostk[otop], ""};
            sprintf(q[qcnt].res, "t%d", t++);
            printf("%s = %s %c %s\n", q[qcnt].res, q[qcnt].a1, c, q[qcnt].a2);
            ostk[--otop] = q[qcnt++].res;
        }
    }

    printf("%s = %s\n", lhs, ostk[otop]);
    q[qcnt] = (struct Quad){'=', ostk[otop], "-", ""};
    strcpy(q[qcnt++].res, lhs);

    printf("\n--- Quadruple Table ---\n");
    printf("%-6s %-10s %-10s %-10s %-10s\n", "Index", "Operator", "Argument 1", "Argument 2", "Result");
    printf("----------------------------------------------------\n");
    for (int i = 0; i < qcnt; i++) {
        printf("%-6d %-10c %-10s %-10s %-10s\n", i, q[i].op, q[i].a1, q[i].a2, q[i].res);
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
