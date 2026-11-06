/*
EXPERIMENT 15: INTERMEDIATE CODE GENERATION

ALGORITHM:
1. Read an assignment statement of the form `LHS = RHS` (e.g., `x = a + b * c` or `w = (a + b) * (c - d)`).
2. Convert the RHS infix expression into postfix notation using an operator stack:
   - Operators have standard precedence: '*' and '/' have precedence 2; '+' and '-' have precedence 1.
   - '(' has lowest precedence inside stack.
3. Process the postfix expression using an operand stack:
   - If an operand (identifier or number) is encountered, push it onto the stack.
   - If an operator `op` is encountered:
     * Pop operand2 and operand1 from stack.
     * Generate a new temporary variable `t1`, `t2`, etc.
     * Emit Three-Address Code: `t = operand1 op operand2`.
     * Push `t` back onto the operand stack.
4. After postfix traversal, pop the final result from the stack and emit: `LHS = final_result`.
5. Display the generated Three Address Code (TAC) and the corresponding Quadruple table.
*/

#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAX 100

struct Quadruple {
    char op[5];
    char arg1[10];
    char arg2[10];
    char res[10];
};

struct Quadruple quads[MAX];
int quadCount = 0;

int precedence(char op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    return 0;
}

void infixToPostfix(const char *infix, char *postfix) {
    char stack[MAX];
    int top = -1;
    int k = 0;

    for (int i = 0; infix[i] != '\0'; i++) {
        char ch = infix[i];
        if (isspace(ch)) continue;

        if (isalnum(ch)) {
            postfix[k++] = ch;
        } else if (ch == '(') {
            stack[++top] = ch;
        } else if (ch == ')') {
            while (top >= 0 && stack[top] != '(') {
                postfix[k++] = stack[top--];
            }
            if (top >= 0 && stack[top] == '(') {
                top--; // pop '('
            }
        } else if (ch == '+' || ch == '-' || ch == '*' || ch == '/') {
            while (top >= 0 && precedence(stack[top]) >= precedence(ch)) {
                postfix[k++] = stack[top--];
            }
            stack[++top] = ch;
        }
    }

    while (top >= 0) {
        postfix[k++] = stack[top--];
    }
    postfix[k] = '\0';
}

void generateTAC(const char *lhs, const char *postfix) {
    char stack[MAX][10];
    int top = -1;
    int tempCount = 1;

    for (int i = 0; postfix[i] != '\0'; i++) {
        char ch = postfix[i];

        if (isalnum(ch)) {
            char opStr[2] = {ch, '\0'};
            strcpy(stack[++top], opStr);
        } else if (ch == '+' || ch == '-' || ch == '*' || ch == '/') {
            char op2[10], op1[10], temp[10];
            strcpy(op2, stack[top--]);
            strcpy(op1, stack[top--]);

            sprintf(temp, "t%d", tempCount++);
            printf("%s = %s %c %s\n", temp, op1, ch, op2);

            // Record quadruple
            char opStr[2] = {ch, '\0'};
            strcpy(quads[quadCount].op, opStr);
            strcpy(quads[quadCount].arg1, op1);
            strcpy(quads[quadCount].arg2, op2);
            strcpy(quads[quadCount].res, temp);
            quadCount++;

            strcpy(stack[++top], temp);
        }
    }

    if (top >= 0) {
        printf("%s = %s\n", lhs, stack[top]);

        strcpy(quads[quadCount].op, "=");
        strcpy(quads[quadCount].arg1, stack[top]);
        strcpy(quads[quadCount].arg2, "-");
        strcpy(quads[quadCount].res, lhs);
        quadCount++;
    }
}

int main(void) {
    char input[MAX];
    char lhs[MAX], rhs[MAX], postfix[MAX];

    printf("Enter expression (e.g. x = a + b * c or w = (a + b) * (c - d)): ");
    if (scanf(" %[^\n]", input) != 1) {
        printf("Error reading input.\n");
        return 1;
    }

    char *eq = strchr(input, '=');
    if (!eq) {
        printf("Invalid assignment format. Missing '='\n");
        return 1;
    }

    // Split LHS and RHS
    *eq = '\0';
    sscanf(input, "%s", lhs);
    strcpy(rhs, eq + 1);

    infixToPostfix(rhs, postfix);

    printf("\n--- Intermediate Three Address Code (TAC) ---\n");
    generateTAC(lhs, postfix);

    printf("\n--- Quadruple Table ---\n");
    printf("%-6s %-10s %-10s %-10s %-10s\n", "Index", "Operator", "Argument 1", "Argument 2", "Result");
    printf("----------------------------------------------------\n");
    for (int i = 0; i < quadCount; i++) {
        printf("%-6d %-10s %-10s %-10s %-10s\n", i, quads[i].op, quads[i].arg1, quads[i].arg2, quads[i].res);
    }

    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc intermediate_code_gen.c -o intermediate_code_gen

Test 1: Precedence x = a + b * c
$ ./intermediate_code_gen
Enter expression (e.g. x = a + b * c or w = (a + b) * (c - d)): x = a + b * c

--- Intermediate Three Address Code (TAC) ---
t1 = b * c
t2 = a + t1
x = t2

--- Quadruple Table ---
Index  Operator   Argument 1 Argument 2 Result    
----------------------------------------------------
0      *          b          c          t1        
1      +          a          t1         t2        
2      =          t2         -          x         

Test 2: Parentheses w = (a + b) * (c - d)
$ ./intermediate_code_gen
Enter expression (e.g. x = a + b * c or w = (a + b) * (c - d)): w = (a + b) * (c - d)

--- Intermediate Three Address Code (TAC) ---
t1 = a + b
t2 = c - d
t3 = t1 * t2
w = t3

--- Quadruple Table ---
Index  Operator   Argument 1 Argument 2 Result    
----------------------------------------------------
0      +          a          b          t1        
1      -          c          d          t2        
2      *          t1         t2         t3        
3      =          t3         -          w         
*/
