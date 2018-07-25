#include <stdio.h>
#include "ast.h"
#include "settings.h"
#include "sintatico.tab.h"
#include "lex.yy.h"

int parsed = 0;

int main() {
    char l[1000];

    set_padroes();

    do {
        printf(">");
        fgets(l, 1000, stdin);

        YY_BUFFER_STATE buffer = yy_scan_string(l);
        
        yyparse();

        yy_delete_buffer(buffer);
    } while (!parsed);
}