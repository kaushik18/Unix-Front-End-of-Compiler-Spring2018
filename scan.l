/* Kaushik Nadimpalli
 * Program Four
 * CS3377.502
 * Dr. Stephen Perkins
 * kxn160430@utdallas.edu
 */


%option noyywrap
%option nounput
%option noinput

%{
  #include <stdlib.h>
  #include "y.tab.h"
%}

/* Below, we are linking and returning correct output based on scanning input we got from input file */


%%

[ \t\r]+                       {  /*whitespace*/ }
"Sr"                           {yylval.str = yytext; return SRTOKEN; }
"Jr"                           {yylval.str = yytext; return JRTOKEN; }
","                            {yylval.str = yytext; return COMMATOKEN; }
"-"                            {yylval.str  = yytext; return DASHTOKEN; }
"#"                            {yylval.str  = yytext; return HASHTOKEN; }
[\n]                           {yylval.str  = yytext; return EOLTOKEN; }                                                
[0-9]+                         {yylval.val = atoi(yytext); return INTTOKEN; } 
[a-z|A-Z]{2,}                  {yylval.str  = yytext; return NAMETOKEN; }
[IVXLCDM]+                     {yylval.str  = yytext; return ROMANTOKEN; }
[0-9][A-Z|a-z]+                {yylval.str  = yytext; return IDENTIFIERTOKEN; }
[A-Z]\.?                       {yylval.str  = yytext; return NAME_INITIAL_TOKEN; }

%%

/* Above is a representation of regular expressions and the tokenized input they return
  * The regular expressions let us match the input information to the correct tokens to return
  * the correct output
*/
