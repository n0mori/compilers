#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define LENGTH 256

void fill_array(int rows, int cols, int value, int array[rows][cols]) {
    int i, j;
    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            array[i][j] = value;
        }
    }
}

void fill_range(int len, int start, int end, int value, int array[len]) {
    int i;
    for (i = start; i <= end; i++) {
        array[i] = value;
    }
}

unsigned char *empty_str() {
    unsigned char *str = malloc(sizeof(unsigned char));
    *str = 0;
    return str;
}

unsigned char *concatena(unsigned char *str, unsigned char c) {
    unsigned char *aux = malloc((strlen(str) + 2) * sizeof(unsigned char));
    strcpy(aux, str);
    aux[strlen(str)] = c;
    aux[strlen(str) + 1] = 0;
    free(str);
    return aux;
}

void fill_number(int len, int value, int array[len]) {
    fill_range(len, '0', '9', value, array);
}

void fill_letter(int len, int value, int array[len]) {
    fill_range(len, 'a', 'z', value, array);
}

void fill_line(int len, int value, int array[len]) {
    fill_range(len, 0, 255, value, array);
}

unsigned char *reader() {
    unsigned char *str = empty_str();
    int c;
    while((c = getc(stdin)) != EOF) {
        str = concatena(str, c);
    }
    return str;
}

int main() {
    unsigned char *str = reader();
    int automata[13][LENGTH];
    int finals[] = {0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1};
    char *final_names[] = {
        "",
        "ID",
        "IF",
        "ID",
        "error",
        "REAL",
        "NUM",
        "REAL",
        "error",
        "",
        "comment",
        "white space",
        "error"
    };
    int last_final, current_state;
    int start, upper, lower;
    int i = 0;

    fill_array(13, LENGTH, -1, automata);

    // i = 0;
    fill_line(LENGTH, 12, automata[i]);
    fill_letter(LENGTH, 3, automata[i]);
    fill_number(LENGTH, 6, automata[i]);
    automata[i]['.'] = 4;
    automata[i]['i'] = 1;
    automata[i]['-'] = 8;
    automata[i][' '] = 11;
    automata[i]['\t'] = 11;

    i++; // i = 1;
    fill_letter(LENGTH, 3, automata[i]);
    fill_number(LENGTH, 3, automata[i]);
    automata[i]['f'] = 2;

    i++; // i = 2;
    fill_letter(LENGTH, 3, automata[i]);
    fill_number(LENGTH, 3, automata[i]);

    i++; // i = 3;
    fill_letter(LENGTH, 3, automata[i]);
    fill_number(LENGTH, 3, automata[i]);

    i++; // i = 4;
    fill_number(LENGTH, 5, automata[i]);

    i++; // i = 5;
    fill_number(LENGTH, 5, automata[i]);

    i++; // i = 6;
    fill_number(LENGTH, 6, automata[i]);
    automata[i]['.'] = 7;

    i++; // i = 7;
    fill_number(LENGTH, 7, automata[i]);
    
    i++; // i = 8;
    automata[i]['-'] = 9;

    i++; // i = 9;
    fill_letter(LENGTH, 9, automata[i]);
    automata[i]['\n'] = 10;

    i++; // i = 10;

    i++; // i = 11;
    automata[i][' '] = 11;
    automata[i]['\t'] = 11;

    i++; // i = 12;

    start = 0;

    while (str[start]) {

        upper = start;
        lower = start;
        current_state = 0;
        last_final = -1;

        while (1) {
            unsigned char c = str[lower++];

            if (!c || c == '\n' || automata[current_state][c] == -1) {
                if ((c == '\n' || !c) && start == upper) {
                    upper++;
                    break;
                } else if (automata[current_state][c] == -1) {
                    if (last_final != 11) {
                        for (i = start; i < upper; i++) {
                            if (str[i] != '\n') {
                                fputc(str[i], stdout);
                            }
                        }
                        fputc(' ', stdout);
                    }
                    fprintf(stdout, "%s\n", final_names[last_final]);
                    break;
                }
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