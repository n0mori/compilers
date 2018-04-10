%option noyywarp

%{
    int lines = 0;
    int blanks = 0;
    int wcomments = 0;
    int ml_comment = 0;
    int nbnc = 0;
    int semicolons = 0;
    int directives = 0;
%}

%%

["#include""define"] {directives++;}
\/\* {ml_comment = 1;}
\*\/ {ml_comment = 0; wcomments++;}
; {semicolons++;}

%%