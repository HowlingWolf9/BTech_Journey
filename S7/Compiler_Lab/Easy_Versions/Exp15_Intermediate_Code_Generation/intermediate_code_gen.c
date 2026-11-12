/*
EXPERIMENT 15: INTERMEDIATE CODE GENERATION (EASY VERSION)

ALGORITHM:
1. Read an assignment statement into lhs and rhs via scanf scansets (e.g. x = a + b * c).
2. Convert rhs from infix to postfix using operator stack stk[] and prec():
   - '*' and '/' have precedence 2; '+' and '-' have precedence 1; others 0.
3. Evaluate postfix using operand stack ostk[][] and temporary counter t = 1:
   - For an operand, push its character string onto ostk[].
   - For an operator, pop op2 and op1 from ostk[], print "t<t> = <op1> <op> <op2>",
     and push "t<t>" onto ostk[] while incrementing t.
4. Print the final assignment "<lhs> = <ostk[otop]>".
*/

#include <stdio.h>
#include <ctype.h>

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
    char ostk[50][16];
    int otop = -1, t = 1;

    for (int i = 0; post[i]; i++) {
        char c = post[i];
        if (isalnum((unsigned char)c)) {
            sprintf(ostk[++otop], "%c", c);
        } else {
            char *op2 = ostk[otop--];
            char *op1 = ostk[otop--];
            printf("t%d = %s %c %s\n", t, op1, c, op2);
            sprintf(ostk[++otop], "t%d", t++);
        }
    }

    printf("%s = %s\n", lhs, ostk[otop]);
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
*/
