#include "integral.h"

void integral(double inferior, double superior, TreeNode *function) {
    double value = 0.0;
    double width = (superior - inferior) / integral_steps;
    if (inferior == superior) {
        printf("0");
    } else if (inferior > superior) {
        printf("ERROR: lower limit must be smaller than upper limit");
    } else {
        for (int i = 0; i < integral_steps; i++) {
            double area = eval(function, inferior + i * width) * width;
            value += area;
        }
        printf("%f", value);
    }

    puts("");
}