#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>
#include <stdarg.h>
#include <errno.h>


#define QUERY_SIZE 1024

#define BUFFER_SIZE 1024

static void error_fatal (char *format, ...)
{
  va_list arguments;
  va_start (arguments, format);
  vfprintf (stderr, format, arguments);
  va_end (arguments);
  exit (EXIT_FAILURE);
}

int main(int argc, char* argv[])
{
	MYSQL *connection;
	MYSQL_RES *result;
	MYSQL_ROW row;
	MYSQL_FIELD *field;
	
	int i;
	int opcija;
	int id_kolekcije;
	int id_kolekcije2;
	int god_kolekcije;
	int id_revije;
	int honorar;
	int id_haljine;
	int broj;
	int ptt;
	
	char odg[3];
	char odg1[3];
	char jmbg_modela[14];
	char ime_osobe[45];
	char prezime_osobe[45];
	char adresa_osobe[45];
	char telefon_osobe[45];
	char query[QUERY_SIZE];	
	char buffer[BUFFER_SIZE];
	
	double bmi;
	double obim;
	double tezina;
	double visina;
	
	
	connection = mysql_init(NULL);

	if(mysql_real_connect(connection, "localhost","root","MilosUna1903","modna_revija",0, NULL,0) == NULL)
		error_fatal ("Greska u konekciji. %s\n", mysql_error (connection));
	
	printf("Odaberite sta zelite:\n");
	printf("1. Spisak gostiju na odredjenoj reviji\n2. Spisak i informacije o reviji na kojima je predstavljena odredjena kolekcija\n3. Dostupne haljine za odredjenu kolekciju\n");
	printf("4. Unos novih modela, unajmljivanje modela, dodela haljina\n5. Promena mesta odrzavanja revije\n6. Spisak modela na odredjenoj reviji\n7. Izlaz\n");
	scanf("%d", &opcija);
	
	if(opcija == 1){
//=======================================================================================================================================================			
		printf("Unesite id revije za koju zelite spisak gostiju: ");
		scanf("%d", &id_revije);
		
		sprintf(query, "SELECT p.broj_stolice, o.ime AS `ime gosta`, o.prezime AS `prezime gosta`, o.jmbg AS `jmbg gosta` FROM Pozivnica p JOIN Gost g ON g.Osoba_jmbg = p.Gost_Osoba_jmbg JOIN Osoba o on o.jmbg = g.Osoba_jmbg WHERE p.Modna_revija_id = %d ORDER BY p.broj_stolice", id_revije);
		
		if (mysql_query (connection, query) != 0)
			error_fatal ("Greska u upitu %s\n", mysql_error (connection));
		
		result = mysql_use_result (connection);
		
		field = mysql_fetch_field (result);
		for(i = 0; i < mysql_field_count(connection); i++){
			printf("%-20s", field[i].name);
		}
		printf("\n");
		while ((row = mysql_fetch_row (result)) != 0){
			for(i = 0; i < mysql_field_count(connection); i++){	
				printf ("%-20s", row[i]);
			}
			printf ("\n");
		}

		mysql_free_result (result);
		
	}
	else if(opcija == 2){
//=======================================================================================================================================================			
		printf("Unesite id kolekcije za informacije o revijama na kojima je kolekcija predstavljana: ");
		scanf("%d", &id_kolekcije2);

		sprintf(query, "SELECT mo.ptt, mo.naziv AS `mesto odrzavanja`, mr.id AS `id revije`, o.ime AS `ime organizatora`, o.prezime AS `prezime organiz`, k.sezona AS `sezona kolekcije`, k.godina, h.id AS `id haljine`, o2.ime AS `ime dizajnera`, o2.prezime AS `prezime dizajnera` FROM Mesto_odrzavanja mo JOIN Modna_revija mr ON mr.Mesto_odrzavanja_ptt = mo.ptt JOIN Osoba o ON o.jmbg = mr.Organizator_Osoba_jmbg	JOIN Nosi n ON n.Unajmljuje_Modna_revija_id = mr.id JOIN Haljina h ON h.id = n.Haljina_id JOIN Kolekcija k ON k.id = h.Kolekcija_id JOIN Osoba o2 ON o2.jmbg = h.Dizajner_Osoba_jmbg WHERE k.id = %d;", id_kolekcije2);
		
		if (mysql_query (connection, query) != 0)
			error_fatal ("Greska u upitu %s\n", mysql_error (connection));
		
		result = mysql_use_result (connection);
		
		field = mysql_fetch_field (result);
		for(i = 0; i < mysql_field_count(connection); i++){
			printf("%-20s", field[i].name);
		}
		printf("\n");
		while ((row = mysql_fetch_row (result)) != 0){
			for(i = 0; i < mysql_field_count(connection); i++){	
				printf ("%-20s", row[i]);
			}
			printf ("\n");
		}

		mysql_free_result (result);
		
	}
	else if(opcija == 3){
//=======================================================================================================================================================	
		printf("Unesite id kolekcije i godinu kolekcije za informacije o haljinama dostupnim: ");
		scanf("%d %d", &id_kolekcije, &god_kolekcije);

		sprintf(query, "SELECT h.id AS `id haljine`, d.ime AS `ime dizajnera`, d.prezime AS `prezime dizajnera` FROM Haljina h JOIN Kolekcija k ON k.id = h.Kolekcija_id JOIN Osoba d ON d.jmbg = h.Dizajner_Osoba_jmbg WHERE k.id = %d AND k.godina = %d;", id_kolekcije, god_kolekcije);

		if (mysql_query (connection, query) != 0)
			error_fatal ("Greska u upitu %s\n", mysql_error (connection));

		result = mysql_use_result (connection);

		field = mysql_fetch_field (result);
		for(i = 0; i < mysql_field_count(connection); i++){
			printf("%-20s", field[i].name);
		}
		printf("\n");
		while ((row = mysql_fetch_row (result)) != 0){
			for(i = 0; i < mysql_field_count(connection); i++){	
				printf ("%-20s", row[i]);
			}
			printf ("\n");
		}

		mysql_free_result (result);
		
	}
	else if(opcija == 4){
		//=======================================================================================================================================================	
/*
Upit unosi novog modela u tabelu
INSERT INTO Osoba(jmbg, ime, prezime, adresa, telefon)
VALUES([jmbg],[ime],[prezime],[adresa],[telefon]);

INSERT INTO Model(Osoba_jmbg, bmi, obim, tezina, visina)
VALUES([jmbg],[bmi],[obim],[tezina],[visina]);
*/
	printf("Unesite jmbg modela:");
	scanf("%s", jmbg_modela);
	
	sprintf(query, "SELECT jmbg FROM Osoba o WHERE o.jmbg = '%s'", jmbg_modela);

	if (mysql_query (connection, query) != 0)
		error_fatal ("Greska u upitu %s\n", mysql_error (connection));

	result = mysql_use_result (connection);

	if(mysql_fetch_row(result) == NULL){
			//trazi samo info za osobu
			printf("Unesite ime i prezime: \n");
			scanf("%s %s",ime_osobe, prezime_osobe);
			
			printf("Unesite telefon: \n");
			scanf("%s", telefon_osobe);
			getchar();
			
			printf("Unesite adresu: \n");
			fgets(adresa_osobe, 45, stdin);
			
			sprintf(query, "INSERT INTO Osoba(jmbg, ime, prezime, adresa, telefon) VALUES('%s','%s','%s','%s','%s');", jmbg_modela, ime_osobe, prezime_osobe, adresa_osobe, telefon_osobe);

			if (mysql_query (connection, query) != 0)
				error_fatal ("Greska u upitu %s\n", mysql_error (connection));
			
	}
	mysql_free_result (result);
	
	sprintf(query, "SELECT Osoba_jmbg FROM Model o WHERE o.Osoba_jmbg = '%s'", jmbg_modela);

	if (mysql_query (connection, query) != 0)
		error_fatal ("Greska u upitu %s\n", mysql_error (connection));

	result = mysql_use_result (connection);
	
	if(mysql_fetch_row(result) == NULL ){
		printf("Unesite bmi obim tezinu i visinu: \n");
		scanf("%lf %lf %lf %lf", &bmi, &obim, &tezina, &visina);
		
		sprintf(query, "INSERT INTO Model(Osoba_jmbg, bmi, obim, tezina, visina) VALUES('%s',%lf,%lf,%lf,%lf);", jmbg_modela, bmi, obim, tezina, visina);

		if (mysql_query (connection, query) != 0)
			error_fatal ("Greska u upitu %s\n", mysql_error (connection));
		
		printf("Model uspesno unet!\n");
	}
	printf("Da li zelite da modela odmah unajmite za reviju? da/ne\n");
	scanf("%s", odg);
	
	if(strcmp(odg, "da") == 0){
		//unosimo u tabelu nosi 
		printf("Unesite id revije i honorar:\n");
		scanf("%d %d", &id_revije, &honorar);
		
		sprintf(query, "INSERT INTO Unajmljuje(Modna_revija_id, Model_Osoba_jmbg, honorar) VALUES(%d,'%s',%d);", id_revije,jmbg_modela,honorar);

		if (mysql_query (connection, query) != 0)
			error_fatal ("Greska u upitu %s\n", mysql_error (connection));
		
		printf("Model uspesno zaposlen na reviji!\n");
	}
	
	printf("Da li zelite da modelu dodelite jednu ili vise haljina koje ce nositi tokom revije? da/ne brojhaljina\n");
	scanf("%s %d", odg, &broj);
	
	if(strcmp(odg,"da") == 0){
		printf("Unesite id revije\n");
		scanf("%d", &id_revije);
		for(i = 0; i < broj; i++){
			printf("Unesite id postojece haljine: ");
			scanf("%d",&id_haljine);
			sprintf(query, "INSERT INTO Nosi(Unajmljuje_Model_Osoba_jmbg, Unajmljuje_Modna_revija_id, Haljina_id) VALUES ('%s',%d,%d);", jmbg_modela,id_revije, id_haljine);

			if (mysql_query (connection, query) != 0)
				error_fatal ("Greska u upitu %s\n", mysql_error (connection));
		}
	}
	
	mysql_free_result (result);
	
}
else if(opcija == 5){
//=======================================================================================================================================================	
	/*UPDATE Modna_revija SET Mesto_odrzavanja_ptt = [ptt];
	UPDATE Mesto_odrzavanja SET ptt = [ptt], adresa = [adresa], mesto = [mesto];*/
		printf("Unesite id modne revije ciju lokaciju zelite da promenite: \n");
		scanf("%d", &id_revije);
		printf("Unesite ptt mesta u kome zelite da se odrzava modna revija:\n");
		scanf("%d", &ptt);
		
		sprintf(query, "UPDATE Modna_revija SET Mesto_odrzavanja_ptt = %d WHERE id = %d;", ptt, id_revije);

			if (mysql_query (connection, query) != 0)
				error_fatal ("Greska u upitu %s\n", mysql_error (connection));
		
	
	
}
else if(opcija == 6){
	printf("Unesite id revije za koju zelite spisak modela: ");
	scanf("%d", &id_revije);
	
	sprintf(query, "SELECT o.ime AS `ime modela`, o.prezime AS `prezime modela`, o.jmbg AS `jmbg modela` FROM Model m JOIN Osoba o ON m.Osoba_jmbg = o.jmbg JOIN Unajmljuje u ON u.Model_Osoba_jmbg = m.Osoba_jmbg WHERE u.Modna_revija_id = %d", id_revije);
	
	if (mysql_query (connection, query) != 0)
		error_fatal ("Greska u upitu %s\n", mysql_error (connection));
	
	result = mysql_use_result (connection);
	
	field = mysql_fetch_field (result);
	for(i = 0; i < mysql_field_count(connection); i++){
		printf("%-20s", field[i].name);
	}
	printf("\n");
	while ((row = mysql_fetch_row (result)) != 0){
		for(i = 0; i < mysql_field_count(connection); i++){	
			printf ("%-20s", row[i]);
		}
		printf ("\n");
	}

	mysql_free_result (result);
}
else if(opcija == 7){
	mysql_close(connection);
	exit (EXIT_SUCCESS);
}
else{
	printf("Morate navesti neku validnu opciju!");
	mysql_close(connection);
	exit(EXIT_FAILURE);
}

	mysql_close(connection);

return 0;
}