/*
EXPERIMENT 09: FIND EPSILON CLOSURE OF ALL STATES OF AN NFA (EASY VERSION)

ALGORITHM:
1. Read number of states n and number of transitions m.
2. For each transition (u, sym, v), if sym == 'e' or 'E', set t[u][v] = 1.
3. For each state i from 0 to n - 1:
   - Initialize visited array to 0.
   - Perform DFS traversal starting from state i across epsilon edges.
   - Print all visited states as e-closure(i).
4. Terminate.
*/

#include <stdio.h>

int n, m, t[20][20];

void dfs(int s, int vis[]) {
    vis[s] = 1;
    for (int i = 0; i < n; i++) if (t[s][i] && !vis[i]) dfs(i, vis);
}

int main() {
    printf("Enter number of states & transitions: ");
    scanf("%d%d", &n, &m);
    printf("Enter transitions (u sym v):\n");
    for (int i = 0, u, v; i < m; i++) {
        char c;
        scanf("%d %c %d", &u, &c, &v);
        if (c == 'e' || c == 'E') t[u][v] = 1;
    }
    printf("\nEpsilon Closures:\n");
    for (int i = 0; i < n; i++) {
        int vis[20] = {0};
        dfs(i, vis);
        printf("e-closure(%d) = { ", i);
        for (int j = 0, first = 1; j < n; j++) {
            if (vis[j]) {
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
Enter number of states & transitions: 3 3
Enter transitions (u sym v):
0 e 1
1 e 2
2 a 2

Epsilon Closures:
e-closure(0) = { 0, 1, 2 }
e-closure(1) = { 1, 2 }
e-closure(2) = { 2 }
*/
