#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define LENGTH 256

enum terminals {NOT, DOLLAR, LPAR, RPAR, PLUS, STAR, ID};
char *names[] = {"", "$ ", "( ", ") ", "+ ", "* ", "id "};

void fill_array(int rows, int cols, int value, int arr[rows][cols]) {
    int i, j;
    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            arr[i][j] = value;
        }
    }
}

void fill_range(int start, int end, int value, int arr[LENGTH]) {
    int i;
    for (i = start; i <= end; i++) {
        arr[i] = value;
    }
}

void fill_number(int value, int arr[LENGTH]) {
    fill_range('0', '9', value, arr);
}

void fill_letter(int value, int arr[LENGTH]) {
    fill_range('a', 'z', value, arr);
}

unsigned char *empty_str() {
    unsigned char *str = malloc(sizeof(unsigned char));
    *str = 0;
    return str;
}

unsigned char *concatena(unsigned char *str, unsigned char c) {
    unsigned char *aux = malloc(sizeof(unsigned char) * (strlen(str) + 2));
    strcpy(aux, str);
    aux[strlen(str)] = c;
    aux[strlen(str) + 1] = 0;
    free(str);
    return aux;
}

unsigned char *input() {
    int c;
    unsigned char *str = empty_str();
    while ((c = getchar()) != EOF) {
        str = concatena(str, c);
    }
    return str;
}

int barran = 0;
void prt() {
    if (!barran) {
        barran = 1;
    } else {
        puts("");
    }
}

unsigned char *tokens;

void advance() {
    tokens++;
}

int err = 0;

void error() {
    err = 1;
}

void eat(int value) {
    if (*tokens == value) {
        advance();
    } else {
        error();
    }
}


void S();
void E();
void E_PRIME();
void T();
void T_PRIME();
void F();

int main() {
    int arr[7][LENGTH];
    int finals[] = {0, 1, 1, 1, 1, 1, 1};
    int i;
    int current_state, last_final, start, upper, lower;

    fill_array(7, LENGTH, -1, arr);

    i = 0;
    arr[i]['$'] = 1;
    arr[i]['('] = 2;
    arr[i][')'] = 3;
    arr[i]['+'] = 4;
    arr[i]['*'] = 5;
    fill_letter(6, arr[i]);

    i = 6;
    fill_letter(6, arr[i]);
    fill_number(6, arr[i]);

    unsigned char *str = input();

    tokens = empty_str();
    start = 0;
    int parse = 0;
    while (str[start] || str[start-1]) {
        parse = 0;

        upper = start;
        lower = start;

        last_final = -1;
        current_state = 0;


        while (1) {
            unsigned char c = str[lower++];

            if (arr[current_state][c] == -1) {
                if (last_final == -1) {
                    if (start == upper && c && c != ' ' && c != '\n') {
                        prt();
                        printf("ERRO LEXICO: %c", c);
                        while (c && c != '\n') {
                            c = str[lower++];
                            upper = lower - 1;
                        }
                    } else {
                        if (c == '\n' || c == 0) {
                            parse = 1;
                        }
                    }
                    upper++;
                } else {
                    tokens = concatena(tokens, last_final);
                }
                break;
            }

            current_state = arr[current_state][c];
            if (finals[current_state]) {
                last_final = current_state;
                upper = lower;
            }

        }

        if (parse) {
            unsigned char* aux = tokens;
            /*
            int j;
            for (j = 0; j < strlen(tokens); j++) {
                printf("%d ", tokens[j]);
            }
            */

            err = 0;
            S();
            free(aux);
            tokens = empty_str();
        }

        start = upper;

    }

}

void S() {
    unsigned char tok = *tokens;
    switch (tok) {
        case ID: 
            E(); eat(DOLLAR); if (!err) { prt(); printf("CADEIA ACEITA"); } else { prt(); printf("ERRO SINTATICO EM: %sESPERADO: )", names[tok]); } break;
        case LPAR: 
            E(); eat(DOLLAR); if (!err) { prt(); printf("CADEIA ACEITA"); } else { prt(); printf("ERRO SINTATICO EM: %sESPERADO: $", names[tok]); } break;
        default: 
            prt(); printf("ERRO SINTATICO EM: %sESPERADO: id, (", names[tok]); error();
    }
}

void E() {
    unsigned char tok = *tokens;
    switch (tok) {
        case ID: T(); E_PRIME(); break;
        case LPAR: T(); E_PRIME(); break;
        default: if (!err) { prt(); printf("ERRO SINTATICO EM: %sESPERADO: id, (", names[tok]); } error();
    }
}

void E_PRIME() {
    unsigned char tok = *tokens;
    switch (tok) {
        case PLUS: eat(PLUS); T(); E_PRIME(); break;
        case RPAR: break;
        case DOLLAR: break;
        default: if (!err) { prt(); printf("ERRO SINTATICO EM: %sESPERADO: +, ), $", names[tok]); } error();
    }
}

void T() {
    unsigned char tok = *tokens;
    switch (tok) {
        case ID: F(); T_PRIME(); break;
        case LPAR: F(); T_PRIME(); break;
        default: if (!err) { prt(); printf("ERRO SINTATICO EM: %sESPERADO: id, (", names[tok]); } error();
    }
}

void T_PRIME() {
    unsigned char tok = *tokens;
    switch (tok) {
        case PLUS: break;
        case STAR: eat(STAR); F(); T_PRIME(); break;
        case RPAR: break;
        case DOLLAR: break;
        default: if (!err) { prt(); printf("ERRO SINTATICO EM: %sESPERADO: +, *, ), $", names[tok]); } error();
    }
}

void F() {
    unsigned char tok = *tokens;
    switch (tok) {
        case ID: eat(ID); break;
        case LPAR: eat(LPAR); E(); eat(RPAR); break;
        default: if (!err) { prt(); printf("ERRO SINTATICO EM: %sESPERADO: id, (", names[tok]); } error();
    }
}