#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define LENGTH 256

enum terminals {
    LAMBDA,
    PROGRAM,
    ID,
    VAR,
    PROC,
    FUNC,
    BEGIN,
    END,
    ARRAY,
    OF,
    IF,
    THEN,
    ELSE,
    WHILE,
    DO,
    OR,
    DIV,
    AND,
    NUM,
    NOT,
    SEMICOLON,
    PERIOD,
    COLON,
    COMMA,
    DOTDOT,
    LSQUARE,
    RSQUARE,
    LPAR,
    RPAR,
    ASSIGN,
    EQUAL,
    NOTEQUAL,
    LESS,
    LESSEQUAL,
    MOREEQUAL,
    MORE,
    PLUS,
    MINUS,
    STAR,
    DOLLAR
};
char *names[] = {
    "",
    "program",
    "identificador",
    "var",
    "procedure",
    "function",
    "begin",
    "end",
    "array",
    "of",
    "if",
    "then",
    "else",
    "while",
    "do",
    "or",
    "div",
    "and",
    "numero",
    "not",
    ";",
    ".",
    ":",
    ",",
    "..",
    "[",
    "]",
    "(",
    ")",
    ":=",
    "=",
    "<>",
    "<",
    "<=",
    ">=",
    ">",
    "+",
    "-",
    "*",
    "$",
};

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
    fill_range('A', 'Z', value, arr);
}

