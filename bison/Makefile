FLEX=flex
BISON=bison
CC=gcc

PROGRAMA = ajustador
LEXICO = lexico.l
SINTATICO = sintatico.y

$(PROGRAMA): $(LEXICO) $(SINTATICO)
	$(FLEX) $(LEXICO)
	$(BISON) -d -v $(SINTATICO)
	$(CC) -g -c *.c -I. 
	$(CC) *.o -lm -o $(PROGRAMA)

clean:
	rm -f *.yy.c
	rm -f *.tab.c
	rm -f *.tab.h
	rm -f *.o
	rm -f *.exe
