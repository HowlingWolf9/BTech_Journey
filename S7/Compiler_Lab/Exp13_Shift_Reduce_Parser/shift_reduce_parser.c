/*
EXPERIMENT 13: SHIFT REDUCE PARSER

ALGORITHM:
1. Define the grammar:
   E -> E + E
   E -> E * E
   E -> ( E )
   E -> i (identifier)
2. Initialize parser state:
   - Stack contains initial marker '$'.
   - Input string ends with '$'.
3. In a loop, attempt Reduction based on operator precedence:
   - If stack top matches 'i', reduce to 'E' (E -> i).
   - If stack top matches '(E)', reduce to 'E' (E -> (E)).
   - If stack top matches 'E*E', reduce to 'E' (E -> E*E).
   - If stack top matches 'E+E':
     * If next input symbol is '*', shift (since '*' has higher precedence than '+').
     * Otherwise, reduce to 'E' (E -> E+E).
4. If a reduction was performed, display current Stack, remaining Input, and Reduce Action.
5. If no reduction is applicable:
   - If input pointer points to '$' and stack is "$E", parsing succeeds (ACCEPT).
   - If input pointer points to '$' and stack is not "$E", parsing fails (REJECT).
   - Otherwise, SHIFT next input symbol onto stack and display state.
6. Display the complete parsing trace in tabular format.
*/

#include <stdio.h>
#include <string.h>

void printStep(const char *stack, const char *input, int inPos, const char *action) {
    printf("%-20s %-20s %-20s\n", stack, input + inPos, action);
}

int main(void) {
    char input[100];
    char stack[100];
    int top = 0;
    int inPos = 0;

    printf("Grammar:\n");
    printf("  E -> E + E\n");
    printf("  E -> E * E\n");
    printf("  E -> ( E )\n");
    printf("  E -> i\n\n");

    printf("Enter input string (use 'i' for identifier, e.g. i+i*i): ");
    if (scanf("%s", input) != 1) {
        printf("Error reading input.\n");
        return 1;
    }

    int len = strlen(input);
    if (input[len - 1] != '$') {
        input[len] = '$';
        input[len + 1] = '\0';
    }

    // Initialize stack with '$'
    stack[0] = '$';
    stack[1] = '\0';
    top = 0;

    printf("\n%-20s %-20s %-20s\n", "Stack", "Input", "Action");
    printf("----------------------------------------------------------------\n");

    while (1) {
        int reduced = 0;

        // Check if stack top has 'i' -> Reduce E -> i
        if (stack[top] == 'i') {
            stack[top] = 'E';
            printStep(stack, input, inPos, "Reduce: E -> i");
            reduced = 1;
        }
        // Check for (E) -> Reduce E -> (E)
        else if (top >= 2 && stack[top - 2] == '(' && stack[top - 1] == 'E' && stack[top] == ')') {
            top -= 2;
            stack[top] = 'E';
            stack[top + 1] = '\0';
            printStep(stack, input, inPos, "Reduce: E -> (E)");
            reduced = 1;
        }
        // Check for E*E -> Reduce E -> E*E
        else if (top >= 2 && stack[top - 2] == 'E' && stack[top - 1] == '*' && stack[top] == 'E') {
            top -= 2;
            stack[top] = 'E';
            stack[top + 1] = '\0';
            printStep(stack, input, inPos, "Reduce: E -> E*E");
            reduced = 1;
        }
        // Check for E+E -> Reduce E -> E+E (only if next symbol is not '*')
        else if (top >= 2 && stack[top - 2] == 'E' && stack[top - 1] == '+' && stack[top] == 'E') {
            if (input[inPos] != '*') {
                top -= 2;
                stack[top] = 'E';
                stack[top + 1] = '\0';
                printStep(stack, input, inPos, "Reduce: E -> E+E");
                reduced = 1;
            }
        }

        if (reduced) {
            continue;
        }

        // Check acceptance
        if (strcmp(stack, "$E") == 0 && input[inPos] == '$') {
            printStep(stack, input, inPos, "Accept");
            printf("\nResult: String is successfully parsed.\n");
            break;
        }

        // If at end of input and cannot reduce or accept -> Reject
        if (input[inPos] == '$') {
            printStep(stack, input, inPos, "Reject");
            printf("\nResult: String is rejected (Syntax Error).\n");
            break;
        }

        // Shift next character
        top++;
        stack[top] = input[inPos];
        stack[top + 1] = '\0';
        inPos++;
        printStep(stack, input, inPos, "Shift");
    }

    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc shift_reduce_parser.c -o shift_reduce_parser

Test 1: Valid input i+i*i
$ ./shift_reduce_parser
Enter input string (use 'i' for identifier, e.g. i+i*i): i+i*i

Stack                Input                Action              
----------------------------------------------------------------
$i                   +i*i$                Shift               
$E                   +i*i$                Reduce: E -> i      
$E+                  i*i$                 Shift               
$E+i                 *i$                  Shift               
$E+E                 *i$                  Reduce: E -> i      
$E+E*                i$                   Shift               
$E+E*i               $                    Shift               
$E+E*E               $                    Reduce: E -> i      
$E+E                 $                    Reduce: E -> E*E    
$E                   $                    Reduce: E -> E+E    
$E                   $                    Accept              

Result: String is successfully parsed.

Test 2: Invalid input i++i
$ ./shift_reduce_parser
Enter input string (use 'i' for identifier, e.g. i+i*i): i++i

Stack                Input                Action              
----------------------------------------------------------------
$i                   ++i$                 Shift               
$E                   ++i$                 Reduce: E -> i      
$E+                  +i$                  Shift               
$E++                 i$                   Shift               
$E++i                $                    Shift               
$E++E                $                    Reduce: E -> i      
$E++E                $                    Reject              

Result: String is rejected (Syntax Error).
*/
