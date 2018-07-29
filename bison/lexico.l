%option noyywrap
%option header-file="lex.yy.h"
%{
    #include <sintatico.tab.h>
    #include <string.h>
    extern FILE *target;
%}
%%

[0-9]+  { yylval.num = atoi(yytext); return NUM; }
[ \t]	{ fprintf(target, "%s", yytext); }
"-->"   { yylval.str = strdup(yytext); return ARROW;}
":"     { yylval.str = strdup(yytext); return COLON; }
","     { yylval.str = strdup(yytext); return COMMA; }
\n      { yylval.str = strdup(yytext); return BRK; }
.	{ yylval.str = strdup(yytext); return OTHER; }

%%
