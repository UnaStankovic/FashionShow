/*1. Za svaku haljinu, vodi se evidencija koliko puta je ta haljina puta nošena. Pri unosu u tabelu Nosi uvećava se broj nošenja u tabeli Haljina.
2. Prilikom dodavanja novog unosa u tabelu pozivnica svakom gostu se automatski dodeljuje redni broj stolice tako što se uvećava 
najveći do tada broj stolice dodavanjem broja 1 (podrazumeva se da ima mesta za sve goste).
*/
DELIMITER $$

DROP TRIGGER IF EXISTS nosena$$

CREATE TRIGGER nosena
BEFORE INSERT ON Nosi
FOR EACH ROW 
BEGIN 
	UPDATE Haljina SET nosena = nosena + 1 WHERE new.Haljina_id = id;
END;
$$


DROP TRIGGER IF EXISTS broj_mesta$$

CREATE TRIGGER broj_mesta
BEFORE INSERT ON Pozivnica
FOR EACH ROW 
BEGIN
	SET new.broj_stolice = (SELECT COALESCE(max(broj_stolice), 0)
													FROM Pozivnica
													WHERE new.Modna_revija_id = Modna_revija_id) + 1;
END;
$$

DELIMITER ;