%option noyywrap
%option header-file="lex.yy.h"
%{

    #include <ast.h>
    #include <sintatico.tab.h>
    double real;
    int integer;
    int lexerr = 0;
%}

%%

[\n]                    {return BRK;}
[\r\t ]                 {}
[0-9]+                  {sscanf(yytext, "%d", &integer); return INTEGER;}
[0-9]+"."[0-9]+         {sscanf(yytext, "%lf", &real); return REAL;}
[xX]                    {return X;}
"+"                     {return PLUS;}
"-"                     {return MINUS;}
"*"                     {return MULTIPLY;}
"/"                     {return DIV;}
"^"                     {return EXP;}
"%"                     {return REM;}
"="                     {return ASSIGN;}
"("                     {return L_PAREN;}
")"                     {return R_PAREN;}
"sen"                   {return SEN;}
"cos"                   {return COS;}
"tan"                   {return TAN;}
"abs"                   {return ABS;}
":"                     {return COLON;}
";"						{return SEMICOLON;}
","						{return COMMA;}
"show"					{return SHOW;}
"settings"				{return SETTINGS;}
"reset"					{return RESET;}
"quit"					{return QUIT;}
"h_view"				{return HVIEW;}
"v_view"				{return VVIEW;}
"axis"                  {return AXIS;}
"set"                   {return SET;}
"on"					{return ON;}
"off"					{return OFF;}
"plot"					{return PLOT;}
"integral"				{return INTEGRAL;}
"steps"					{return STEPS;}
"integrate"				{return INTEGRATE;}
"integral_steps"        {return INTSTEPS;}
"matrix"				{return MATRIX;}
"["						{return L_SQUARE;}
"]"						{return R_SQUARE;}
"solve"                 {return SOLVE;}
"determinant"			{return DETERMINANT;}
"linear_system"			{return LINEAR_SYSTEM;}
"about"					{return ABOUT;}
.                       {printf("Simbolo Invalido -> %s\n", yytext); lexerr = 1;return 256;}

%%
