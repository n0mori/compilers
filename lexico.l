%option noyywrap

%{
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
\/\*    { open_comment = 1; line_open = yylineno;}
\*\/    { open_comment = 0;}
[ \t]   { column += yyleng;}
\n      { column = 0;}
void    { column += yyleng; if (prt()) printf("VOID");}
int     { column += yyleng; if (prt()) printf("INT");}
char    { column += yyleng; if (prt()) printf("CHAR");}
return  { column += yyleng; if (prt()) printf("RETURN");}
break   { column += yyleng; if (prt()) printf("BREAK");}
switch  { column += yyleng; if (prt()) printf("SWITCH");}
case    { column += yyleng; if (prt()) printf("CASE");}
default { column += yyleng; if (prt()) printf("DEFAULT");}
do      { column += yyleng; if (prt()) printf("DO");}
while   { column += yyleng; if (prt()) printf("WHILE");}
for     { column += yyleng; if (prt()) printf("FOR");}
if      { column += yyleng; if (prt()) printf("IF");}
else    { column += yyleng; if (prt()) printf("ELSE");}
typedef { column += yyleng; if (prt()) printf("TYPEDEF");}
struct  { column += yyleng; if (prt()) printf("STRUCT");}
"+"     { column += yyleng; if (prt()) printf("PLUS");}
-       { column += yyleng; if (prt()) printf("MINUS");}
\*      { column += yyleng; if (prt()) printf("MULTIPLY");}
\/      { column += yyleng; if (prt()) printf("DIV");}
%       { column += yyleng; if (prt()) printf("REMAINDER");}
"++"    { column += yyleng; if (prt()) printf("INC");}
"--"    { column += yyleng; if (prt()) printf("DEC");}
&       { column += yyleng; if (prt()) printf("BITWISE_AND");}
\|      { column += yyleng; if (prt()) printf("BITWISE_OR");}
~       { column += yyleng; if (prt()) printf("BITWISE_NOT");}
\^      { column += yyleng; if (prt()) printf("BITWISE_XOR");}
!       { column += yyleng; if (prt()) printf("NOT");}
&&      { column += yyleng; if (prt()) printf("LOGICAL_AND");}
"||"    { column += yyleng; if (prt()) printf("LOGICAL_OR");}
==      { column += yyleng; if (prt()) printf("EQUAL");}
!=      { column += yyleng; if (prt()) printf("NOT_EQUAL");}
"<"     { column += yyleng; if (prt()) printf("LESS_THAN");}
">"     { column += yyleng; if (prt()) printf("GREATER_THAN");}
"<="    { column += yyleng; if (prt()) printf("LESS_EQUAL");}
">="    { column += yyleng; if (prt()) printf("GREATER_EQUAL");}
">>"    { column += yyleng; if (prt()) printf("R_SHIFT");}
"<<"    { column += yyleng; if (prt()) printf("L_SHIFT");}
"="     { column += yyleng; if (prt()) printf("ASSIGN");}
"+="    { column += yyleng; if (prt()) printf("ADD_ASSIGN");}
"-="    { column += yyleng; if (prt()) printf("MINUS_ASSIGN");}
";"     { column += yyleng; if (prt()) printf("SEMICOLON");}
","     { column += yyleng; if (prt()) printf("COMMA");}
":"     { column += yyleng; if (prt()) printf("COLON");}
"("     { column += yyleng; if (prt()) printf("L_PAREN");}
")"     { column += yyleng; if (prt()) printf("R_PAREN");}
"{"     { column += yyleng; if (prt()) printf("L_CURLY_BRACKET");}
"}"     { column += yyleng; if (prt()) printf("R_CURLY_BRACKET");}
"["     { column += yyleng; if (prt()) printf("L_SQUARE_BRACKET");}
"]"     { column += yyleng; if (prt()) printf("R_SQUARE_BRACKET");}
"?"     { column += yyleng; if (prt()) printf("TERNARY_CONDITIONAL");}
#       { column += yyleng; if (prt()) printf("NUMBER_SIGN");}
->      { column += yyleng; if (prt()) printf("POINTER");}
printf  { column += yyleng; if (prt()) printf("PRINTF");}
scanf   { column += yyleng; if (prt()) printf("SCANF");}
define  { column += yyleng; if (prt()) printf("DEFINE");}
exit    { column += yyleng; if (prt()) printf("EXIT");}
[a-zA-Z_][0-9a-zA-Z_]*  { column += yyleng; if (prt()) printf("IDENTIFIER(%s)", yytext);}
0[xX][0-9A-Fa-f]*       { column += yyleng; if (prt()) printf("NUM_HEXA(%s)", yytext);}
0[0-9]+                 { column += yyleng; if (prt()) printf("NUM_OCTAL(%s)", yytext);}
[0-9]+                  { column += yyleng; if (prt()) printf("NUM_INTEGER(%s)", yytext);}
\".*\"  { column += yyleng; yytext[yyleng-1] = 0; if (prt()) printf("STRING(%s)", yytext + 1);}
\'.*\'  { column += yyleng; yytext[yyleng-1] = 0; if (prt()) printf("CHARACTER(%s\b)", yytext + 1);}
.       { if (prt()) printf("error:lexical:%d:%d: %s", yylineno, column, yytext);}

%%


int main() {
    yylex();
    if (open_comment) {
        if (barran) {
            printf("\n");
        }
        printf("error:lexical:%d:%d: unterminated comment", line_open, column_open);
    }
}