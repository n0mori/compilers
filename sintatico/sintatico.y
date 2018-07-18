%{
    #include <stdio.h>
    extern int yylex();
    extern void prt();
    extern char* yytext;
    extern int yylineno;
    extern int open_comment;
    extern int line_open;
    extern int column_open;
    extern int column;
    extern int barran;
    int erro = 0;

    //FILE *target;
    //int offset;
%}

/* tokens */
%token VOID
%token INT
%token CHAR
%token RETURN
%token BREAK
%token SWITCH
%token CASE
%token DEFAULT
%token DO
%token WHILE
%token FOR
%token IF
%token ELSE
%token TYPEDEF
%token STRUCT
%token PLUS
%token MINUS
%token MULTIPLY
%token DIV
%token REMAINDER
%token INC
%token DEC
%token BITWISE_AND
%token BITWISE_OR
%token BITWISE_NOT
%token BITWISE_XOR
%token NOT
%token LOGICAL_AND
%token LOGICAL_OR
%token EQUAL
%token NOT_EQUAL
%token LESS_THAN
%token GREATER_THAN
%token LESS_EQUAL
%token GREATER_EQUAL
%token R_SHIFT
%token L_SHIFT
%token ASSIGN
%token ADD_ASSIGN
%token MINUS_ASSIGN
%token SEMICOLON
%token COMMA
%token COLON
%token L_PAREN
%token R_PAREN
%token L_CURLY_BRACKET
%token R_CURLY_BRACKET
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token TERNARY_CONDITIONAL
%token NUMBER_SIGN
%token POINTER
%token PRINTF
%token SCANF
%token DEFINE
%token EXIT
%token IDENTIFIER
%token NUM_HEXA
%token NUM_OCTAL
%token NUM_INTEGER
%token STRING
%token CHARACTER
%token ERRO

%start programa

%%

programa: tipo programa1 {}
        | NUMBER_SIGN DEFINE IDENTIFIER expression programap {}
;
programa1: vardeclarations programap {}
        | starp programa2 {}
;
programa2: prototypedeclarations programap {}
        |  function programap {}
;
programap: programa {}
        | {}
;
/*declarations:   NUMBER_SIGN DEFINE IDENTIFIER expression {}
            |   vardeclarations {}
            |   prototypedeclarations {}
;*/
function: IDENTIFIER parameters L_CURLY_BRACKET vardecp comandos R_CURLY_BRACKET {}
;
starp: MULTIPLY starp {}
        | {}
;
vardecp: tipo vardeclarations vardecp {}
        |  {}
;
vardeclarations: varbody varbodyp SEMICOLON {}
;
varbodyp: COMMA varbody varbodyp {}
            | {}
;
varbody: starp IDENTIFIER varexp varattr {}
;
varexp: L_SQUARE_BRACKET expression R_SQUARE_BRACKET varexp {}
        | {}
;
varattr: ASSIGN attribution {}
;
prototypedeclarations: IDENTIFIER parameters SEMICOLON {}
;
parameters: L_PAREN parbodyp R_PAREN {}
;
parbodyp: parbody parbodypp {}
            | {}
;
parbodypp: COMMA parbody parbodypp {}
            | {}
;
parbody: tipo starp IDENTIFIER varexp {}
;
tipo: INT {}
    |   CHAR {}
    |   VOID {}
;
bloco: L_CURLY_BRACKET comandos R_CURLY_BRACKET {}
;
comandos: listacomandos comandosp {}
;
comandosp: listacomandos comandosp {}
            | {}
