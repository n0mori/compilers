#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define LENGTH 256

unsigned char* empty_str() {
	unsigned char* c  = malloc(sizeof(unsigned char));
	*c = 0;
	return c;
}

unsigned char* concatena(unsigned char *str, unsigned char c) {
	unsigned char *aux = malloc((strlen(str) + 2) * sizeof(unsigned char));
	strcpy(aux, str);
	aux[strlen(str)] = c;
	aux[strlen(str) + 1] = 0;
	free(str);
	return aux;	
}

unsigned char* input() {
	int c;
	unsigned char* str = empty_str();
	while ((c = getchar()) != EOF) {
		str = concatena(str, c);
	}
	return str;
}

void fill_array(int rows, int value, int array[rows][LENGTH]) {
	int i, j;
	for (i = 0; i < rows; i++) {
		for (j = 0; j < LENGTH; j++) {
			array[i][j] = value;
		}
	}
}

void fill_range(int start, int end, int value, int array[LENGTH]) {
	int i;
	for (i = start; i <= end; i++)
		array[i] = value;
}

void fill_number(int value, int array[LENGTH]) {
	fill_range('0', '9', value, array);
}

void fill_letter(int value, int array[LENGTH]) {
	fill_range('a', 'z', value, array);
}

int main() {
	unsigned char* str = input();
	int i;
	int start, upper, lower;
	int current_state, last_final;
	int arr[8][LENGTH];
	int finals[] = {0, 1, 1, 1, 1, 0, 0, 1};

	fill_array(8, -1, arr);

	i = 0;
	fill_number(4, arr[i]);
	fill_letter(1, arr[i]);
	arr[i]['+'] = 2;
	arr[i]['-'] = 3;

	i++; // i = 1;
	fill_number(1, arr[i]);
	fill_letter(1, arr[i]);

	i++; // i = 2;

	i++; // i = 3;

	i++; // i = 4;
	fill_number(4, arr[i]);
	arr[i]['e'] = 5;

	i++; // i = 5;
	arr[i]['+'] = 6;
	arr[i]['-'] = 6;
	fill_number(7, arr[i]);

	i++; // i = 6;
	fill_number(7, arr[i]);

	i++; // i = 7;
	fill_number(7, arr[i]);
	/*
	for (i = 0; i < 8; i++) {
		int j;
		for (j = 0; j < LENGTH; j++) {
			printf("%3d ", arr[i][j]);
		}
		puts("");
	}*/

	start = 0;
	int barran = 0;
	while (str[start]) {
		upper = start;
		lower = start;

		current_state = 0;
		last_final = -1;

		while (1) {

            unsigned char c = str[lower++];

            if (c == '\n' || c == ' ' || !c || arr[current_state][c] == -1) {
                if (last_final == -1) {
                    if (start == upper && c != '\n' && c != ' ' && c != 0) {
						if (barran) {
							fputs("\n", stdout);
						} else {
							barran = 1;
						}
						fputs("ERRO", stdout);
					} 
                    upper++;
                } else {
					if (barran) {
						fputs("\n", stdout);
					} else {
						barran = 1;
					}
					for (i = start; i < upper; i++) {
						putc(str[i], stdout);
					}
                }
                break;
            }            

            current_state = arr[current_state][c];
            if (finals[current_state]) {
                last_final = current_state;
                upper = lower;
            }
		}

		start = upper;
	}

	return 0;
}
