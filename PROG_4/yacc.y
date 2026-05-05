%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef char* str;

struct node {
    str op1, op2, res;
    char op;
} code[100];

int idx = -1;

/* temp generator */
str newTemp() {
    static int i = 0;
    str t = malloc(10);
    sprintf(t, "t%d", i++);
    return t;
}


str add(str op1, str op2, char op) {
    idx++;

    if(op == '=') {
        code[idx].op1 = op2;
        code[idx].op2 = NULL;
        code[idx].op = '=';
        code[idx].res = op1;
        return op1;
    }

    str temp = newTemp();

    code[idx].op1 = op1;
    code[idx].op2 = op2;
    code[idx].op = op;
    code[idx].res = temp;

    return temp;
}


/* TAC */
void print_TAC() {
    printf("\nThree Address Code:\n");
    for(int i=0;i<=idx;i++) {
        if(code[i].op == '=')
            printf("%s = %s\n", code[i].res, code[i].op1);
        else
            printf("%s = %s %c %s\n",
                code[i].res,
                code[i].op1,
                code[i].op,
                code[i].op2);
    }
}

/* Quadruples */
void print_quad() {
    printf("\nQuadruples:\n");
    printf("i\top\targ1\targ2\tres\n");
    for(int i=0;i<=idx;i++) {
        printf("%d\t%c\t%s\t%s\t%s\n",
            i,
            code[i].op,
            code[i].op1 ? code[i].op1 : "-",
            code[i].op2 ? code[i].op2 : "-",
            code[i].res);
    }
}

void print_triple() { 
    printf("\nTriples:\n"); 
    printf("i\top\targ1\targ2\n"); 
    for(int i=0;i<=idx;i++) 
    printf("%d\t%c\t%s\t%s\n", i, code[i].op, code[i].op1, code[i].op2? code[i].op2:"-"); 
    }

int yylex();

int yyerror() {
    //printf("Error\n");
    return 0;
}
%}

%union {
    char* str;
}

%token <str> ID NUM
%type <str> E

%right '='
%left '+' '-'
%left '*' '/'

%%

S : S E '\n'
  |
  ;

E : E '+' E { $$ = add($1,$3,'+'); }
  | E '-' E { $$ = add($1,$3,'-'); }
  | E '*' E { $$ = add($1,$3,'*'); }
  | E '/' E { $$ = add($1,$3,'/'); }
  | ID '=' E { $$ = add($1,$3,'='); }
  | '(' E ')' { $$ = $2; }
  | ID { $$ = $1; }
  | NUM { $$ = $1; }
  ;

%%

int main() {
    printf("Enter expression (end with newline):\n");
    yyparse();

    print_TAC();
    print_quad();
    print_triple();

    return 0;
}