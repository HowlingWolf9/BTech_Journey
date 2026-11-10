/*
EXPERIMENT 10: FIND FIRST OF ANY GRAMMAR (EASY VERSION)

ALGORITHM:
1. Read number of productions n and grammar productions of the form A=alpha (use '#' for epsilon).
2. For each non-terminal c:
   - If c is terminal, FIRST(c) = {c}.
   - If c -> Y1 Y2 ... Yk:
     * Add all non-epsilon symbols from FIRST(Y1) to FIRST(c).
     * If FIRST(Y1) contains '#', continue with Y2, and so on.
     * If all symbols derive '#', add '#' to FIRST(c).
3. Compute and display the FIRST set for each unique non-terminal.
*/

#include <stdio.h>
#include <ctype.h>
#include <string.h>

int n;
char p[20][20];

void add(char *s, char c) {
    if (!strchr(s, c)) {
        int l = strlen(s);
        s[l] = c;
        s[l+1] = 0;
    }
}

void first(char c, char *res) {
    if (!isupper(c)) {
        add(res, c);
        return;
    }
    for (int i = 0; i < n; i++) {
        if (p[i][0] == c) {
            char *rhs = strchr(p[i], '=');
            for (char *r = rhs ? rhs + 1 : p[i] + 2; *r; r++) {
                char sub[20] = "";
                first(*r, sub);
                for (int k = 0; sub[k]; k++)
                    if (sub[k] != '#')
                        add(res, sub[k]);
                if (!strchr(sub, '#'))
                    break;
                if (!r[1])
                    add(res, '#');
            }
        }
    }
}

int main(void) {
    printf("Enter number of productions: ");
    scanf("%d", &n);
    printf("Enter productions (e.g. E=TR, # for eps):\n");
    for (int i = 0; i < n; i++)
        scanf("%s", p[i]);

    printf("\nFIRST Sets:\n");
    char done[20] = "";
    for (int i = 0; i < n; i++) {
        char nt = p[i][0];
        if (!strchr(done, nt)) {
            add(done, nt);
            char res[20] = "";
            first(nt, res);
            printf("FIRST(%c) = { ", nt);
            for (int k = 0; res[k]; k++)
                printf("%c%s", res[k], res[k+1] ? ", " : "");
            printf(" }\n");
        }
    }
    return 0;
}

/*
SAMPLE OUTPUT:
----------------------------------------
$ gcc first.c -o first
$ ./first
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

FIRST Sets:
FIRST(E) = { (, i }
FIRST(R) = { +, # }
FIRST(T) = { (, i }
FIRST(Y) = { *, # }
FIRST(F) = { (, i }
*/
