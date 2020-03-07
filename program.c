/* Kaushik Nadimpalli
   CS3377.502
   Dr. Stephen Perkins
   Program Four  
   kxn160430@utdallas.edu
*/


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"

//#include "program.h"
// We intially included the above directory when just testing lexical scanning.
// The parser will automatically create an enum for us from y.tab.h

int yyparse(void);
int yylex(void);
extern char *yytext;

// we use command line arguments set and conditional statements.
int main(int argc, char** argv)
{
  int token;
  
  // if scanner is called, the statements in below if statement will execute.
  // and the scanning portion of the program will execute.
 if(strcmp(argv[0], "./scanner") == 0)
{

  token = yylex();

  printf("Operating in Scan mode\n");
  printf("\n ");

  while(token != 0)
    {
      switch(token)
	{
	case NAMETOKEN:
	  printf("yylex returned NAMETOKEN token (%s) \n", yytext);
	  break; 
	case IDENTIFIERTOKEN:
	  printf("yylex returned IDENTIFIERTOKEN token (%s) \n", yytext);
	  break;
	case NAME_INITIAL_TOKEN:
	  printf("yylex returned NAME_INITIAL_TOKEN token (%s) \n", yytext);
	  break;
	case ROMANTOKEN:
	  printf("yylex returned ROMANTOKEN token (%s) \n", yytext);
	  break;
	case SRTOKEN:
	  printf("yylex returned SRTOKEN token (%s) \n", yytext);
	  break;
	case JRTOKEN:
	  printf("yylex returned JRTOKEN token (%s) \n", yytext);
	  break;
	case EOLTOKEN:
	  printf("yylex returned EOLTOKEN (%d) token\n", EOLTOKEN);
	  break;
	case INTTOKEN:
	  printf("yylex returned INTTOKEN token (%s) \n", yytext);
	  break;
        case COMMATOKEN:
	  printf("yylex returned COMMATOKEN token (%s) \n", yytext);
	  break;
	case DASHTOKEN:
	  printf("yylex returned DASHTOKEN token (%s) \n", yytext);
	  break;
	case HASHTOKEN:
	  printf("yylex returned HASHTOKEN token (%s) \n", yytext);
	  break;
	default:
	  printf("UNKNOWN TOKEN\n");
	}

      token = yylex();
      // links tokens to yylex which will be represented in scan.l
    }
  printf("\n");  
  printf("Done with Scanner.\n");
  printf("\n");
  return 0;

 }

 // if parser is called, the statements in below if statement will execute.
 if(strcmp(argv[0], "./parser") == 0)
   {
     printf("Calling parser\n");
     printf("\n");
     
     switch(yyparse())
     {
     case 0:
       printf("Parsing was successful!\n");
       break;
     case 1:
       printf("Parsing has failed!\n");
       break;
     case 2:
       printf("Out of Memory Issue\n");
       break;
     default:
       printf("Unknown Result or Error from yyparse()\n");     
   }
     printf("\n");
     printf("Done with Parser.\n");
     printf("\n");
 }
  return 0;
}