;
listacomandos: DO bloco WHILE L_PAREN expression R_PAREN SEMICOLON {}
    | IF L_PAREN expression R_PAREN bloco elsep {}
    | WHILE L_PAREN expression R_PAREN bloco {}
    | FOR L_PAREN expnull SEMICOLON expnull SEMICOLON expnull R_PAREN bloco {}
    | PRINTF L_PAREN STRING commaexp {}
    | SCANF L_PAREN STRING COMMA BITWISE_AND IDENTIFIER R_PAREN SEMICOLON {}
    | EXIT L_PAREN expression R_PAREN SEMICOLON
    | RETURN expnull SEMICOLON
    | expression SEMICOLON
    | SEMICOLON
    | bloco
;
commaexp: COMMA expression {}
            | {}
;
expnull: expression {}
        |  {}
;
elsep: ELSE bloco {}
        | {}
;
expression: attribution expattrp {}
;
expattrp: COMMA attribution expattrp {}
            | {}
;
attribution: conditional {}
            |  unary attrsigns attribution{}
;
attrsigns:  ASSIGN {}
            | ADD_ASSIGN {}
            | MINUS_ASSIGN {}
;
conditional: logicor ternaryp {}
;
ternaryp: TERNARY_CONDITIONAL expression COLON conditional {}
            | {}
;
logicor: logicand logicorp {}
;
logicorp: LOGICAL_OR logicand logicorp {}
            | {}
;
logicand: orexpr logicandp {}
;
logicandp: LOGICAL_AND orexpr logicandp {}
            | {}
;
orexpr: xorexpr orexprp {}
;
orexprp: BITWISE_OR xorexpr orexprp {}
        |  {}
;
xorexpr: andexpr xorexprp {}
;
xorexprp: BITWISE_XOR andexpr xorexprp {}
        |   {}
;
andexpr: eqexpr andexprp {}
;
andexprp: BITWISE_AND eqexpr andexprp {}
        |   {}
;
eqexpr: relexpr eqexprp {}
;
eqexprp: EQUAL relexpr eqexprp {}
        |  NOT_EQUAL relexpr eqexprp {}
        |  {}
;
relexpr: shiftexpr relexprp {}
;
relsign:  LESS_THAN {}
        |   LESS_EQUAL {}
        |   GREATER_THAN {}
        |   GREATER_EQUAL {}
;
relexprp: relsign shiftexpr relexprp {}
            | {}
;
shiftexpr: addexpr shiftexprp {}
;
shiftexprp: L_SHIFT addexpr shiftexprp {}
            | R_SHIFT addexpr shiftexprp {}
            | {}
;
addexpr: mulexpr addexprp {}
;
addexprp: PLUS mulexpr addexprp {}
        |   MINUS mulexpr addexprp {}
;
mulexpr: castexpr mulexprp {}
;
mulsign:  MULTIPLY {}
        |   DIV {}
        |   REMAINDER {}
;
mulexprp: mulsign castexpr mulexprp {}
            | {}
;
castexpr: unary {}
        |   L_PAREN tipo starp R_PAREN castexpr {}
;
unarysign:  BITWISE_AND {}
            | MULTIPLY {}
            | PLUS {}
            | MINUS {}
            | BITWISE_NOT {}
            | NOT {}
;
unary:  postfix {}
        | INC unary {}
        | DEC unary {}
        | unarysign castexpr {}
;
postsign: L_SQUARE_BRACKET expression R_SQUARE_BRACKET {}
        |   INC {}
        |   DEC {}
        |   L_PAREN attribution postattr R_PAREN {}
;
postattr: COMMA attribution postattr {}
            | {}
;
postfix:  primexpr {}
        |   postfix
;
primexpr: IDENTIFIER {}
        |   numero {}
        |   CHARACTER {}
        |   STRING {}
        |   L_PAREN expression R_PAREN {}
;
numero: NUM_INTEGER {}
        | NUM_HEXA {}
        | NUM_OCTAL {}
;
%%

yyerror(char *s) {
    printf("error:syntax:%d:%d: %s", yylineno, column, yytext);
    erro = 1;
}

int main() {
    yyparse();
    if (!erro) {
            printf("SUCCESSFUL COMPILATION.");
    }
}