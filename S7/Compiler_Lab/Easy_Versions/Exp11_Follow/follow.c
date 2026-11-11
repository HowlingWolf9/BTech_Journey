/*
EXPERIMENT 11: FIND FOLLOW OF ANY GRAMMAR (EASY VERSION)

ALGORITHM:
1. Read number of productions n and grammar productions of the form A=alpha (use '#' for epsilon).
2. Define FIRST helpers:
   - first(c, res): if c is terminal, add c; otherwise add first_str(rhs, res) for each production c=rhs.
   - first_str(s, res): compute FIRST across symbols in s, stopping if '#' is absent; add '#' if all derive '#'.
3. Define recursive follow(c, res):
   - If c is the start symbol p[0][0], add '$' to res.
   - For each production A=alpha containing c at position r:
     * Compute FIRST(r + 1) via first_str() and add all non-'#' symbols to res.
     * If FIRST(r + 1) contains '#' (including empty r + 1) and A != c, recurse follow(A, res).
4. For each unique non-terminal nt, compute follow(nt, res) and display FOLLOW(nt).
*/

#include <stdio.h>
#include <ctype.h>
#include <string.h>

int n;
char p[20][20];

void add(char *s, char c) {
    if (!strchr(s, c)) {
        strncat(s, &c, 1);
    }
}

void add_set(char *d, char *s) {
    for (; *s; s++) {
        if (*s != '#') {
            add(d, *s);
        }
    }
}

void first_str(char *s, char *res);

void first(char c, char *res) {
    if (!isupper(c)) {
        add(res, c);
        return;
    }
    for (int i = 0; i < n; i++) {
        if (p[i][0] == c) {
            first_str(p[i] + 2, res);
        }
    }
}

void first_str(char *s, char *res) {
    for (; *s; s++) {
        char sub[20] = "";
        first(*s, sub);
        add_set(res, sub);
        if (!strchr(sub, '#')) {
            return;
        }
    }
    add(res, '#');
}

void follow(char c, char *res) {
    if (p[0][0] == c) {
        add(res, '$');
    }
    for (int i = 0; i < n; i++) {
        for (char *r = p[i] + 2; *r; r++) {
            if (*r == c) {
                char sub[20] = "";
                first_str(r + 1, sub);
                add_set(res, sub);
                if (strchr(sub, '#') && p[i][0] != c) {
                    follow(p[i][0], res);
                }
            }
        }
    }
}

int main(void) {
    printf("Enter number of productions: ");
    scanf("%d", &n);
    printf("Enter productions (e.g. E=TR, # for eps):\n");
    for (int i = 0; i < n; i++) {
        scanf("%s", p[i]);
    }

    printf("\nFOLLOW Sets:\n");
    char done[20] = "";
    for (int i = 0; i < n; i++) {
        char nt = p[i][0];
        if (!strchr(done, nt)) {
            add(done, nt);
            char res[20] = "";
            follow(nt, res);
            printf("FOLLOW(%c) = { ", nt);
            for (int k = 0; res[k]; k++) {
                printf("%c%s", res[k], res[k + 1] ? ", " : "");
            }
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
