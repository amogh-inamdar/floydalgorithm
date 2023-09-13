#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define MAX_CITIES 10

int n; // Number of cities
int graph[MAX_CITIES][MAX_CITIES]; // Adjacency matrix representing the distances between cities

int minTour[MAX_CITIES]; // Stores the best tour found so far
int minTourLength = INT_MAX; // Length of the best tour found so far

int currentTour[MAX_CITIES]; // Stores the current tour being considered
int used[MAX_CITIES]; // Keeps track of visited cities

void inputGraph() {
    printf("Enter the number of cities (max %d): ", MAX_CITIES);
    scanf("%d", &n);

    printf("Enter the distance matrix (enter -1 for infinity):\n");
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            scanf("%d", &graph[i][j]);
        }
    }
}

void printTour(int tour[]) {
    printf("Tour: ");
    for (int i = 0; i < n; i++) {
        printf("%d -> ", tour[i] + 1); // Adding 1 to convert 0-based indexing to 1-based indexing
    }
    printf("%d\n", tour[0] + 1); // Return to the starting city
}

void tsp(int pos, int length) {
    if (pos == n) { // All cities have been visited
        if (length + graph[currentTour[n - 1]][currentTour[0]] < minTourLength) {
            for (int i = 0; i < n; i++) {
                minTour[i] = currentTour[i];
            }
            minTourLength = length + graph[currentTour[n - 1]][currentTour[0]];
        }
        return;
    }

    for (int i = 0; i < n; i++) {
        if (!used[i]) {
            used[i] = 1;
            currentTour[pos] = i;
            tsp(pos + 1, length + graph[currentTour[pos - 1]][i]);
            used[i] = 0;
        }
    }
}

int main() {
    inputGraph();

    for (int i = 0; i < n; i++) {
        used[i] = 0;
    }

    currentTour[0] = 0; // Start from the first city
    used[0] = 1;

    tsp(1, 0);

    printf("Minimum Tour Length: %d\n", minTourLength);
    printf("Minimum Tour: ");
    printTour(minTour);

    return 0;
}
