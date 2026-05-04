%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%
"for"           return FOR;
[a-zA-Z][a-zA-Z0-9]*   return ID;
[0-9]+         return NUM;
"#"            return 0;   // end input
[\n \t]        ;
.              return yytext[0];
%%