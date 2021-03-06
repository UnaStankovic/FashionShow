-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP DATABASE IF EXISTS modna_revija;
-- -----------------------------------------------------
-- Schema modna_revija
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema modna_revija
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `modna_revija` DEFAULT CHARACTER SET utf8 ;
USE `modna_revija` ;

-- -----------------------------------------------------
-- Table `modna_revija`.`Osoba`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Osoba` (
  `jmbg` VARCHAR(13) NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `adresa` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`jmbg`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Pomocno_osoblje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Pomocno_osoblje` (
  `Osoba_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Osoba_jmbg`),
  CONSTRAINT `fk_Pomocno_osoblje_Osoba`
    FOREIGN KEY (`Osoba_jmbg`)
    REFERENCES `modna_revija`.`Osoba` (`jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Model` (
  `Osoba_jmbg` VARCHAR(13) NOT NULL,
  `bmi` DOUBLE NOT NULL,
  `obim` DOUBLE NOT NULL,
  `tezina` DOUBLE NOT NULL,
  `visina` DOUBLE NOT NULL,
  PRIMARY KEY (`Osoba_jmbg`),
  CONSTRAINT `fk_Model_Osoba1`
    FOREIGN KEY (`Osoba_jmbg`)
    REFERENCES `modna_revija`.`Osoba` (`jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Dizajner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Dizajner` (
  `Osoba_jmbg` VARCHAR(13) NOT NULL,
  `adresa_ateljea` VARCHAR(45) NOT NULL,
  `naziv_firme` VARCHAR(45) NOT NULL,
  `pib` INT NOT NULL,
  PRIMARY KEY (`Osoba_jmbg`),
  CONSTRAINT `fk_Dizajner_Osoba1`
    FOREIGN KEY (`Osoba_jmbg`)
    REFERENCES `modna_revija`.`Osoba` (`jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Organizator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Organizator` (
  `Osoba_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Osoba_jmbg`),
  CONSTRAINT `fk_Organizator_Osoba1`
    FOREIGN KEY (`Osoba_jmbg`)
    REFERENCES `modna_revija`.`Osoba` (`jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Gost`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Gost` (
  `Osoba_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Osoba_jmbg`),
  CONSTRAINT `fk_Gost_Osoba1`
    FOREIGN KEY (`Osoba_jmbg`)
    REFERENCES `modna_revija`.`Osoba` (`jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Mesto_odrzavanja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Mesto_odrzavanja` (
  `ptt` INT NOT NULL,
  `adresa` VARCHAR(45) NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ptt`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Modna_revija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Modna_revija` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `datum` DATE NOT NULL,
  `vreme` TIME NOT NULL,
  `Organizator_Osoba_jmbg` VARCHAR(13) NOT NULL,
  `Mesto_odrzavanja_ptt` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Modna_revija_Organizator1_idx` (`Organizator_Osoba_jmbg` ASC),
  INDEX `fk_Modna_revija_Mesto_odrzavanja1_idx` (`Mesto_odrzavanja_ptt` ASC),
  CONSTRAINT `fk_Modna_revija_Organizator1`
    FOREIGN KEY (`Organizator_Osoba_jmbg`)
    REFERENCES `modna_revija`.`Organizator` (`Osoba_jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Modna_revija_Mesto_odrzavanja1`
    FOREIGN KEY (`Mesto_odrzavanja_ptt`)
    REFERENCES `modna_revija`.`Mesto_odrzavanja` (`ptt`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Pozivnica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Pozivnica` (
  `broj_stolice` INT NOT NULL,
  `tekst` TEXT NOT NULL,
  `Gost_Osoba_jmbg` VARCHAR(13) NOT NULL,
  `Modna_revija_id` INT NOT NULL,
  PRIMARY KEY (`broj_stolice`, `Modna_revija_id`),
  INDEX `fk_Pozivnica_Gost1_idx` (`Gost_Osoba_jmbg` ASC),
  INDEX `fk_Pozivnica_Modna_revija1_idx` (`Modna_revija_id` ASC),
  CONSTRAINT `fk_Pozivnica_Gost1`
    FOREIGN KEY (`Gost_Osoba_jmbg`)
    REFERENCES `modna_revija`.`Gost` (`Osoba_jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Pozivnica_Modna_revija1`
    FOREIGN KEY (`Modna_revija_id`)
    REFERENCES `modna_revija`.`Modna_revija` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Unajmljuje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Unajmljuje` (
  `honorar` INT NOT NULL,
  `Model_Osoba_jmbg` VARCHAR(13) NOT NULL,
  `Modna_revija_id` INT NOT NULL,
  PRIMARY KEY (`Model_Osoba_jmbg`, `Modna_revija_id`),
  INDEX `fk_Unajmljuje_Modna_revija1_idx` (`Modna_revija_id` ASC),
  CONSTRAINT `fk_Unajmljuje_Model1`
    FOREIGN KEY (`Model_Osoba_jmbg`)
    REFERENCES `modna_revija`.`Model` (`Osoba_jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Unajmljuje_Modna_revija1`
    FOREIGN KEY (`Modna_revija_id`)
    REFERENCES `modna_revija`.`Modna_revija` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Kolekcija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Kolekcija` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sezona` VARCHAR(45) NOT NULL,
  `godina` YEAR NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  `tip` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Haljina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Haljina` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `materijal` VARCHAR(45) NOT NULL,
  `tip` VARCHAR(45) NOT NULL,
  `duzina` DOUBLE NOT NULL,
  `Dizajner_Osoba_jmbg` VARCHAR(13) NOT NULL,
  `Kolekcija_id` INT NOT NULL,
  `nosena` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_Haljina_Dizajner1_idx` (`Dizajner_Osoba_jmbg` ASC),
  INDEX `fk_Haljina_Kolekcija1_idx` (`Kolekcija_id` ASC),
  CONSTRAINT `fk_Haljina_Dizajner1`
    FOREIGN KEY (`Dizajner_Osoba_jmbg`)
    REFERENCES `modna_revija`.`Dizajner` (`Osoba_jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Haljina_Kolekcija1`
    FOREIGN KEY (`Kolekcija_id`)
    REFERENCES `modna_revija`.`Kolekcija` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Nosi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Nosi` (
  `Unajmljuje_Model_Osoba_jmbg` VARCHAR(13) NOT NULL,
  `Unajmljuje_Modna_revija_id` INT NOT NULL,
  `Haljina_id` INT NOT NULL,
  PRIMARY KEY (`Unajmljuje_Model_Osoba_jmbg`, `Unajmljuje_Modna_revija_id`, `Haljina_id`),
  INDEX `fk_Nosi_Haljina1_idx` (`Haljina_id` ASC),
  CONSTRAINT `fk_Nosi_Unajmljuje1`
    FOREIGN KEY (`Unajmljuje_Model_Osoba_jmbg` , `Unajmljuje_Modna_revija_id`)
    REFERENCES `modna_revija`.`Unajmljuje` (`Model_Osoba_jmbg` , `Modna_revija_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Nosi_Haljina1`
    FOREIGN KEY (`Haljina_id`)
    REFERENCES `modna_revija`.`Haljina` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modna_revija`.`Sredjuje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modna_revija`.`Sredjuje` (
  `Unajmljuje_Model_Osoba_jmbg` VARCHAR(13) NOT NULL,
  `Unajmljuje_Modna_revija_id` INT NOT NULL,
  `Pomocno_osoblje_Osoba_jmbg` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Unajmljuje_Model_Osoba_jmbg`, `Unajmljuje_Modna_revija_id`, `Pomocno_osoblje_Osoba_jmbg`),
  INDEX `fk_Sredjuje_Pomocno_osoblje1_idx` (`Pomocno_osoblje_Osoba_jmbg` ASC),
  CONSTRAINT `fk_Sredjuje_Unajmljuje1`
    FOREIGN KEY (`Unajmljuje_Model_Osoba_jmbg` , `Unajmljuje_Modna_revija_id`)
    REFERENCES `modna_revija`.`Unajmljuje` (`Model_Osoba_jmbg` , `Modna_revija_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Sredjuje_Pomocno_osoblje1`
    FOREIGN KEY (`Pomocno_osoblje_Osoba_jmbg`)
    REFERENCES `modna_revija`.`Pomocno_osoblje` (`Osoba_jmbg`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
