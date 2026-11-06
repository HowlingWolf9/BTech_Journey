/*
EXPERIMENT 11: FIND FOLLOW OF ANY GRAMMAR

ALGORITHM:
1. Parse the grammar productions (e.g. `E=TR`, `R=+TR`, `R=#`), identifying all non-terminals.
2. Initialize FIRST and FOLLOW sets for each non-terminal.
3. Compute FIRST sets using standard FIRST algorithm:
   - If terminal, FIRST is the symbol itself.
   - For X -> Y1 Y2... Yk, add FIRST(Yi) \ {#} until some Yi doesn't derive #.
4. Compute FOLLOW sets:
   a. Add '$' (end-of-input marker) to the FOLLOW set of the start symbol.
   b. For each production A -> alpha B beta:
      - Add all elements of FIRST(beta) except '#' to FOLLOW(B).
      - If beta derives '#' (or beta is empty), add all elements of FOLLOW(A) to FOLLOW(B).
   c. Repeat step (b) iteratively until no new symbols can be added to any FOLLOW set (convergence).
5. Display the computed FOLLOW set for each distinct non-terminal.
*/

#include <stdio.h>
#include <ctype.h>
#include <string.h>

#define MAX 30

int num_productions;
char productions[MAX][MAX];
char nonTerminals[MAX];
int ntCount = 0;
char followSets[MAX][MAX];

void addToSet(char set[], char val) {
    if (val == '#') return; // Epsilon is never in FOLLOW
    for (int i = 0; set[i] != '\0'; i++) {
        if (set[i] == val)
            return;
    }
    int len = strlen(set);
    set[len] = val;
    set[len + 1] = '\0';
}

int unionSets(char dest[], const char src[]) {
    int changed = 0;
    for (int i = 0; src[i] != '\0'; i++) {
        if (src[i] == '#') continue;
        int found = 0;
        for (int j = 0; dest[j] != '\0'; j++) {
            if (dest[j] == src[i]) {
                found = 1;
                break;
            }
        }
        if (!found) {
            int len = strlen(dest);
            dest[len] = src[i];
            dest[len + 1] = '\0';
            changed = 1;
        }
    }
    return changed;
}

void findFirst(char result[], char c) {
    if (!isupper(c)) {
        int len = strlen(result);
        for (int i = 0; i < len; i++) {
            if (result[i] == c) return;
        }
        result[len] = c;
        result[len + 1] = '\0';
        return;
    }

    for (int i = 0; i < num_productions; i++) {
        if (productions[i][0] == c) {
            char *rhs = strchr(productions[i], '=');
            if (!rhs) {
                rhs = strstr(productions[i], "->");
                if (rhs) rhs += 2;
            } else {
                rhs += 1;
            }
            if (!rhs) continue;

            if (rhs[0] == '#') {
                int len = strlen(result);
                int found = 0;
                for (int k = 0; k < len; k++) if (result[k] == '#') found = 1;
                if (!found) { result[len] = '#'; result[len + 1] = '\0'; }
                continue;
            }

            int containsEpsilon = 0;
            for (int j = 0; rhs[j] != '\0'; j++) {
                char subResult[MAX] = "";
                findFirst(subResult, rhs[j]);

                containsEpsilon = 0;
                for (int k = 0; subResult[k] != '\0'; k++) {
                    if (subResult[k] == '#') {
                        containsEpsilon = 1;
                    } else {
                        int len = strlen(result);
                        int found = 0;
                        for (int m = 0; m < len; m++) if (result[m] == subResult[k]) found = 1;
                        if (!found) { result[len] = subResult[k]; result[len + 1] = '\0'; }
                    }
                }
                if (!containsEpsilon) break;
            }
            if (containsEpsilon) {
                int len = strlen(result);
                int found = 0;
                for (int k = 0; k < len; k++) if (result[k] == '#') found = 1;
                if (!found) { result[len] = '#'; result[len + 1] = '\0'; }
            }
        }
    }
}

int getNTIndex(char c) {
    for (int i = 0; i < ntCount; i++) {
        if (nonTerminals[i] == c) return i;
    }
    return -1;
}

void computeFollow(void) {
    // Rule 1: Add '$' to start symbol
    addToSet(followSets[0], '$');

    // Rule 2 & 3: Iterate until no changes
    int changed = 1;
    while (changed) {
        changed = 0;
        for (int p = 0; p < num_productions; p++) {
            char lhs = productions[p][0];
            int lhsIdx = getNTIndex(lhs);
            char *rhs = strchr(productions[p], '=');
            if (!rhs) {
                rhs = strstr(productions[p], "->");
                if (rhs) rhs += 2;
            } else {
                rhs += 1;
            }
            if (!rhs) continue;

            int rhsLen = strlen(rhs);
            for (int i = 0; i < rhsLen; i++) {
                if (isupper(rhs[i])) {
                    int bIdx = getNTIndex(rhs[i]);
                    if (bIdx == -1) continue;

                    // Compute FIRST of beta = rhs[i+1 ... rhsLen-1]
                    int allEpsilon = 1;
                    for (int j = i + 1; j < rhsLen; j++) {
                        char firstBeta[MAX] = "";
                        findFirst(firstBeta, rhs[j]);

                        int hasEps = 0;
                        for (int k = 0; firstBeta[k] != '\0'; k++) {
                            if (firstBeta[k] == '#') {
                                hasEps = 1;
                            } else {
                                int before = strlen(followSets[bIdx]);
                                addToSet(followSets[bIdx], firstBeta[k]);
                                if ((int)strlen(followSets[bIdx]) > before) changed = 1;
                            }
                        }

                        if (!hasEps) {
                            allEpsilon = 0;
                            break;
                        }
                    }

                    // If beta is empty or all derive epsilon, add FOLLOW(A) to FOLLOW(B)
                    if (allEpsilon) {
                        if (lhsIdx != -1 && lhsIdx != bIdx) {
                            if (unionSets(followSets[bIdx], followSets[lhsIdx])) {
                                changed = 1;
                            }
                        }
                    }
                }
            }
        }
    }
}

int main(void) {
    printf("Enter number of productions: ");
    if (scanf("%d", &num_productions) != 1 || num_productions <= 0) {
        printf("Invalid input.\n");
        return 1;
    }

    printf("Enter productions (e.g. E=TR or E->TR, use # for epsilon):\n");
    for (int i = 0; i < num_productions; i++) {
        scanf("%s", productions[i]);
        char nt = productions[i][0];
        if (getNTIndex(nt) == -1) {
            nonTerminals[ntCount++] = nt;
        }
    }

    for (int i = 0; i < ntCount; i++) {
        followSets[i][0] = '\0';
    }

    computeFollow();

    printf("\n--- FOLLOW Sets ---\n");
    for (int i = 0; i < ntCount; i++) {
        printf("FOLLOW(%c) = { ", nonTerminals[i]);
        for (int j = 0; followSets[i][j] != '\0'; j++) {
            if (j > 0) printf(", ");
            printf("%c", followSets[i][j]);
        }
        printf(" }\n");
    }

    return 0;
}


/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc follow.c -o follow
$ ./follow
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

--- FOLLOW Sets ---
FOLLOW(E) = { $, ) }
FOLLOW(R) = { $, ) }
FOLLOW(T) = { +, $, ) }
FOLLOW(Y) = { +, $, ) }
FOLLOW(F) = { *, +, $, ) }
*/
