%{
#include <stdio.h>
#include <stdlib.h>
int count = 0;
%}

%token FOR ID NUM

%%
S : S STMT
  | /* empty */
  ;

STMT : FOR '(' COND ';' COND ';' COND ')' BLOCK   { count++; }
     | ID ';'
     ;

BLOCK : '{' S '}'   
      | STMT        
      ;

COND : ID
     | ID '=' ID
     | ID '=' NUM
	 | ID '<' NUM
	 | ID '>' NUM
     | ID '<' ID
     | ID '>' ID
     | ID '<' '=' ID
     | ID '>' '=' ID
     | ID '+' '+'
     | ID '-' '-'
     | ID ID '=' NUM
     ;
%%

int main() {
    printf("Enter code (end with #):\n");
    yyparse();
    printf("For count = %d\n", count);
}

int yyerror() {
    printf("Invalid input\n");
    return 0;
}