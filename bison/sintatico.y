%{
    #include <stdio.h>
    extern int yylex();
    extern char* yytext;

    FILE *target;
    int offset;
%}

%union {
    int num;
    char *str;
}

/* tokens */
%token ID
%token NUM
%token COLON
%token DOT
%token ARROW
%token OTHER
%token EMPTY

%start s

%%

s: | id EOL time ARROW time EOL fodac BLANK s {}
;

fodac: | OTHER fodac { fprintf(target, "%s", $1); }
       | ARROW fodac { fprintf(target, "%s", $1); }
       | DOT fodac { fprintf(target, "%s", $1); }
       | COLON fodac { fprintf(target, "%s", $1); }
%%