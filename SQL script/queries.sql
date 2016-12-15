/* Formulisati i navesti rečima bar 4 upita. Bar jedan upit mora aktivirati trigere kojima se menja stanje u bazi,
 bar jedan upit mora vršiti upis u bazu ili izmenu podataka u bazi i bar jedan upit mora vršiti čitanje iz baze. 
 
1.Dodela pozivnica gostima koji su vec u bazi.
2.Unos novih modela.
3.Unos ucestva modela na reviji i honorara koji za istu dobija.
4.Dodela haljine modelu.
5.Izdvajanje spiska gostiju za odredjenu reviju.
6.Izdvaja informacije o revijama na kojima se nosila odredjena kolekcija(gde se odrzava, koji dizajneri ucestvuju.
7.Izdvaja spisak haljina koje cine neku kolekciju koja je izasla odredjene godine . */


/*Upit dodeljuje gostu koji vec postoji u bazi mesto na odredjenoj reviji*/
INSERT INTO Pozivnica(tekst,Gost_Osoba_jmbg, Modna_revija_id)
VALUES ("Pozvani ste na reviju", [jmbg], [id_revije]);

/*Upit unosi novog modela u tabelu*/
INSERT INTO Osoba(jmbg, ime, prezime, adresa, telefon)
VALUES([jmbg],[ime],[prezime],[adresa],[telefon]);

INSERT INTO Model(Osoba_jmbg, bmi, obim, tezina, visina)
VALUES([jmbg],[bmi],[obim],[tezina],[visina]);

/*Upit unajmljuje modela za odredjenu reviju i honorar*/
INSERT INTO Unajmljuje(Modna_revija_id, Model_Osoba_jmbg, honorar)
VALUES([id],[jmbg],[honorar]);

/*Upit dodeljuje haljinu odredjenom modelu, kao i reviju na kojoj ce haljina biti nosena*/
INSERT INTO Nosi(Unajmljuje_Model_Osoba_jmbg, Unajmljuje_Modna_revija_id, Haljina_id)
VALUES ([jmbg],[id_r],[id_h]);

/*Upitom izdvajamo spisak gostiju u formatu: broj stolice, ime, prezime, jmbg gosta*/
SELECT p.broj_stolice, o.ime AS `ime gosta`, o.prezime AS `prezime gosta`, o.jmbg AS `jmbg gosta`
FROM Pozivnica p JOIN Gost g ON g.Osoba_jmbg = p.Gost_Osoba_jmbg
	JOIN Osoba o on o.jmbg = g.Osoba_jmbg
WHERE p.Modna_revija_id = [id_revije]
ORDER BY p.broj_stolice;


/*Upitom izdvajamo ptt mesta, naziv mesta, id revije, ime organizatora,id haljine, sezona i godina kolekcije, ime i prezime dizajnera, prema kolekciji koja je nosena tad*/
SELECT mo.ptt, mo.naziv AS `mesto odrzavanja`, mr.id AS `id revije`, o.ime AS `ime organizatora`, o.prezime AS `prezime organizatora`, k.sezona AS `sezona kolekcije`,
 k.godina, h.id AS `id haljine`, o2.ime AS `ime dizajnera`, o2.prezime AS `prezime dizajnera`
FROM Mesto_odrzavanja mo 
	JOIN Modna_revija mr ON mr.Mesto_odrzavanja_ptt = mo.ptt 
	JOIN Osoba o ON o.jmbg = mr.Organizator_Osoba_jmbg	
	JOIN Nosi n ON n.Unajmljuje_Modna_revija_id = mr.id 
	JOIN Haljina h ON h.id = n.Haljina_id
	JOIN Kolekcija k ON k.id = h.Kolekcija_id
	JOIN Osoba o2 ON o2.jmbg = h.Dizajner_Osoba_jmbg
WHERE k.id = 4;

/*Upit pravi spisak haljina koje pripadaju nekoj kolekciji koja je izasla odredjene godine i dizajnera koji ih je napravio*/
SELECT h.id AS `id haljine`, d.ime AS `ime dizajnera`, d.prezime AS `prezime dizajnera` 
FROM Haljina h 
	JOIN Kolekcija k ON k.id = h.Kolekcija_id
	JOIN Osoba d ON d.jmbg = h.Dizajner_Osoba_jmbg
WHERE k.id = [id] AND k.godina = [godina];

/*Upit menja mesto odrzavanja revije*/
UPDATE Modna_revija SET Mesto_odrzavanja_ptt = [ptt] WHERE id = [id_revije];
UPDATE Mesto_odrzavanja SET ptt = [ptt], adresa = [adresa], mesto = [mesto];