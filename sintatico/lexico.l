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
%}


%%

"//".*\n { column = 0; last_line = copia(full_line); full_line = empty_str(); if (erro) return BARRAN; }
\/\*    { column_open = column + 1; full_line = concatena(full_line, yytext); column += yyleng; open_comment = 1; line_open = yylineno;}
\*\/    { column += yyleng; full_line = concatena(full_line, yytext); open_comment = 0;}
[ \t]   { column += yyleng; full_line = concatena(full_line, yytext);}
[\n\r]  { column = 0; last_line = copia(full_line); full_line = empty_str(); if (erro) return BARRAN;}
void    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return VOID;}
int     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return INT;}
char    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return CHAR;}
return  { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return RETURN;}
break   { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return BREAK;}
switch  { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return SWITCH;}
case    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return CASE;}
default { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return DEFAULT;}
do      { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return DO;}
while   { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return WHILE;}
for     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return FOR;}
if      { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return IF;}
else    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return ELSE;}
typedef { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return TYPEDEF;}
struct  { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return STRUCT;}
"+"     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return PLUS;}
-       { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return MINUS;}
\*      { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return MULTIPLY;}
\/      { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return DIV;}
%       { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return REMAINDER;}
"++"    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return INC;}
"--"    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return DEC;}
&       { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return BITWISE_AND;}
\|      { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return BITWISE_OR;}
~       { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return BITWISE_NOT;}
\^      { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return BITWISE_XOR;}
!       { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return NOT;}
&&      { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return LOGICAL_AND;}
"||"    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return LOGICAL_OR;}
==      { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return EQUAL;}
!=      { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return NOT_EQUAL;}
"<"     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return LESS_THAN;}
">"     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return GREATER_THAN;}
"<="    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return LESS_EQUAL;}
">="    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return GREATER_EQUAL;}
">>"    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return R_SHIFT;}
"<<"    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return L_SHIFT;}
"="     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return ASSIGN;}
"+="    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return ADD_ASSIGN;}
"-="    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return MINUS_ASSIGN;}
";"     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return SEMICOLON;}
","     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return COMMA;}
":"     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return COLON;}
"("     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return L_PAREN;}
")"     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return R_PAREN;}
"{"     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return L_CURLY_BRACKET;}
"}"     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return R_CURLY_BRACKET;}
"["     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return L_SQUARE_BRACKET;}
"]"     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return R_SQUARE_BRACKET;}
"?"     { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return TERNARY_CONDITIONAL;}
#       { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return NUMBER_SIGN;}
->      { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return POINTER;}
printf  { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return PRINTF;}
scanf   { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return SCANF;}
define  { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return DEFINE;}
exit    { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return EXIT;}
[a-zA-Z_][0-9a-zA-Z_]*  { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return IDENTIFIER;}
0[xX][0-9A-Fa-f]*       { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return NUM_HEXA;}
0[0-7]+                 { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return NUM_OCTAL;}
[0-9]+                  { column += yyleng; full_line = concatena(full_line, yytext); if(!open_comment) return NUM_INTEGER;}
\".*\"  { column += yyleng; full_line = concatena(full_line, yytext); yytext[yyleng-1] = 0; if(!open_comment) return STRING;}
\'.*\'  { column += yyleng; full_line = concatena(full_line, yytext); yytext[yyleng-1] = 0; if(!open_comment) return CHARACTER;}
.       { column += yyleng; full_line = concatena(full_line, yytext); if (prt()) printf("error:lexical:%d:%d: %s", yylineno, column, yytext);}
<<EOF>> { if (open_comment) erro = 1; if (open_comment) printf("error:lexical:%d:%d: unterminated comment", line_open, column_open); yyterminate();}

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