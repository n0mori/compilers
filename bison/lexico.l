%option noyywrap
%{
    #include <sintatico.tab.h>
    #include <string.h>
%}
%%

[0-9]+  { yylval.num = atoi(yytext); return NUM; }
"-->"   { yylval.str = strdup(yytext); return ARROW;}
":"     { yylval.str = strdup(yytext); return COLON; }
"."     { yylval.str = strdup(yytext); return DOT; }
\n\n    { return EMPTY; }
\n      { yylval.str = strdup(yytext); return EOL; }
.*\n       { yylval.str = strdup(yytext); return OTHER; }

%%