/* Kaushik Nadimpalli
   CS3377.502
   Dr. Stephen Perkins
   Program Four
   kxn160430@utdallas.edu
*/

/* Below is necessary include directories we need
   for our parser file to work */

%{
  #include <stdio.h>
  int yylex(void);
  void yyerror(char const *st)
    {
      fprintf (stderr, "%s\n", st);
    } 
%}

/* we use a union to enumerate the data types of 
   the complex tokens we will be utilizing */
%union
{
  int val;
  char *str;
} 

/* below are the complex tokens and their type declarations */
%type  <str>  NAMETOKEN
%type  <str>  IDENTIFIERTOKEN
%type  <str>  NAME_INITIAL_TOKEN
%type  <str>  ROMANTOKEN
%type  <str>  SRTOKEN
%type  <str>  JRTOKEN
%type  <str>  EOLTOKEN
%type  <val> INTTOKEN
%type  <str>  COMMATOKEN
%type  <str>  DASHTOKEN
%type  <str> HASHTOKEN

%token  NAMETOKEN
%token  IDENTIFIERTOKEN
%token  NAME_INITIAL_TOKEN
%token  ROMANTOKEN
%token  SRTOKEN
%token  JRTOKEN
%token  EOLTOKEN
%token  INTTOKEN
%token  COMMATOKEN
%token  DASHTOKEN
%token  HASHTOKEN
%token  NEWLINE

%start  postal_addresses

 /* At this stage, we are going to use the Backus-Naur Form notation of U.S Postal Address
   We have to utilize and adhere to Bison formatting principles. This can be used with the 
   utilization of the yyerror reference types, and the unique tokens we attribute to each different
   parts of the postal addresses' information types */

%%

postal_addresses:
                         address_block EOLTOKEN postal_addresses
                |        address_block
                ;

address_block: 
                         name_part street_address location_part EOLTOKEN
	     ;

name_part:   
                         personal_part last_name suffix_part EOLTOKEN
	 |               personal_part last_name EOLTOKEN
      	 |               error EOLTOKEN                   {printf("Error, Bad Name...Now Skipping to newline\n"); yyerrok;}
         ;

personal_part: 
                        NAMETOKEN                    {fprintf(stderr,"<FirstName>%s</FirstName>\n", $1); }                
             |          NAME_INITIAL_TOKEN           {fprintf(stderr, "<FirstName>%s</FirstName>\n", $1); }
             ;        

last_name: 
                        NAMETOKEN                    {fprintf(stderr, "<LastName>%s</LastName>\n", $1); }
	 ;

suffix_part:  
                        SRTOKEN                      {fprintf(stderr, "<Suffix>%s</Suffix>\n", $1); }
           |            JRTOKEN                      {fprintf(stderr, "<Suffix>%s</suffix>\n", $1); }
           |            ROMANTOKEN                   {fprintf(stderr, "<Suffix>%s</Suffix>\n", $1); }
	   ;

street_address:       
                        street_number street_name INTTOKEN EOLTOKEN   {fprintf(stderr, "AptNum>%d</AptNum>\n", $3); } 
              |         street_number street_name HASHTOKEN INTTOKEN EOLTOKEN  {fprintf(stderr, "AptNum>%d</AptNum>\n", $4); }
              |         street_number street_name EOLTOKEN 
	      |	        error EOLTOKEN {printf("Error, Bad Street Name...Now Skipping to newline\n"); yyerrok;}     
	      ;

street_number:
                        INTTOKEN {fprintf(stderr, "<HouseNumber>%d</HouseNumber>\n", $1); }
             |          IDENTIFIERTOKEN {fprintf(stderr, "HouseNumber>%s</HouseNumber>\n", $1);}
	     ;

street_name: 
                        NAMETOKEN {fprintf(stderr, "StreetName>%s</StreetName>\n", $1); }
	   ;

location_part:      
                        town_name COMMATOKEN state_code zip_code EOLTOKEN
	     |          error EOLTOKEN{printf("Error, Bad Location Part...Now Skipping to newline\n"); yyerrok;} 
	     ;

town_name:             
                        NAMETOKEN {fprintf(stderr, "<City>%s</City>\n", $1); }
	 ;

state_code: 
                        NAMETOKEN  {fprintf(stderr, "State>%s</State>\n", $1); }
	  ;

zip_code: 
INTTOKEN DASHTOKEN INTTOKEN  {fprintf(stderr, "<Zip5>%d</Zip5>\n", $1); } {fprintf(stderr, "<Zip4>%d</Zip4>\n\n", $3);}
        |              INTTOKEN {fprintf(stderr, "<Zip5>%d</Zip5>\n\n", $1); }
	;

/* At this point, we have attributed all our complex tokens in the right style to the right, valid parts of the postal address
information. We attribute this information and link it in the scan.l file, so that the when the parser is run, output is written to
standard error if its not in correct format or to stdout the correct output. Furthermore, the information we put in scan.l will let us 
both scan and parse the input file when the parser is called. */
