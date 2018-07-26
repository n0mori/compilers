#include "matrix.h"

void start_matrix() {
    matrix[0][0] = 10;
    matrix[0][1] = 2;
    matrix[0][2] = 1;
    matrix[1][0] = 1;
    matrix[1][1] = 5;
    matrix[1][2] = 1;
    matrix[2][0] = 2;
    matrix[2][1] = 3;
    matrix[2][2] = 10;
    m_rows = 3;
    m_cols = 3;
}

int insert_matrix(int i, int j, double value);

int matrix_cop();

void show_matrix() {
    int i, j;
    if (m_rows == 0 && m_cols == 0) {
        puts("No matrix defined!");
        return;
    }

    printf("+-");
    for (i = 0; i < m_cols; i++) {
        printf("              ");
    }
    printf("-+\n");

    for (i = 0; i < m_rows; i++) {
        printf("| ");
        for (j = 0; j < m_cols; j++) {
            printf("% .6e ", matrix[i][j]);
        }
        printf(" |\n");
    }

    printf("+-");
    for (i = 0; i < m_cols; i++) {
        printf("              ");
    }
    printf("-+\n");
}

void solve_determinant() {
    int i, j, k;
    double m[10][10];

    if (m_rows == 0 && m_cols == 0) {
        puts("No matrix defined!");
        return;
    }

    if (m_rows != m_cols) {
        puts("Matrix format incorrect!");
        return;
    }

    for (i = 0; i < 10; i++) {
        for (j = 0; j < 10; j++) {
            m[i][j] = matrix[i][j];
        }
    }

    for (k = 0; k < m_rows; k++) {
        double pivot = matrix[k][k];
        for (i = k+1; i < m_rows; i++) {
            double factor = matrix[i][k] / pivot;
            for (j = k; j < m_cols; j++) {
                matrix[i][j] -= (factor * matrix[k][j]);
            }
        }
    }

    double det = 1;

    for (k = 0; k < m_rows; k++) {
        det *= matrix[k][k];
    }

    printf("%f\n", det);
}

void solve_linear();