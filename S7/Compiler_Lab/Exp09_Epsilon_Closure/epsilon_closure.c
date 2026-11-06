/*
EXPERIMENT 09: FIND E-CLOSURE OF ALL STATES OF ANY GIVEN NFA WITH E TRANSITION

ALGORITHM:
1. Read the number of states (n) and number of transitions (m) of the NFA.
2. Read the m transitions in the format (from, symbol, to), where 'e' or 'E' represents epsilon.
3. For each state `i` from 0 to n - 1:
   a. Maintain a visited array `visited` initialized to false, and a stack.
   b. Mark `visited[i] = true` and push `i` onto the stack (by definition, state `i` is in its own e-closure).
   c. While stack is not empty:
      - Pop state `curr`.
      - For each transition from `curr` to `next` on symbol 'e' or 'E':
        * If `next` has not been visited:
          - Mark `visited[next] = true`.
          - Push `next` onto the stack.
   d. Print all states that have `visited` marked as true as the epsilon closure of state `i`.
*/

#include <stdio.h>
#include <stdlib.h>

#define MAX_STATES 20
#define MAX_TRANSITIONS 50

struct Transition {
    int from;
    char symbol;
    int to;
};

int main(void) {
    int num_states, num_transitions;
    struct Transition transitions[MAX_TRANSITIONS];

    printf("Enter number of states: ");
    if (scanf("%d", &num_states) != 1 || num_states <= 0 || num_states > MAX_STATES) {
        printf("Invalid number of states.\n");
        return 1;
    }

    printf("Enter number of transitions: ");
    if (scanf("%d", &num_transitions) != 1 || num_transitions < 0 || num_transitions > MAX_TRANSITIONS) {
        printf("Invalid number of transitions.\n");
        return 1;
    }

    printf("Enter transitions (format: <from_state> <symbol> <to_state>, use 'e' for epsilon):\n");
    for (int i = 0; i < num_transitions; i++) {
        scanf("%d %c %d", &transitions[i].from, &transitions[i].symbol, &transitions[i].to);
    }

    printf("\n--- Epsilon Closures ---\n");
    for (int state = 0; state < num_states; state++) {
        int visited[MAX_STATES] = {0};
        int stack[MAX_STATES];
        int top = -1;

        // Epsilon closure always includes the state itself
        visited[state] = 1;
        stack[++top] = state;

        while (top >= 0) {
            int curr = stack[top--];

            for (int i = 0; i < num_transitions; i++) {
                if (transitions[i].from == curr && (transitions[i].symbol == 'e' || transitions[i].symbol == 'E')) {
                    int next = transitions[i].to;
                    if (!visited[next] && next < num_states) {
                        visited[next] = 1;
                        stack[++top] = next;
                    }
                }
            }
        }

        // Print closure
        printf("e-closure(%d) = { ", state);
        int first = 1;
        for (int j = 0; j < num_states; j++) {
            if (visited[j]) {
                if (!first) printf(", ");
                printf("%d", j);
                first = 0;
            }
        }
        printf(" }\n");
    }

    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc epsilon_closure.c -o epsilon_closure
$ ./epsilon_closure
Enter number of states: 3
Enter number of transitions: 3
Enter transitions (format: <from_state> <symbol> <to_state>, use 'e' for epsilon):
0 e 1
1 e 2
2 a 2

--- Epsilon Closures ---
e-closure(0) = { 0, 1, 2 }
e-closure(1) = { 1, 2 }
e-closure(2) = { 2 }
*/
