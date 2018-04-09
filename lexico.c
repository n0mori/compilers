#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifndef LEN
#define LEN 128
#endif

void fill_array(int rows, int cols, int value, int array[rows][cols]) {
    int i, j;
    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            array[i][j] = value;
        }
    }
}

void fill_range(int size, int value, int start, int finish, int array[size]) {
    int i;
    for (i = start; i <= finish; i++) {
        array[i] = value;
    }
}

void print_array(int rows, int cols, int array[rows][cols]) {
    int i, j;
    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            printf("%d", array[i][j]);
        }
        puts("");
    }
}

void fill_alfabeto(int value, int array[LEN]) {
    fill_range(LEN, value, 'a', 'z', array);
}

void fill_number(int value, int array[LEN]) {
    fill_range(LEN, value, '0', '9', array);
}

char *empty_str() {
    char *str = malloc(sizeof(char));
    *str = 0;
    return str;
}

char *concatena(char *str, char c) {
    char *aux = malloc((strlen(str) + 2) * sizeof(char));
    strcpy(aux, str);
    aux[strlen(str)] = c;
    aux[strlen(str) + 1] = 0;
    free(str);
    return aux;
}

int state(int s) {
    return s - 1;
}

char *le_linha() {
    char *str = empty_str();
    while (1) {
        char c = getc(stdin);
        if (c == EOF) {
            break;
        } else {
            str = concatena(str, c);
        }
    }
    return str;
}

int main() {
    int automata[8][LEN];
    int finals[] = {0, 1, 1, 1, 1, 0, 0, 1};
    int i, j;
    int last_final, current_state;
    int start, lower, upper;
    char *str;
    
    fill_array(8, LEN, -1, automata);

    i = 0; // inicial = 1 - 1 (offset)
    automata[i]['+'] = 2;
    automata[i]['-'] = 3;
    fill_alfabeto(1, automata[i]);
    fill_number(4, automata[i]);
    
    i++; // 2 - 1 = 1
    fill_alfabeto(1, automata[i]);
    fill_number(1, automata[i]);
    
    i++; // 3 - 1 = 2

    i++; // 4 - 1 = 3

    i++; // 5 - 1 = 4
    automata[i]['e'] = 5;
    fill_number(4, automata[i]);

    i++; // 6 - 1 = 5
    automata[i]['+'] = 6;
    automata[i]['-'] = 6;
    fill_number(7, automata[i]);

    i++; // 7 - 1 = 6
    fill_number(7, automata[i]);
    
    i++; // 8 - 1 = 7
    fill_number(7, automata[i]);
    
    //print_array(8, LEN, automata);

    str = le_linha();

    start = 0;
    while (1) {
        if (!str[start]) {
            break;
        }

        current_state = 0;
        last_final = -1;
        upper = start;
        lower = start;

        while (1) {
            char c = str[lower++];

            if (c == '\n' || c == 0 || automata[current_state][c] == -1) {
                if (!finals[current_state]) {
                    if (last_final == -1) {
                        if (c != '\n') {
                            puts("ERRO");
                        }
                        upper = lower;
                    } else {
                        for (i = start; i < upper; i++) {
                            putchar(str[i]);
                        }
                        puts("");
                    }
                } else {
                    for (i = start; i < upper; i++) {
                        putchar(str[i]);
                    }
                    puts("");
                }
                break;
            }

            current_state = automata[current_state][c];
            if (finals[current_state]) {
                last_final = current_state;
                upper = lower;
            }

        }           

        start = upper;
    }

    free(str);
    return 0;
    
}