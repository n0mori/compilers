%{
    #include <stdio.h>
    #include <string.h>
    #include <settings.h>
    extern int yylex();
    //extern int yylval();
    extern char *yytext;
    extern int integer;
    extern double real;

    //parametros do programa
    extern double h_view_lo;
    extern double h_view_hi;
    extern double v_view_lo;
    extern double v_view_hi;
    extern int integral_steps;

    extern int axis;

    int parsed = 0;

    //FILE *target;
    //int offset;

    void printa_about() {
        printf("+-----------------------------------------------+\n");
        printf("|                                               |\n");
        printf("|    Nicolas Jashchenko Omori - 201600560295    |\n");
        printf("|                                               |\n");
        printf("+-----------------------------------------------+\n");
    }

%}

/* tokens */

%token BRK
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
%token SEN
%token COS
%token TAN
%token ABS
%token SEMICOLON
%token COLON
%token COMMA 
%token SHOW
%token SETTINGS
%token RESET
%token QUIT
%token HVIEW
%token VVIEW
%token ON
%token OFF
%token PLOT
%token INTEGRAL
%token STEPS
%token INTEGRATE
%token MATRIX
%token L_SQUARE
%token R_SQUARE
%token DETERMINANT
%token LINEAR_SYSTEM
%token ABOUT


%start s

%%

s:  comando {YYACCEPT;}
;
comando:    ABOUT SEMICOLON { printa_about();}
            |   QUIT {parsed = 1;}
;
%%

yyerror(char *s) {
    printf("tá errado: %s", yytext);
}

int main() {

    set_padroes();

    do {
        printf(">");
        yyparse();
    } while (!parsed);
}