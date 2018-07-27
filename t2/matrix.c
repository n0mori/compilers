#include "matrix.h"

void start_matrix() {
    matrix[0][0] = 10;
    matrix[0][1] = 2;
    matrix[0][2] = 1;
    //matrix[0][3] = 7;
    matrix[1][0] = 1;
    matrix[1][1] = 5;
    matrix[1][2] = 1;
    //matrix[1][3] = -8;
    matrix[2][0] = 2;
    matrix[2][1] = 3;
    matrix[2][2] = 10;
    //matrix[2][3] = 6;
    m_rows = 3;
    m_cols = 3;

    start_aux();

}

void start_aux() {
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
            aux[i][j] = 0.0;
        }
    }
    a_rows = 0;
    a_cols = 0;
}

int insert_matrix(int i, int j, double value) {
    if (i >= 10 || j >= 10) {
        return 1;
    }

    if (i >= a_rows) {
        a_rows = i+1;
    }

    if (j >= a_cols) {
        a_cols = j+1;
    } 

    aux[i][j] = value;
    return 0;
}

int matrix_cop() {
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
            matrix[i][j] = aux[i][j];
        }
    }
    m_rows = a_rows;
    m_cols = a_cols;
}

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

    gauss(m);

    double det = 1;

    for (k = 0; k < m_rows; k++) {
        det *= m[k][k];
    }

    printf("%f\n", det);
}

void gauss(double m[10][10]) {
    int i, j, k;

    for (k = 0; k < m_rows; k++) {
        double pivot = m[k][k];
        for (i = k+1; i < m_rows; i++) {
            double factor = m[i][k] / pivot;
            for (j = k; j < m_cols; j++) {
                m[i][j] -= (factor * m[k][j]);
            }
        }
    }

}

void solve_linear() {
    int i, j, k;
    double m[10][10];

    if (m_rows == 0 && m_cols == 0) {
        puts("No matrix defined!");
        return;
    }

    if (m_rows != (m_cols - 1)) {
        puts("Matrix format incorrect!");
        return;
    }

    for (i = 0; i < 10; i++) {
        for (j = 0; j < 10; j++) {
            m[i][j] = matrix[i][j];
        }
    }

    gauss(m);

    double det = 1;

    for (k = 0; k < m_rows; k++) {
        det *= m[k][k];
    }

    if (det == 0.0) {
        double indep = m[m_rows - 1][m_cols -1];
        if (indep == 0.0) {
            printf("SPI - The Linear System has infinitely many solutions\n");
        } else {
            printf("SI - The Linear System has no solution\n");
        }
    } else {
        double solution[10];

        for (i = 0; i < m_rows; i++) {
            solution[i] = m[i][m_rows];
        }

        for (i = m_rows - 1; i >= 0; i--) {
            for (j = i+1; j < m_rows; j++) {
                solution[i] -= (m[i][j] * solution[j]);
            }
            solution[i] /= m[i][i];
        }

        for (i = 0; i < m_rows; i++) {
            printf("%f\n", solution[i]);
        }
    }



}