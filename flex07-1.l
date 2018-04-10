%option noyywrap

%%

"+" {puts(yytext);}
"-" {puts(yytext);}
[a-z][a-z0-9]* {puts(yytext);}
[0-9]+ {puts(yytext);}
[0-9]+e[+\-][0-9]+ {puts(yytext);}
\n
. {puts("ERRO");}

%%

int main() {
    yylex();
}