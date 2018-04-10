%option noyywrap

%%

"if" {puts("IF");}
[a-z][a-z0-9]* {printf("%s ID\n", yytext);}
(\.[0-9]+|[0-9]+\.[0-9]*) {printf("%s REAL\n", yytext);}
[0-9]+ {printf("%s NUM\n", yytext);}
"--"[a-z]*\n {
        int i;
        for (i = 0; i < strlen(yytext); i++) {
            if (yytext[i] != '\n') {
                printf("%c", yytext[i]);
            }
        }
        printf(" comment\n", yytext);
    }
[ \t\r] {puts("white space");}
\n
. {printf("%s error\n", yytext);}

%%

int main() {
    yylex();
    return 0;
}
