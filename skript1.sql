-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ModnaRevija
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ModnaRevija
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ModnaRevija` DEFAULT CHARACTER SET utf8 ;
USE `ModnaRevija` ;

-- -----------------------------------------------------
-- Table `ModnaRevija`.`Ucesnici`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Ucesnici` (
  `jmbg` VARCHAR(13) NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `adresa` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`jmbg`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Dizajner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Dizajner` (
  `pib` INT NOT NULL,
  `naziv firme` VARCHAR(45) NOT NULL,
  `adresa ateljea` VARCHAR(45) NOT NULL,
  `Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Ucesnici_jmbg`),
  CONSTRAINT `fk_Dizajner_Ucesnici`
    FOREIGN KEY (`Ucesnici_jmbg`)
    REFERENCES `ModnaRevija`.`Ucesnici` (`jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Model` (
  `bmi` DOUBLE NOT NULL,
  `tezina` DOUBLE NOT NULL,
  `obim` DOUBLE NOT NULL,
  `visina` DOUBLE NOT NULL,
  `Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Ucesnici_jmbg`),
  CONSTRAINT `fk_Model_Ucesnici1`
    FOREIGN KEY (`Ucesnici_jmbg`)
    REFERENCES `ModnaRevija`.`Ucesnici` (`jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Pomocno osoblje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Pomocno osoblje` (
  `Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Ucesnici_jmbg`),
  CONSTRAINT `fk_Pomocno osoblje_Ucesnici1`
    FOREIGN KEY (`Ucesnici_jmbg`)
    REFERENCES `ModnaRevija`.`Ucesnici` (`jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Angazuje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Angazuje` (
  `Dizajner_Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  `Pomocno osoblje_Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Dizajner_Ucesnici_jmbg`, `Pomocno osoblje_Ucesnici_jmbg`),
  INDEX `fk_Zaposljava_Pomocno osoblje1_idx` (`Pomocno osoblje_Ucesnici_jmbg` ASC),
  CONSTRAINT `fk_Angazuje_Dizajner1`
    FOREIGN KEY (`Dizajner_Ucesnici_jmbg`)
    REFERENCES `ModnaRevija`.`Dizajner` (`Ucesnici_jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Angazuje_Pomocno osoblje1`
    FOREIGN KEY (`Pomocno osoblje_Ucesnici_jmbg`)
    REFERENCES `ModnaRevija`.`Pomocno osoblje` (`Ucesnici_jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Sredjuje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Sredjuje` (
  `Angazuje_Dizajner_Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  `Angazuje_Pomocno osoblje_Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  `Model_Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Angazuje_Dizajner_Ucesnici_jmbg`, `Angazuje_Pomocno osoblje_Ucesnici_jmbg`, `Model_Ucesnici_jmbg`),
  INDEX `fk_Sredjuje_Model1_idx` (`Model_Ucesnici_jmbg` ASC),
  CONSTRAINT `fk_Sredjuje_Zaposljava1`
    FOREIGN KEY (`Angazuje_Dizajner_Ucesnici_jmbg` , `Angazuje_Pomocno osoblje_Ucesnici_jmbg`)
    REFERENCES `ModnaRevija`.`Angazuje` (`Dizajner_Ucesnici_jmbg` , `Pomocno osoblje_Ucesnici_jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sredjuje_Model1`
    FOREIGN KEY (`Model_Ucesnici_jmbg`)
    REFERENCES `ModnaRevija`.`Model` (`Ucesnici_jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Unajmljuje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Unajmljuje` (
  `Dizajner_Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  `Model_Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  `Honorar` DOUBLE NOT NULL,
  PRIMARY KEY (`Dizajner_Ucesnici_jmbg`, `Model_Ucesnici_jmbg`),
  INDEX `fk_Unajmljuje_Model1_idx` (`Model_Ucesnici_jmbg` ASC),
  CONSTRAINT `fk_Unajmljuje_Dizajner1`
    FOREIGN KEY (`Dizajner_Ucesnici_jmbg`)
    REFERENCES `ModnaRevija`.`Dizajner` (`Ucesnici_jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Unajmljuje_Model1`
    FOREIGN KEY (`Model_Ucesnici_jmbg`)
    REFERENCES `ModnaRevija`.`Model` (`Ucesnici_jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Kolekcija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Kolekcija` (
  `idKolekcije` INT NOT NULL AUTO_INCREMENT,
  `sezona` VARCHAR(45) NOT NULL,
  `godina` YEAR NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  `tip` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idKolekcije`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Kreira`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Kreira` (
  `Dizajner_Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  `Kolekcija_idKolekcije` INT NOT NULL,
  PRIMARY KEY (`Dizajner_Ucesnici_jmbg`, `Kolekcija_idKolekcije`),
  INDEX `fk_Kreira_Kolekcija1_idx` (`Kolekcija_idKolekcije` ASC),
  CONSTRAINT `fk_Kreira_Dizajner1`
    FOREIGN KEY (`Dizajner_Ucesnici_jmbg`)
    REFERENCES `ModnaRevija`.`Dizajner` (`Ucesnici_jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Kreira_Kolekcija1`
    FOREIGN KEY (`Kolekcija_idKolekcije`)
    REFERENCES `ModnaRevija`.`Kolekcija` (`idKolekcije`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Haljina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Haljina` (
  `idHaljina` INT NOT NULL AUTO_INCREMENT,
  `materijal` VARCHAR(45) NOT NULL,
  `duzina(cm)` DOUBLE NOT NULL,
  `tip` VARCHAR(45) NOT NULL,
  `Kolekcija_idKolekcije` INT NOT NULL,
  `Model_Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`idHaljina`),
  INDEX `fk_Haljina_Kolekcija1_idx` (`Kolekcija_idKolekcije` ASC),
  INDEX `fk_Haljina_Model1_idx` (`Model_Ucesnici_jmbg` ASC),
  CONSTRAINT `fk_Haljina_Kolekcija1`
    FOREIGN KEY (`Kolekcija_idKolekcije`)
    REFERENCES `ModnaRevija`.`Kolekcija` (`idKolekcije`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Haljina_Model1`
    FOREIGN KEY (`Model_Ucesnici_jmbg`)
    REFERENCES `ModnaRevija`.`Model` (`Ucesnici_jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Mesto odrzavanja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Mesto odrzavanja` (
  `ptt` INT NOT NULL,
  `adresa` VARCHAR(45) NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ptt`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Modna revija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Modna revija` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `datum` DATE NOT NULL,
  `vreme` TIME NOT NULL,
  `sezona` VARCHAR(45) NOT NULL,
  `Mesto odrzavanja_ptt` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Modna revija_Mesto odrzavanja1_idx` (`Mesto odrzavanja_ptt` ASC),
  CONSTRAINT `fk_Modna revija_Mesto odrzavanja1`
    FOREIGN KEY (`Mesto odrzavanja_ptt`)
    REFERENCES `ModnaRevija`.`Mesto odrzavanja` (`ptt`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Organizuje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Organizuje` (
  `datum` DATE NOT NULL,
  `vreme` TIME NOT NULL,
  `Modna revija_id` INT NOT NULL,
  `Dizajner_Ucesnici_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Modna revija_id`, `Dizajner_Ucesnici_jmbg`),
  INDEX `fk_Organizuje_Dizajner1_idx` (`Dizajner_Ucesnici_jmbg` ASC),
  CONSTRAINT `fk_Organizuje_Modna revija1`
    FOREIGN KEY (`Modna revija_id`)
    REFERENCES `ModnaRevija`.`Modna revija` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Organizuje_Dizajner1`
    FOREIGN KEY (`Dizajner_Ucesnici_jmbg`)
    REFERENCES `ModnaRevija`.`Dizajner` (`Ucesnici_jmbg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Gost`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Gost` (
  `jmbg` VARCHAR(13) NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`jmbg`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModnaRevija`.`Pozivnica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ModnaRevija`.`Pozivnica` (
  `tekst` VARCHAR(100) NOT NULL,
  `broj stolice` INT NOT NULL,
  `Modna revija_id` INT NOT NULL,
  `Gost_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Modna revija_id`, `broj stolice`),
  INDEX `fk_Pozivnica_Gost1_idx` (`Gost_jmbg` ASC),
  CONSTRAINT `fk_Pozivnica_Modna revija1`
    FOREIGN KEY (`Modna revija_id`)
    REFERENCES `ModnaRevija`.`Modna revija` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pozivnica_Gost1`
    FOREIGN KEY (`Gost_jmbg`)
    REFERENCES `ModnaRevija`.`Gost` (`jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
