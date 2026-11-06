/*
EXPERIMENT 10: FIND FIRST OF ANY GRAMMAR

ALGORITHM:
1. Represent the grammar as a set of productions of the form `A=alpha` (e.g., `E=TR`, `R=+TR`, `R=#`),
   where uppercase letters denote non-terminals, '#' denotes epsilon, and any other character is a terminal.
2. For each non-terminal X, define FIRST(X):
   a. If X is a terminal, FIRST(X) = { X }.
   b. If there is a production X -> #, add '#' to FIRST(X).
   c. If there is a production X -> Y1 Y2 ... Yk:
      - Compute FIRST(Y1). Add all symbols of FIRST(Y1) except '#' to FIRST(X).
      - If FIRST(Y1) contains '#', compute FIRST(Y2), and so on.
      - If all Y1, Y2, ..., Yk produce '#', add '#' to FIRST(X).
3. Repeat the computation for all non-terminals until no further symbols can be added.
4. Display the computed FIRST set for each distinct non-terminal.
*/

#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define MAX 30

int num_productions;
char productions[MAX][MAX];

void addToResultSet(char result[], char val) {
    for (int i = 0; result[i] != '\0'; i++) {
        if (result[i] == val)
            return;
    }
    int len = strlen(result);
    result[len] = val;
    result[len + 1] = '\0';
}

void findFirst(char result[], char c) {
    // If c is a terminal, FIRST(c) = {c}
    if (!isupper(c)) {
        addToResultSet(result, c);
        return;
    }

    // For each production of non-terminal c
    for (int i = 0; i < num_productions; i++) {
        if (productions[i][0] == c) {
            // Find start of RHS (after '=' or '->')
            char *rhs = strchr(productions[i], '=');
            if (!rhs) {
                rhs = strstr(productions[i], "->");
                if (rhs) rhs += 2;
            } else {
                rhs += 1;
            }

            if (!rhs) continue;

            // If RHS is epsilon '#'
            if (rhs[0] == '#') {
                addToResultSet(result, '#');
                continue;
            }

            // Iterate over symbols on RHS
            int containsEpsilon = 0;
            for (int j = 0; rhs[j] != '\0'; j++) {
                char subResult[MAX] = "";
                findFirst(subResult, rhs[j]);

                containsEpsilon = 0;
                for (int k = 0; subResult[k] != '\0'; k++) {
                    if (subResult[k] == '#') {
                        containsEpsilon = 1;
                    } else {
                        addToResultSet(result, subResult[k]);
                    }
                }

                // If this symbol cannot derive epsilon, stop looking at next symbols
                if (!containsEpsilon) {
                    break;
                }
            }

            // If all symbols derived epsilon
            if (containsEpsilon) {
                addToResultSet(result, '#');
            }
        }
    }
}

int main(void) {
    char nonTerminals[MAX];
    int ntCount = 0;

    printf("Enter number of productions: ");
    if (scanf("%d", &num_productions) != 1 || num_productions <= 0) {
        printf("Invalid input.\n");
        return 1;
    }

    printf("Enter productions (e.g. E=TR or E->TR, use # for epsilon):\n");
    for (int i = 0; i < num_productions; i++) {
        scanf("%s", productions[i]);
        char nt = productions[i][0];
        int exists = 0;
        for (int j = 0; j < ntCount; j++) {
            if (nonTerminals[j] == nt) {
                exists = 1;
                break;
            }
        }
        if (!exists) {
            nonTerminals[ntCount++] = nt;
        }
    }

    printf("\n--- FIRST Sets ---\n");
    for (int i = 0; i < ntCount; i++) {
        char result[MAX] = "";
        findFirst(result, nonTerminals[i]);

        printf("FIRST(%c) = { ", nonTerminals[i]);
        for (int j = 0; result[j] != '\0'; j++) {
            if (j > 0) printf(", ");
            printf("%c", result[j]);
        }
        printf(" }\n");
    }

    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc first.c -o first
$ ./first
Enter number of productions: 8
Enter productions (e.g. E=TR or E->TR, use # for epsilon):
E=TR
R=+TR
R=#
T=FY
Y=*FY
Y=#
F=(E)
F=i

--- FIRST Sets ---
FIRST(E) = { (, i }
FIRST(R) = { +, # }
FIRST(T) = { (, i }
FIRST(Y) = { *, # }
FIRST(F) = { (, i }
*/
