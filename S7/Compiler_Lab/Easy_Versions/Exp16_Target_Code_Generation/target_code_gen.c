/*
EXPERIMENT 16: TARGET CODE GENERATION (EASY VERSION)

ALGORITHM:
1. Read the number of Three-Address Code (TAC) statements n.
2. For each statement of the form LHS = arg1 op arg2 or LHS = arg1:
   a. If statement is a binary operation (op is +, -, *, /):
      - Load first operand into register R0: MOV R0, arg1.
      - Perform operation with second operand: ADD / SUB / MUL / DIV R0, arg2.
      - Store register contents into destination: MOV LHS, R0.
   b. If statement is a simple assignment (LHS = arg1):
      - Load operand into register: MOV R0, arg1.
      - Store register into destination: MOV LHS, R0.
3. Display generated target assembly instructions.
*/

#include <stdio.h>

int main(void) {
    int n;
    printf("Enter number of TAC statements: ");
    scanf("%d", &n);
    printf("Enter TAC statements (e.g. t1 = b + c or a = t2):\n");
    printf("\n--- Generated Target Machine Code ---\n");

    for (int i = 0; i < n; i++) {
        char lhs[10], op1[10], op2[10], op, line[50];
        scanf(" %[^\n]", line);

        if (sscanf(line, "%s = %s %c %s", lhs, op1, &op, op2) == 4) {
            char *instr = "ADD";
            if (op == '-') {
                instr = "SUB";
            } else if (op == '*') {
                instr = "MUL";
            } else if (op == '/') {
                instr = "DIV";
            }

            printf("MOV R0, %s\n", op1);
            printf("%s R0, %s\n", instr, op2);
            printf("MOV %s, R0\n\n", lhs);
        } else if (sscanf(line, "%s = %s", lhs, op1) == 2) {
            printf("MOV R0, %s\n", op1);
            printf("MOV %s, R0\n\n", lhs);
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

--- Generated Target Machine Code ---
MOV R0, b
ADD R0, c
MOV t1, R0

MOV R0, t1
MUL R0, d
MOV t2, R0

MOV R0, t2
MOV a, R0
*/
