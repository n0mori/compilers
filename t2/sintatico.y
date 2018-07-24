%{
    #include <stdio.h>
    #include <string.h>
    extern int yylex();
    extern int yylval();
    extern int integer;
    extern double real;

    //parametros do programa
    extern double h_view_lo;
    extern double h_view_hi;
    extern double v_view_lo;
    extern double v_view_hi;
    extern int integral_steps;

    //FILE *target;
    //int offset;
%}

/* tokens */

%token INTEGER
%token REAL
%token X
%token PLUS
%token MINUS
%token MULTIPLY
%token DIV
%token EXP
%token REM
%token L_PAREN
%token R_PAREN
%token SIN
%token COS
%token TAN
%token ABS

%start s

%%

s: 

%%

yyerror(char *s) {
}

int main() {
}