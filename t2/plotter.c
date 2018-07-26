#include "plotter.h"

void plot(TreeNode *function) {
    int i, j;
    double step_h = (h_view_hi - h_view_lo) / 80.0;
    double step_v = (v_view_hi - v_view_lo) / 25.0;
    start_graph();

    if (axis) {
        draw_line();
    }

    for (i = 0; i < 80; i++) {
        double value = eval(function, h_view_lo + (i * step_h));

        for (j = 24; j > 0; j--) {
            if (value >= (v_view_lo + (j-1) * step_v) && value <= (v_view_lo + j * step_v)) {
                graph[24-j][i] = '*';
            }
        }

    }

    for (i = 0; i < 25; i++) {
        for (j = 0; j < 80; j++) {
            printf("%c", graph[i][j]);
        }
        puts("");
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
    int i, j;
    double step_h = (h_view_hi - h_view_lo) / 80.0;
    double step_v = (v_view_hi - v_view_lo) / 25.0;
    int pos_zero_h = -1;
    int pos_zero_v = -1;
    for (i = 0; i < 79; i++) {
        if (0 >= (h_view_lo + i * step_h) && 0 <= (h_view_lo + (i+1) * step_h)) {
            pos_zero_h = i;
        }
    }

    for (i = 0; i < 24; i++) {
        if (0 >= (v_view_lo + i * step_v) && 0 <= (v_view_lo + (i+1) * step_v)) {
            pos_zero_v = i;
        }
    }

    if (pos_zero_v != -1) {
        for (i = 0; i < 80; i++) {
            graph[pos_zero_v][i] = '-';
        }
    }

    if (pos_zero_h != -1) {
        for (i = 0; i < 25; i++) {
            graph[i][pos_zero_h] = '|';
        }
    }

    if (pos_zero_h != -1 && pos_zero_v != -1) {
        graph[pos_zero_v][pos_zero_h] = '+';
    }

}