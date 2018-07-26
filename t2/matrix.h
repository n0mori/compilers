#ifndef MATRIX__H
#define MATRIX__H

#include <stdio.h>

double matrix[10][10];
double aux[10][10];
int m_rows;
int m_cols;

void start_matrix();
int insert_matrix(int i, int j, double value);
int matrix_cop();
void show_matrix();
void solve_determinant();
void solve_linear();

#endif