void fill_id(int start, int end, int arr[85][LENGTH]) {
    int i;
    for (i = start; i <= end; i++) {
        fill_letter(84, arr[i]);
        fill_number(84, arr[i]);
    }

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

int main() {
    int arr[85][LENGTH];
    int finals[] = {0, 1, 1, 1, 1, 1, 1};
    int final_map[] = {};
    int i;
    int current_state, last_final, start, upper, lower;

    unsigned char *str = input();

    fill_array(84, LENGTH, -1, arr);

    i = 0;
    fill_letter(84, arr[i]);
    fill_number(83, arr[i]);

    arr[i]['p'] = 1;
    arr[i]['i'] = 14;
    arr[i]['v'] = 16;
    arr[i]['f'] = 19;
    arr[i]['b'] = 27;
    arr[i]['e'] = 32;
    arr[i]['a'] = 35;
    arr[i]['o'] = 42;
    arr[i]['t'] = 45;
    arr[i]['w'] = 52;
    arr[i]['d'] = 57;
    arr[i]['n'] = 61;

    arr[i]['P'] = 1;
    arr[i]['I'] = 14;
    arr[i]['V'] = 16;
    arr[i]['F'] = 19;
    arr[i]['B'] = 27;
    arr[i]['E'] = 32;
    arr[i]['A'] = 35;
    arr[i]['O'] = 42;
    arr[i]['T'] = 45;
    arr[i]['W'] = 52;
    arr[i]['D'] = 57;
    arr[i]['N'] = 61;

    arr[i][';'] = 64;
    arr[i]['.'] = 65;
    arr[i][':'] = 67;
    arr[i][','] = 68;
    arr[i]['['] = 69;
    arr[i][']'] = 70;
    arr[i]['('] = 71;
    arr[i][')'] = 72;
    arr[i]['='] = 74;
    arr[i]['<'] = 74;
    arr[i]['>'] = 78;
    arr[i]['+'] = 80;
    arr[i]['-'] = 81;
    arr[i]['*'] = 82;

    fill_id(1, 63, arr);

    i = 1;
    arr[i]['r'] = 2;
    arr[i]['R'] = 2;
    
    i = 2;
    arr[i]['o'] = 3;
    arr[i]['O'] = 3;

    i = 3;
    arr[i]['g'] = 4;
    arr[i]['G'] = 4;
    arr[i]['c'] = 8;
    arr[i]['C'] = 8;

    i = 4;
    arr[i]['r'] = 5;
    arr[i]['R'] = 5;

    i = 5;
    arr[i]['a'] = 6;
    arr[i]['A'] = 6;

    i = 6;
    arr[i]['m'] = 7;
    arr[i]['M'] = 7;

    i = 7;

    i = 8;
    arr[i]['e'] = 9;
    arr[i]['E'] = 9;

    i = 9;
    arr[i]['d'] = 10;
    arr[i]['D'] = 10;

    i = 10;
    arr[i]['u'] = 11;
    arr[i]['U'] = 11;

    i = 11;
    arr[i]['r'] = 12;
    arr[i]['R'] = 12;

    i = 12;
    arr[i]['e'] = 13;
    arr[i]['E'] = 13;

    i = 13;

    i = 14;
    arr[i]['f'] = 15;
    arr[i]['F'] = 15;

    i = 15;

    i = 16;
    arr[i]['a'] = 17;
    arr[i]['A'] = 17;

    i = 17;
    arr[i]['r'] = 18;
    arr[i]['R'] = 18;

    i = 18;

    i = 19;
    arr[i]['u'] = 20;
    arr[i]['U'] = 20;

    i = 20;
    arr[i]['n'] = 21;
    arr[i]['N'] = 21;

    i = 21;
    arr[i]['c'] = 22;
    arr[i]['C'] = 22;

    i = 22;
    arr[i]['t'] = 23;
    arr[i]['T'] = 23;

    i = 23;
    arr[i]['i'] = 24;
    arr[i]['I'] = 24;

    i = 24;
    arr[i]['o'] = 25;
    arr[i]['O'] = 25;

    i = 25;
    arr[i]['n'] = 26;
    arr[i]['N'] = 26;

    i = 26;

    i = 27;
    arr[i]['e'] = 28;
    arr[i]['E'] = 28;

    i = 28;
    arr[i]['g'] = 29;
    arr[i]['G'] = 29;

    i = 29;
    arr[i]['i'] = 30;
    arr[i]['I'] = 30;

    i = 30;
    arr[i]['n'] = 31;
    arr[i]['N'] = 31;

    i = 31;

    i = 32;
    arr[i]['n'] = 33;
    arr[i]['N'] = 33;
    arr[i]['l'] = 49;
    arr[i]['L'] = 49;

    i = 33;
    arr[i]['d'] = 34;
    arr[i]['D'] = 34;

    i = 34;

    i = 35;
    arr[i]['n'] = 36;
    arr[i]['N'] = 36;
    arr[i]['r'] = 38;
    arr[i]['R'] = 38;

    i = 36;
    arr[i]['d'] = 37;
    arr[i]['D'] = 37;

    i = 37;
    
    i = 38;
    arr[i]['r'] = 39;
    arr[i]['R'] = 39;

    i = 39;
    arr[i]['a'] = 40;
    arr[i]['A'] = 40;

    i = 40;
    arr[i]['y'] = 41;
    arr[i]['Y'] = 41;

    i = 41;

    i = 42;
    arr[i]['f'] = 43;
    arr[i]['F'] = 43;
    arr[i]['o'] = 44;
    arr[i]['O'] = 44;

    i = 43;

    i = 44;

    i = 45;
    arr[i]['h'] = 46;
    arr[i]['H'] = 46;

    i = 46;
    arr[i]['e'] = 47;
    arr[i]['E'] = 47;

    i = 47;
    arr[i]['n'] = 48;
    arr[i]['N'] = 48;

    i = 48;

    i = 49;
    arr[i]['s'] = 50;
    arr[i]['S'] = 50;

    i = 50;
    arr[i]['e'] = 51;
    arr[i]['E'] = 51;
    
    i = 51;

    i = 52;
    arr[i]['h'] = 52;
    arr[i]['H'] = 52;

    i = 53;
    arr[i]['i'] = 54;
    arr[i]['I'] = 54;

    i = 54;
    arr[i]['l'] = 55;
    arr[i]['L'] = 55;

    i = 55;
    arr[i]['e'] = 56;
    arr[i]['E'] = 56;

    i = 56;

    i = 57;
    arr[i]['o'] = 58;
    arr[i]['O'] = 58;
    arr[i]['i'] = 59;
    arr[i]['I'] = 59;

    i = 58;

    i = 59;
    arr[i]['v'] = 60;
    arr[i]['V'] = 60;

    i = 60;

    i = 61;
    arr[i]['o'] = 62;
    arr[i]['O'] = 62;

    i = 62;
    arr[i]['t'] = 63;
    arr[i]['T'] = 63;

    i = 64;

    i = 65;
    arr[i]['.'] = 66;

    i = 66;
    
    i = 67;
    arr[i]['='] = 73;

    i = 68;

    i = 69;

    i = 70;

    i = 71;

    i = 72;

    i = 73;

    i = 74;

    i = 75;
    arr[i]['>'] = 76;
    arr[i]['='] = 77;

    i = 76;

    i = 77;

    i = 78;
    arr[i]['='] = 79;

    i = 79;

    i = 80;

    i = 81;

    i = 82;

    i = 83;
    fill_number(83, arr[i]);

    i = 84;
    fill_number(84, arr[i]);
    fill_letter(84, arr[i]);

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