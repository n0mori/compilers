#include <settings.h>

void set_padroes() {
    h_view_lo = -6.5;
    h_view_hi = 6.5;
    v_view_lo = -3.5;
    v_view_hi = 3.5;
    integral_steps = 1000;
    axis = 1;
    connect = 0;
}

void show_settings() {
    printf("h_view_lo: %.6f\n", h_view_lo);
    printf("h_view_hi: %.6f\n", h_view_hi);
    printf("v_view_lo: %.6f\n", v_view_lo);
    printf("v_view_hi: %.6f\n", v_view_hi);
    printf("integral_steps: %d\n\n", integral_steps);

    printf("Draw Axis: ");
    if (axis) {
        puts("ON.");
    } else {
        puts("OFF.");
    }

    printf("Connect Dots: ");
    if (connect) {
        puts("ON.");
    } else {
        puts("OFF.");
    }
    puts("");
}

void set_h_view(double lo, double hi) {
    if (lo < hi) {
        h_view_lo = lo;
        h_view_hi = hi;
    } else {
        puts("ERROR: h_view_lo must be smaller than h_view_hi");
    }
}

void set_v_view(double lo, double hi) {
    if (lo < hi) {
        v_view_lo = lo;
        v_view_hi = hi;
    } else {
        puts("ERROR: v_view_lo must be smaller than v_view_hi");
    }
}