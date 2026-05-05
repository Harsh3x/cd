%{
#include "y.tab.h"
#include <string.h>
%}

%%
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.str = strdup(yytext); return ID; }
[0-9]+                  { yylval.str = strdup(yytext); return NUM; }

[-+*/=()]               return yytext[0];

[\n]                    return '\n';
[ \t]                   ;

%%

int yywrap() { return 1; }