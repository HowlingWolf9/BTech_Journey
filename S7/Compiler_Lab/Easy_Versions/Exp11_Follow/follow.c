/*
EXPERIMENT 11: FIND FOLLOW OF ANY GRAMMAR (EASY VERSION)

ALGORITHM:
1. Read number of productions n and store each production A=alpha ('#' for epsilon) in p[i].lhs and p[i].rhs.
2. Define add(s, c) to append unique characters to set string s, and string-based first(s, res):
   - Scan symbols *s in s; if !isupper(*s), add *s to res and return.
   - Otherwise collect FIRST(p[i].rhs) into sub for all productions with p[i].lhs == *s, add non-'#' symbols to res, and return if '#' is absent from sub.
   - If all symbols derive '#' (or s is empty), add '#' to res.
3. Define recursive follow(c, res):
   - If c is the start symbol p[0].lhs, add '$' to res.
   - For each production p[i] containing c at position r in p[i].rhs:
     * Compute FIRST(r + 1) into sub via first(r + 1, sub) and add all non-'#' symbols to res.
     * If sub contains '#' (including empty r + 1) and p[i].lhs != c, recurse follow(p[i].lhs, res).
4. For each unique non-terminal nt (p[i].lhs), compute follow(nt, res) and display FOLLOW(nt).
*/

#include <stdio.h>
#include <ctype.h>
#include <string.h>

int n;
struct {
    char lhs, rhs[20];
} p[20];

void add(char *s, char c) {
    if (!strchr(s, c)) {
        strncat(s, &c, 1);
    }
}

void first(char *s, char *res) {
    for (; *s; s++) {
        if (!isupper(*s)) {
            add(res, *s);
            return;
        }
        char sub[20] = "";
        for (int i = 0; i < n; i++) {
            if (p[i].lhs == *s) {
                first(p[i].rhs, sub);
            }
        }
        for (int k = 0; sub[k]; k++) {
            if (sub[k] != '#') {
                add(res, sub[k]);
            }
        }
        if (!strchr(sub, '#')) {
            return;
        }
    }
    add(res, '#');
}

void follow(char c, char *res) {
    if (p[0].lhs == c) {
        add(res, '$');
    }
    for (int i = 0; i < n; i++) {
        for (char *r = p[i].rhs; *r; r++) {
            if (*r == c) {
                char sub[20] = "";
                first(r + 1, sub);
                for (int k = 0; sub[k]; k++) {
                    if (sub[k] != '#') {
                        add(res, sub[k]);
                    }
                }
                if (strchr(sub, '#') && p[i].lhs != c) {
                    follow(p[i].lhs, res);
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
        scanf(" %c=%s", &p[i].lhs, p[i].rhs);
    }

    printf("\nFOLLOW Sets:\n");
    char done[20] = "";
    for (int i = 0; i < n; i++) {
        char nt = p[i].lhs;
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
