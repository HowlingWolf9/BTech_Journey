/*
EXPERIMENT 16: TARGET CODE GENERATION

ALGORITHM:
1. Read the number of Three-Address Code (TAC) statements (n).
2. For each statement of the form `LHS = arg1 op arg2` or `LHS = arg1`:
   a. If the statement is a binary operation (`op` is +, -, *, /):
      - Emit instruction to load first operand into register: `MOV R0, arg1`.
      - Emit arithmetic instruction based on operator:
        * '+' -> `ADD R0, arg2`
        * '-' -> `SUB R0, arg2`
        * '*' -> `MUL R0, arg2`
        * '/' -> `DIV R0, arg2`
      - Emit instruction to store register result into LHS: `MOV LHS, R0`.
   b. If the statement is a simple assignment (`LHS = arg1`):
      - `MOV R0, arg1`
      - `MOV LHS, R0`
3. Display the generated target assembly instructions.
*/

#include <stdio.h>
#include <string.h>

#define MAX 50

struct TAC {
    char lhs[10];
    char arg1[10];
    char op;
    char arg2[10];
};

int main(void) {
    int n;
    struct TAC code[MAX];

    printf("Enter number of TAC statements: ");
    if (scanf("%d", &n) != 1 || n <= 0) {
        printf("Invalid input.\n");
        return 1;
    }

    printf("Enter TAC statements (e.g. t1 = b + c or a = t2):\n");
    for (int i = 0; i < n; i++) {
        char line[100];
        scanf(" %[^\n]", line);

        char lhs[10], eq[5], rest[50];
        if (sscanf(line, "%s %s %[^\n]", lhs, eq, rest) >= 3) {
            strcpy(code[i].lhs, lhs);
            char arg1[10], arg2[10], op;
            if (sscanf(rest, "%s %c %s", arg1, &op, arg2) == 3) {
                strcpy(code[i].arg1, arg1);
                code[i].op = op;
                strcpy(code[i].arg2, arg2);
            } else {
                if (sscanf(rest, "%s", code[i].arg1) != 1) {
                    code[i].arg1[0] = '\0';
                }
                code[i].op = '\0';
                code[i].arg2[0] = '\0';
            }
        }
    }

    printf("\n--- Generated Target Machine Code (Assembly) ---\n");
    for (int i = 0; i < n; i++) {
        if (code[i].op != '\0') {
            printf("MOV R0, %s\n", code[i].arg1);
            switch (code[i].op) {
                case '+':
                    printf("ADD R0, %s\n", code[i].arg2);
                    break;
                case '-':
                    printf("SUB R0, %s\n", code[i].arg2);
                    break;
                case '*':
                    printf("MUL R0, %s\n", code[i].arg2);
                    break;
                case '/':
                    printf("DIV R0, %s\n", code[i].arg2);
                    break;
                default:
                    printf("UNKNOWN OP\n");
            }
            printf("MOV %s, R0\n\n", code[i].lhs);
        } else {
            printf("MOV R0, %s\n", code[i].arg1);
            printf("MOV %s, R0\n\n", code[i].lhs);
        }
    }

    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc target_code_gen.c -o target_code_gen
$ ./target_code_gen
Enter number of TAC statements: 3
Enter TAC statements (e.g. t1 = b + c or a = t2):
t1 = b + c
t2 = t1 * d
a = t2

--- Generated Target Machine Code (Assembly) ---
MOV R0, b
ADD R0, c
MOV t1, R0

MOV R0, t1
MUL R0, d
MOV t2, R0

MOV R0, t2
MOV a, R0
*/
