%option noyywrap
%option yylineno

%{

    #include <sintatico.tab.h>

    int open_comment = 0;
    int line_open = 0;
    int column_open = 0;
    int column = 0;
    int barran = 0;

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
%}


%%

"//".*\n { column = 0; }
\/\*    { column_open = column + 1; column += yyleng; open_comment = 1; line_open = yylineno;}
\*\/    { column += yyleng; open_comment = 0;}
[ \t]   { column += yyleng;}
[\n\r]  { column = 0;}
void    { column += yyleng; if(!open_comment) return VOID;}
int     { column += yyleng; if(!open_comment) return INT;}
char    { column += yyleng; if(!open_comment) return CHAR;}
return  { column += yyleng; if(!open_comment) return RETURN;}
break   { column += yyleng; if(!open_comment) return BREAK;}
switch  { column += yyleng; if(!open_comment) return SWITCH;}
case    { column += yyleng; if(!open_comment) return CASE;}
default { column += yyleng; if(!open_comment) return DEFAULT;}
do      { column += yyleng; if(!open_comment) return DO;}
while   { column += yyleng; if(!open_comment) return WHILE;}
for     { column += yyleng; if(!open_comment) return FOR;}
if      { column += yyleng; if(!open_comment) return IF;}
else    { column += yyleng; if(!open_comment) return ELSE;}
typedef { column += yyleng; if(!open_comment) return TYPEDEF;}
struct  { column += yyleng; if(!open_comment) return STRUCT;}
"+"     { column += yyleng; if(!open_comment) return PLUS;}
-       { column += yyleng; if(!open_comment) return MINUS;}
\*      { column += yyleng; if(!open_comment) return MULTIPLY;}
\/      { column += yyleng; if(!open_comment) return DIV;}
%       { column += yyleng; if(!open_comment) return REMAINDER;}
"++"    { column += yyleng; if(!open_comment) return INC;}
"--"    { column += yyleng; if(!open_comment) return DEC;}
&       { column += yyleng; if(!open_comment) return BITWISE_AND;}
\|      { column += yyleng; if(!open_comment) return BITWISE_OR;}
~       { column += yyleng; if(!open_comment) return BITWISE_NOT;}
\^      { column += yyleng; if(!open_comment) return BITWISE_XOR;}
!       { column += yyleng; if(!open_comment) return NOT;}
&&      { column += yyleng; if(!open_comment) return LOGICAL_AND;}
"||"    { column += yyleng; if(!open_comment) return LOGICAL_OR;}
==      { column += yyleng; if(!open_comment) return EQUAL;}
!=      { column += yyleng; if(!open_comment) return NOT_EQUAL;}
"<"     { column += yyleng; if(!open_comment) return LESS_THAN;}
">"     { column += yyleng; if(!open_comment) return GREATER_THAN;}
"<="    { column += yyleng; if(!open_comment) return LESS_EQUAL;}
">="    { column += yyleng; if(!open_comment) return GREATER_EQUAL;}
">>"    { column += yyleng; if(!open_comment) return R_SHIFT;}
"<<"    { column += yyleng; if(!open_comment) return L_SHIFT;}
"="     { column += yyleng; if(!open_comment) return ASSIGN;}
"+="    { column += yyleng; if(!open_comment) return ADD_ASSIGN;}
"-="    { column += yyleng; if(!open_comment) return MINUS_ASSIGN;}
";"     { column += yyleng; if(!open_comment) return SEMICOLON;}
","     { column += yyleng; if(!open_comment) return COMMA;}
":"     { column += yyleng; if(!open_comment) return COLON;}
"("     { column += yyleng; if(!open_comment) return L_PAREN;}
")"     { column += yyleng; if(!open_comment) return R_PAREN;}
"{"     { column += yyleng; if(!open_comment) return L_CURLY_BRACKET;}
"}"     { column += yyleng; if(!open_comment) return R_CURLY_BRACKET;}
"["     { column += yyleng; if(!open_comment) return L_SQUARE_BRACKET;}
"]"     { column += yyleng; if(!open_comment) return R_SQUARE_BRACKET;}
"?"     { column += yyleng; if(!open_comment) return TERNARY_CONDITIONAL;}
#       { column += yyleng; if(!open_comment) return NUMBER_SIGN;}
->      { column += yyleng; if(!open_comment) return POINTER;}
printf  { column += yyleng; if(!open_comment) return PRINTF;}
scanf   { column += yyleng; if(!open_comment) return SCANF;}
define  { column += yyleng; if(!open_comment) return DEFINE;}
exit    { column += yyleng; if(!open_comment) return EXIT;}
[a-zA-Z_][0-9a-zA-Z_]*  { column += yyleng; if(!open_comment) return IDENTIFIER;}
0[xX][0-9A-Fa-f]*       { column += yyleng; if(!open_comment) return NUM_HEXA;}
0[0-7]+                 { column += yyleng; if(!open_comment) return NUM_OCTAL;}
[0-9]+                  { column += yyleng; if(!open_comment) return NUM_INTEGER;}
\".*\"  { column += yyleng; yytext[yyleng-1] = 0; if(!open_comment) return STRING;}
\'.*\'  { column += yyleng; yytext[yyleng-1] = 0; if(!open_comment) return CHARACTER;}
.       { column += yyleng; if (prt()) printf("error:lexical:%d:%d: %s", yylineno, column, yytext);}

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