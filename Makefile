DIR = modna_revija
PROGRAM = program.out
SRC = program.c
FLAGS = -g -Wall `mysql_config --cflags --libs`

.PHONY: all create trigger insert clean program

all: create trigger insert $(PROGRAM) 

$(PROGRAM): $(SRC)
	gcc $(SRC) -o $(PROGRAM) $(FLAGS)

create:
	mysql -u root -p < 'SQL script/skript.sql'
	
insert: trigger
	mysql -u root -p -D modna_revija < 'SQL script/insert.sql'
	
trigger:
	mysql -u root -p -D modna_revija < 'SQL script/trigger.sql'
	
clean:
	-rm -f *.mwb.bak