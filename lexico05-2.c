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
    int last_final, current_state;
    int start, upper, lower;
    int i = 0;

    fill_array(13, LENGTH, -1, automata);

    // i = 0;
    fill_letter(LENGTH, 3, &automata[i]);
    fill_number(LENGTH, 6, &automata[i]);
    automata[i]['.'] = 4;
    automata[i]['i'] = 1;


    return 0;
}