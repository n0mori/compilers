%option noyywrap
%option yylineno

%{

    #include <sintatico.tab.h>

    char *empty_str() {
        char *s = malloc(sizeof(char));
        *s = 0;
        return s;
    }

    int open_comment = 0;
    int line_open = 0;
    int column_open = 0;
    int column = 0;
    int barran = 0;
    int erro = 0;
    int lexerr = 0;
    int returned = 0;
    char *full_line;
    char *last_line;

    int prt() {
        if (!open_comment) {
            if (barran) {
                printf("\n");
            } else {
                barran = 1;
            }
            return 1;
        }
        return 0;
    }

    char *concatena(char *dest, char *src) {
        int len = strlen(dest) + strlen(src) + 3;
        char *aux = malloc(sizeof(char) * len);
        aux[0] = 0;
        strcat(aux, dest);
        strcat(aux, src);
        return aux;
    }

    char *copia(char *src) {
        int len = strlen(src);
        char *dest = malloc(sizeof(char) * len);
        strcpy(dest, src);
        return dest;
    }

    void putaria_das_coluna() {
        column += yyleng; full_line = concatena(full_line, yytext);
    }
%}


%%

"//".*\n { column = 0; last_line = copia(full_line); full_line = empty_str(); if (erro) return BARRAN; }
\/\*    { column_open = column + 1; full_line = concatena(full_line, yytext); column += yyleng; open_comment = 1; line_open = yylineno;}
\*\/    { putaria_das_coluna(); open_comment = 0;}
[ \t]   { putaria_das_coluna();}
[\n\r]  { column = 0; last_line = copia(full_line); full_line = empty_str(); if (erro) return BARRAN;}
void    { putaria_das_coluna(); if(!open_comment) return VOID;}
int     { putaria_das_coluna(); if(!open_comment) return INT;}
char    { putaria_das_coluna(); if(!open_comment) return CHAR;}
return  { putaria_das_coluna(); if(!open_comment) return RETURN;}
break   { putaria_das_coluna(); if(!open_comment) return BREAK;}
switch  { putaria_das_coluna(); if(!open_comment) return SWITCH;}
case    { putaria_das_coluna(); if(!open_comment) return CASE;}
default { putaria_das_coluna(); if(!open_comment) return DEFAULT;}
do      { putaria_das_coluna(); if(!open_comment) return DO;}
while   { putaria_das_coluna(); if(!open_comment) return WHILE;}
for     { putaria_das_coluna(); if(!open_comment) return FOR;}
if      { putaria_das_coluna(); if(!open_comment) return IF;}
else    { putaria_das_coluna(); if(!open_comment) return ELSE;}
typedef { putaria_das_coluna(); if(!open_comment) return TYPEDEF;}
struct  { putaria_das_coluna(); if(!open_comment) return STRUCT;}
"+"     { putaria_das_coluna(); if(!open_comment) return PLUS;}
-       { putaria_das_coluna(); if(!open_comment) return MINUS;}
\*      { putaria_das_coluna(); if(!open_comment) return MULTIPLY;}
\/      { putaria_das_coluna(); if(!open_comment) return DIV;}
%       { putaria_das_coluna(); if(!open_comment) return REMAINDER;}
"++"    { putaria_das_coluna(); if(!open_comment) return INC;}
"--"    { putaria_das_coluna(); if(!open_comment) return DEC;}
&       { putaria_das_coluna(); if(!open_comment) return BITWISE_AND;}
\|      { putaria_das_coluna(); if(!open_comment) return BITWISE_OR;}
~       { putaria_das_coluna(); if(!open_comment) return BITWISE_NOT;}
\^      { putaria_das_coluna(); if(!open_comment) return BITWISE_XOR;}
!       { putaria_das_coluna(); if(!open_comment) return NOT;}
&&      { putaria_das_coluna(); if(!open_comment) return LOGICAL_AND;}
"||"    { putaria_das_coluna(); if(!open_comment) return LOGICAL_OR;}
==      { putaria_das_coluna(); if(!open_comment) return EQUAL;}
!=      { putaria_das_coluna(); if(!open_comment) return NOT_EQUAL;}
"<"     { putaria_das_coluna(); if(!open_comment) return LESS_THAN;}
">"     { putaria_das_coluna(); if(!open_comment) return GREATER_THAN;}
"<="    { putaria_das_coluna(); if(!open_comment) return LESS_EQUAL;}
">="    { putaria_das_coluna(); if(!open_comment) return GREATER_EQUAL;}
">>"    { putaria_das_coluna(); if(!open_comment) return R_SHIFT;}
"<<"    { putaria_das_coluna(); if(!open_comment) return L_SHIFT;}
"="     { putaria_das_coluna(); if(!open_comment) return ASSIGN;}
"+="    { putaria_das_coluna(); if(!open_comment) return ADD_ASSIGN;}
"-="    { putaria_das_coluna(); if(!open_comment) return MINUS_ASSIGN;}
";"     { putaria_das_coluna(); if(!open_comment) return SEMICOLON;}
","     { putaria_das_coluna(); if(!open_comment) return COMMA;}
":"     { putaria_das_coluna(); if(!open_comment) return COLON;}
"("     { putaria_das_coluna(); if(!open_comment) return L_PAREN;}
")"     { putaria_das_coluna(); if(!open_comment) return R_PAREN;}
"{"     { putaria_das_coluna(); if(!open_comment) return L_CURLY_BRACKET;}
"}"     { putaria_das_coluna(); if(!open_comment) return R_CURLY_BRACKET;}
"["     { putaria_das_coluna(); if(!open_comment) return L_SQUARE_BRACKET;}
"]"     { putaria_das_coluna(); if(!open_comment) return R_SQUARE_BRACKET;}
"?"     { putaria_das_coluna(); if(!open_comment) return TERNARY_CONDITIONAL;}
#       { putaria_das_coluna(); if(!open_comment) return NUMBER_SIGN;}
->      { putaria_das_coluna(); if(!open_comment) return POINTER;}
printf  { putaria_das_coluna(); if(!open_comment) return PRINTF;}
scanf   { putaria_das_coluna(); if(!open_comment) return SCANF;}
define  { putaria_das_coluna(); if(!open_comment) return DEFINE;}
exit    { putaria_das_coluna(); if(!open_comment) return EXIT;}
[a-zA-Z_][0-9a-zA-Z_]*  { putaria_das_coluna(); if(!open_comment) return IDENTIFIER;}
0[xX][0-9A-Fa-f]*       { putaria_das_coluna(); if(!open_comment) return NUM_HEXA;}
0[0-7]+                 { putaria_das_coluna(); if(!open_comment) return NUM_OCTAL;}
[0-9]+                  { putaria_das_coluna(); if(!open_comment) return NUM_INTEGER;}
\".*\"  { putaria_das_coluna(); yytext[yyleng-1] = 0; if(!open_comment) return STRING;}
\'.*\'  { putaria_das_coluna(); yytext[yyleng-1] = 0; if(!open_comment) return CHARACTER;}
.       { putaria_das_coluna(); if (prt()) printf("error:lexical:%d:%d: %s", yylineno, column, yytext); lexerr = 1; if (!open_comment) return 256;}
<<EOF>> { if (open_comment) lexerr = 1; if (open_comment) printf("error:lexical:%d:%d: unterminated comment", line_open, column_open); yyterminate(); returned = 1; return 0;}

%%

/*
int main() {
    yylex();
    if (open_comment) {
        if (barran) {
            printf("\n");
        }
        printf("error:lexical:%d:%d: unterminated comment", line_open, column_open);
    }
}
*/