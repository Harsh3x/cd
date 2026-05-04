%{
    #include "y.tab.h"
%}

%%


"int"|"float"|"char"|"void" {return TYPE;}

"return" {return RET;}

[a-zA-Z][a-zA-Z0-9_]* {return IDEN;}

[0-9]+ {return NUM;}

"#"        {return 0;}

[ \n\t] ;

. {return yytext[0];}
%%