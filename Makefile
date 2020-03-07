# Kaushik Nadimpalli
# CS3377
# Dr. Stephen Perkins
# Program Four Makefile
# kxn160430@utdallas.edu

# Implicit Rule Flags for C++

# We are using gcc because we are working with C files

CXX = gcc    
CXXFLAGS = 
CPPFLAGS = -Wall

# -Wall is a compiler flag that will be used for compilation purposes

# Implicit Rule Flags for Lex
LEX = /bin/flex
LFLAGS = 

# Implicit Rule Flags for Bison
YACC = /bin/bison
YFLAGS = -dy


PROJECTNAME = ProgramFour

EXECFILE = PostalAddressExecutable
#Our executable is named in accordance with the program goal

OBJS = parse.o scan.o program.o
#will compile and produce the following corressponding object files

all: $(EXECFILE)

#For better formatting purposes, we clean some files and only keep the important ones.
clean:
	rm -f $(OBJS) $(EXECFILE) y.tab.h scanner parser scan.c parse.c

$(EXECFILE): $(OBJS)
	$(CXX) -o $@ $(OBJS)
	ln -fs ./$@ scanner 
	ln -fs ./$@ parser

#Above are the symbolic links for the scanner which links it to input file
#Also above is symbolic link for parser which links it to input file
