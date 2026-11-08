/*
EXPERIMENT 11: FIND FOLLOW OF ANY GRAMMAR (EASY VERSION)

ALGORITHM:
1. Read number of productions n and grammar productions of the form A=alpha (use '#' for epsilon).
2. Initialize FOLLOW set of start symbol with '$'.
3. Iteratively propagate FOLLOW sets across all productions:
   - For each production A = ... B beta:
     * Add all symbols of FIRST(beta) except '#' to FOLLOW(B).
     * If beta is empty or FIRST(beta) contains '#', add all symbols of FOLLOW(A) to FOLLOW(B).
4. Repeat propagation across multiple passes until convergence.
5. Display the computed FOLLOW sets for each unique non-terminal.
*/

#include <stdio.h>
#include <ctype.h>
#include <string.h>

int n;
char p[20][20], fol[26][20];

void add(char *s, char c) {
    if (!strchr(s, c)) { int l = strlen(s); s[l] = c; s[l+1] = 0; }
}

void first(char c, char *res) {
    if (!isupper(c)) { add(res, c); return; }
    for (int i = 0; i < n; i++) {
        if (p[i][0] == c) {
            if (p[i][2] == '#') add(res, '#');
            else {
                for (int j = 2; p[i][j]; j++) {
                    char sub[20] = "";
                    first(p[i][j], sub);
                    for (int k = 0; sub[k]; k++) if (sub[k] != '#') add(res, sub[k]);
                    if (!strchr(sub, '#')) break;
                    if (!p[i][j+1]) add(res, '#');
                }
            }
        }
    }
}

int main() {
    printf("Enter number of productions: ");
    scanf("%d", &n);
    printf("Enter productions (e.g. E=TR, # for eps):\n");
    for (int i = 0; i < n; i++) scanf("%s", p[i]);

    add(fol[p[0][0] - 'A'], '$');

    for (int pass = 0; pass < 10; pass++) {
        for (int i = 0; i < n; i++) {
            char A = p[i][0];
            for (int j = 2; p[i][j]; j++) {
                char B = p[i][j];
                if (isupper(B)) {
                    int k = j + 1;
                    for (; p[i][k]; k++) {
                        char sub[20] = "";
                        first(p[i][k], sub);
                        for (int m = 0; sub[m]; m++) if (sub[m] != '#') add(fol[B - 'A'], sub[m]);
                        if (!strchr(sub, '#')) break;
                    }
                    if (!p[i][k]) {
                        for (int m = 0; fol[A - 'A'][m]; m++) add(fol[B - 'A'], fol[A - 'A'][m]);
                    }
                }
            }
        }
    }

    printf("\nFOLLOW Sets:\n");
    char done[20] = "";
    for (int i = 0; i < n; i++) {
        char nt = p[i][0];
        if (!strchr(done, nt)) {
            add(done, nt);
            printf("FOLLOW(%c) = { ", nt);
            for (int k = 0; fol[nt - 'A'][k]; k++)
                printf("%c%s", fol[nt - 'A'][k], fol[nt - 'A'][k+1] ? ", " : "");
            printf(" }\n");
        }
    }
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc follow.c -o follow
$ ./follow
Enter number of productions: 8
Enter productions (e.g. E=TR, # for eps):
E=TR
R=+TR
R=#
T=FY
Y=*FY
Y=#
F=(E)
F=i

FOLLOW Sets:
FOLLOW(E) = { $, ) }
FOLLOW(R) = { $, ) }
FOLLOW(T) = { +, $, ) }
FOLLOW(Y) = { +, $, ) }
FOLLOW(F) = { *, +, $, ) }
*/
