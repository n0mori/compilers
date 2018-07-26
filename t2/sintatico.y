%{
    #include <stdio.h>
    #include "ast.h"
    #include <string.h>
    #include "settings.h"
    #include "plotter.h"
    #include "integral.h"
    #include "matrix.h"
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

    extern int parsed;

    TreeNode *root = NULL;

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
%token AXIS
%token SET
%token ON
%token OFF
%token PLOT
%token INTEGRAL
%token INTSTEPS
%token STEPS
%token INTEGRATE
%token MATRIX
%token L_SQUARE
%token SOLVE
%token R_SQUARE
%token DETERMINANT
%token LINEAR_SYSTEM
%token ABOUT


%start s

%union {
    double value;
    int natural;
    TreeNode* ast;
}

%type<value> fvalue fvaluep REAL INTEGER
%type<natural> axisers ivalue sign
%type<ast> exp fator potencia termo function parexp

%%

s:  comando BRK {YYACCEPT;}
;
comando:    ABOUT SEMICOLON { printa_about();}
            |   QUIT {parsed = 1;}
            |   SHOW showers { }
            |   RESET SETTINGS SEMICOLON { set_padroes();}
            |   SET setters SEMICOLON { }
            |   PLOT plotter {}
            |   INTEGRATE L_PAREN fvalue COLON fvalue COMMA exp R_PAREN SEMICOLON { integral($3, $5, $7); }
            |   SOLVE solvers SEMICOLON {};
            |   exp { RPN_Walk($1); puts("");}
;
plotter:  SEMICOLON {   
                        if (!root) { 
                            puts("No Function defined!");
                        } else {
                            plot(root);
                        }
                    }
        | L_PAREN exp R_PAREN SEMICOLON {
            root = $2;
            if (root) {
                plot(root);
            }
        }
;
showers:  SETTINGS SEMICOLON { show_settings();}
        | MATRIX SEMICOLON {show_matrix();}
;
setters:  AXIS axisers {axis = $2;}
        | HVIEW fvalue COLON fvalue { set_h_view($2, $4); }
        | VVIEW fvalue COLON fvalue { set_v_view($2, $4); }
        | INTSTEPS ivalue { 
            if ($2 <= 0) {
                printf("ERROR: integral_steps must be a positive non-zero integer\n");
            } else { 
                integral_steps = $2;
            }
        }
;
solvers: DETERMINANT {solve_determinant();}
;
fvaluep:  INTEGER { $$ = ((double) integer); }
        | REAL { $$ = real ;}
;
fvalue:   sign fvaluep {$$ = $1 * $2;}
;
sign:     PLUS {$$ = 1;}
        | MINUS {$$ = -1;}
        | {$$ = 1;}
;
ivalue: sign INTEGER {$$ = integer;}
;
axisers:  ON {$$ = 1;}
        | OFF {$$ = 0;}
;
parexp: L_PAREN exp R_PAREN {$$ = $2;}
;
exp:    parexp {$$ = $1;}
    |   fator {$$ = $1;}
    |   exp PLUS fator {TreeNode *aux = create_node(PLUS, 0, $1, $3); $$ = aux;}
    |   exp MINUS fator {TreeNode *aux = create_node(MINUS, 0, $1, $3); $$ = aux;}
;
fator:  potencia {$$=$1;}
    |   fator MULTIPLY potencia {TreeNode *aux = create_node(MULTIPLY, 0, $1, $3); $$ = aux;}
    |   fator DIV potencia {TreeNode *aux = create_node(DIV, 0, $1, $3); $$ = aux;}
    |   fator REM potencia {TreeNode *aux = create_node(REM, 0, $1, $3); $$ = aux;}
;
potencia:   termo {$$ = $1;}
        |   potencia EXP termo {TreeNode *aux = create_node(EXP, 0, $1, $3); $$ = aux;}
;
termo:  fvaluep {TreeNode *aux = create_node(REAL, $1, NULL, NULL); $$ = aux; }
    |   function {$$ = $1;}
    |   X {TreeNode *aux = create_node(X, 0, NULL, NULL); $$ = aux;}
;
function:   SEN parexp {TreeNode *aux = create_node(SEN, 0, $2, NULL); $$ = aux;}
        |   COS parexp {TreeNode *aux = create_node(COS, 0, $2, NULL); $$ = aux;}
        |   TAN parexp {TreeNode *aux = create_node(TAN, 0, $2, NULL); $$ = aux;}
        |   ABS parexp {TreeNode *aux = create_node(ABS, 0, $2, NULL); $$ = aux;}
;
%%

int yyerror(char *s) {
    printf("tá errado: %s %d\n", yytext, yytext[0]);
}
