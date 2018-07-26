#include "matrix.h"

void start_matrix() {
    matrix[0][0] = -1;
    matrix[0][1] = 0;
    matrix[0][2] = 0;
    matrix[1][0] = 0;
    matrix[1][1] = 1;
    matrix[1][2] = 0;
    m_rows = 2;
    m_cols = 3;
}

int insert_matrix(int i, int j, double value);

int matrix_cop();

void show_matrix() {
    start_matrix();
    int i, j;
    if (m_rows == 0 && m_cols == 0) {
        puts("No matrix defined!");
    } else {
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
}

void solve_determinant();

void solve_linear();