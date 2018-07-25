#include "plotter.h"

void plot(TreeNode *function) {
    int i = 0;
    double step = (h_view_hi - h_view_lo) / 80.0;

    for (i = 0; i < 80; i++) {
        double value = eval(function, h_view_lo + (i * step));
        printf("%f\n", value);
    }
}

void start_graph() {
    int i, j;
    for (i = 0; i < 25; i++) {
        for (j = 0; j < 80; j++) {
            graph[i][j] = ' ';
        }
    }
}

void draw_line() {
    /*
    int i;
    for (i = 0; i < 80; i++) {
        graph[13][i] = '-';
    }
    double interval = h_view_hi - h_view_lo;
    double step = interval / 80;
    int mid;
    if (h_view_lo <= 0 && h_view_hi > 0) {
        mid = binary_search(h_view_hi, h_view_lo, step);

    }
    */
}

int binary_search(int middle, double l, double r, double step) {
    /*
    double mid = (r - l) / 2.0;
    if (0 <= mid + step && 0 <= mid - step) {
        return ;
    } else if (mid + step >= )
    */
}

