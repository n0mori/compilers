%option noyywrap

%%

(aba)+ {printf("%s action 1\n", yytext);}
ab*a {printf("%s action 2\n", yytext);}
[ab] {printf("%s action 3\n", yytext);}

%%

int main() {
    yylex();
    return 0;
}