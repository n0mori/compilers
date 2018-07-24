#include <stdio.h>

double h_view_lo;
double h_view_hi;
double v_view_lo;
double v_view_hi;
int integral_steps;
int axis;
int connect;

void set_padroes();
void show_settings();
void set_h_view(double lo, double hi);
void set_v_view(double lo, double hi);