#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define LEN 256

void fill_array(int rows, int cols, int value, int arr[rows][cols]) {
    int i, j;
    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            arr[i][j] = value;
        }
    }
}

void fill_range(int length, int start, int end, int value, int arr[length]) {
    int i;
    for (i = start; i <= end; i++) {
        arr[i] = value;
    }
}

unsigned char *empty_str() {
    unsigned char *str = malloc(sizeof(unsigned char));
    *str = 0;
    return str;
}

unsigned char *concatena(char *str, char c) {
    unsigned char *aux = malloc((strlen(str) + 2) * sizeof(unsigned char));
    strcpy(aux, str);
    aux[strlen(str)] = c;
    aux[strlen(str) + 1] = 0;
    free(str);
    return aux;    
}

unsigned char* leitura() {
    int c;
    unsigned char *str = empty_str();
    while ((c = getc(stdin)) != EOF) {
        str = concatena(str, c);
    }
    return str;
}

void fill_number(int value, int arr[LEN]) {
    fill_range(LEN, '0', '9', value, arr);
}

int barran = 0;
void prt() {
    if (barran) {
        puts("");
    } else {
        barran = 1;
    }
}

int main() {
    int automata[22][LEN];
    int finals[] = {0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1};
    unsigned char *final_names[] = {
        "",
        "",
        "ELE",
        "",
        "",
        "ELA",
        "",
        "DELE",
        "",
        "DELA",
        "",
        "",
        "GATO",
        "CARRO",
        "GATOS",
        "CARROS",
        "MAIS",
        "MENOS",
        "INTEIRO",
        "",
        "",
        "REAL"
    };
    int i = 0;
    unsigned char *str = leitura();
    int start, upper, lower, last_final, current_state;

    fill_array(22, LEN, -1, automata);

    i = 0;
    automata[i]['+'] = 16;
    automata[i]['-'] = 17;
    fill_number(18, automata[i]);
    automata[i]['h'] = 1;
    automata[i]['s'] = 3;
    automata[i]['c'] = 10;
    
    i++; //1
    automata[i]['e'] = 2;
    automata[i]['i'] = 6;

    i++; //2
    automata[i]['r'] = 8;
    
    i++; //3
    automata[i]['h'] = 4;

    i++; //4
    automata[i]['e'] = 5;

    i++; //5
    
    i++; //6
    automata[i]['s'] = 7;

    i++; //7
    
    i++; //8
    automata[i]['s'] = 9;

    i++; //9

    i++; //10
    automata[i]['a'] = 11;

    i++; //11
    automata[i]['t'] = 12;
    automata[i]['r'] = 13;

    i++; //12
    automata[i]['s'] = 14;

    i++; //13
    automata[i]['s'] = 15;

    i++; //14
    
    i++; //15

    i++; //16

    i++; //17

    i++; //18
    fill_number(18, automata[i]);
    automata[i]['e'] = 19;

    i++; //19
    automata[i]['+'] = 20;
    automata[i]['-'] = 20;
    fill_number(21, automata[i]);

    i++; //20
    fill_number(21, automata[i]);

    i++; //21
    fill_number(21, automata[i]);

    start = 0;

    while (1) {
        if (!str[start]) {
            break;
        }

        current_state = 0;
        last_final = -1;
        upper = start;
        lower = start;

        while(1) {
            unsigned char c = str[lower++];

            if (c == '\n' || c == ' ' || !c || automata[current_state][c] == -1) {
                if (last_final == -1) {
                    if (start == upper && c != '\n' && c != ' ' && c != 0) {
                        prt();
                        fputs("ERRO", stdout);
                    } 
                    upper++;
                } else {
                    prt();
                    fprintf(stdout, "%s", final_names[last_final]);
                    if (last_final == 18 || last_final == 21) {
                        putc(' ', stdout);
                        for (i = start; i < upper; i++) {
                            putc(str[i], stdout);
                        }
                    }
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