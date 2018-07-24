%option noyywrap

%{

    #include <sintatico.tab.h>
    double real;
    int integer;
%}

%%

\n              {return EOL;}
[0-9]+          {sscanf(yytext, "%d", &integer); ; return NUM;}
[0-9]+"."[0-9]+ {sscanf(yytext, "%lf", &real); return REAL;}
x               {return X;}
"+"             {return PLUS;}
"-"             {return DIV;}
"*"             {return MULTIPLY;}
"/"             {return DIV;}
"^"             {return EXP;}
"%"             {return REM;}
"("             {return L_PAREN;}
")"             {return R_PAREN;}
"sen"           {return SEN;}
"cos"           {return COS;}
"tan"           {return TAN;}
"abs"           {return ABS;}
.*              {return 256;}

%%