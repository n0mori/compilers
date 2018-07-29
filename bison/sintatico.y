%{
    #include <stdio.h>
    #include <string.h>
    #include "lex.yy.h"
    extern int yylex();
    int yyerror(char *s);
    extern char* yytext;

    FILE *target;
    int offset;

	int converte(int h, int m, int s, int mili) {
		long ts = mili;
		ts += 1000 * s;
		ts += 60 * 1000 * m;
		ts += 60 * 60 * 1000 * h;
		
		ts += offset;
		mili = ts % 1000;
		ts /= 1000;
		s = ts % 60;
		ts /= 60;
		m = ts % 60;
		ts /= 60;
		h = ts;
		fprintf(target, "%d:%d:%d,%d", h, m, s, mili);
	}
%}

%union {
    int num;
    char *str;
}

/* tokens */
%token ID
%token NUM
%token COLON
%token COMMA 
%token ARROW
%token OTHER
%token BRK

%start s

%type<num> NUM
%type<str> OTHER

%%

s: | id BRK time ARROW {fprintf(target, "-->");} time BRK {fprintf(target, "\n");} fodac BRK {fprintf(target, "\n");} s {}
;
id: NUM {fprintf(target, "%d\n", $1);}
;
time: NUM COLON NUM COLON NUM COMMA NUM {converte($1, $3, $5, $7);}
;
fodac: any BRK {fprintf(target,"\n");} fodacp
;
fodacp: | any BRK {fprintf(target,"\n");} fodacp
;
any: OTHER {fprintf(target, "%s", $1);} anyp 
   | COMMA {fprintf(target, ",");} anyp
   | COLON {fprintf(target, ":");} anyp
   | ARROW {fprintf(target, "-->");} anyp
   | NUM {fprintf(target, "%d", $1);} anyp
;
anyp: | OTHER {fprintf(target, "%s", $1);} anyp
   | COMMA {fprintf(target, ",");} anyp
   | COLON {fprintf(target, ":");} anyp
   | ARROW {fprintf(target, "-->");} anyp
   | NUM {fprintf(target, "%d", $1);} anyp
;
%%

int yyerror(char *s) {
}

int main(int argc, char *argv[]) {
    FILE *src = fopen(argv[1], "r");
    if (!src) {
        printf("arquivo de legenda a ser convertido não existe\n");
        return 1;
    }
	target = fopen(argv[3], "w+");
	if (!target) {
		return 1;
	}

	offset = atoi(argv[2]);

	yyset_in(src);
	yyparse();

	fclose(src);
	fclose(target);
}
