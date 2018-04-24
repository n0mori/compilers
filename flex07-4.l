%option noyywrap

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

"#include" {directives++;}
"#define" {directives++;}
\/\* {ml_comment = 1;}
\*\/ {ml_comment = 0; wcomments++;}
\/\/.*\n {wcomments++;lines++;}
; {semicolons++;}
^[\ \t]*\n {blanks++; lines++;}
\n {
    lines++;
    if (ml_comment) {
        wcomments++;
    } else {
        nbnc++;
    }
}
. {}

%%

int main(int argc, char *argv[]) {
    int i;
    int arr[] = {0,0,0,0,0,0};

    puts("total    blank lines w/   nb, nc    semi- preproc. file");
    puts("lines    lines comments    lines   colons  direct.");
    puts("-----+--------+--------+--------+--------+--------+----");

    for (i = 1; i < argc; i++) {
        FILE *f = fopen(argv[i], "r");
        
        if (f == NULL) {
            continue;
        }

        lines = 0;
        blanks = 0;
        wcomments = 0;
        ml_comment = 0;
        nbnc = 0;
        semicolons = 0;
        directives = 0;

        yyset_in(f);
        yylex();
        fclose(f);

        arr[0] += lines;
        arr[1] += blanks;
        arr[2] += wcomments;
        arr[3] += nbnc;
        arr[4] += semicolons;
        arr[5] += directives;

        printf("%5d %8d %8d %8d %8d %8d %s\n", lines, blanks, wcomments, nbnc, semicolons, directives, argv[i]);

    }

    printf("%5d %8d %8d %8d %8d %8d %s\n", arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], "total");

}