-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema databettingspree
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema databettingspree
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `databettingspree` DEFAULT CHARACTER SET utf8 ;
USE `databettingspree` ;

-- -----------------------------------------------------
-- Table `databettingspree`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databettingspree`.`user` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `password` VARCHAR(80) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `followers` INT NOT NULL,
  `following` INT NOT NULL,
  `private` TINYINT NOT NULL,
  `balance` DOUBLE NOT NULL,
  PRIMARY KEY (`iduser`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `iduser_UNIQUE` (`iduser` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `databettingspree`.`bet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databettingspree`.`bet` (
  `idbet` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `money` DOUBLE NOT NULL,
  `iduser` INT NOT NULL,
  `state` INT NOT NULL,
  `originalbetid` INT NULL,
  `isDraft` TINYINT NOT NULL,
  PRIMARY KEY (`idbet`),
  INDEX `fk_bet_user1_idx` (`iduser` ASC) VISIBLE,
  CONSTRAINT `fk_bet_user1`
    FOREIGN KEY (`iduser`)
    REFERENCES `databettingspree`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `databettingspree`.`group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databettingspree`.`group` (
  `idgroup` INT NOT NULL AUTO_INCREMENT,
  `createdby` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idgroup`),
  INDEX `fk_group_user1_idx` (`createdby` ASC) VISIBLE,
  CONSTRAINT `fk_group_user1`
    FOREIGN KEY (`createdby`)
    REFERENCES `databettingspree`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `databettingspree`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databettingspree`.`post` (
  `idpost` INT NOT NULL AUTO_INCREMENT,
  `text` TEXT NULL,
  `public` TINYINT NOT NULL,
  `date` DATETIME NOT NULL,
  `iduser` INT NOT NULL,
  `idbet` INT NULL,
  `betpublic` TINYINT NULL,
  `idgroup` INT NULL,
  PRIMARY KEY (`idpost`),
  UNIQUE INDEX `idpost_UNIQUE` (`idpost` ASC) VISIBLE,
  INDEX `fk_post_user_idx` (`iduser` ASC) VISIBLE,
  INDEX `fk_post_bet1_idx` (`idbet` ASC) VISIBLE,
  INDEX `fk_post_group1_idx` (`idgroup` ASC) VISIBLE,
  CONSTRAINT `fk_post_user`
    FOREIGN KEY (`iduser`)
    REFERENCES `databettingspree`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_bet1`
    FOREIGN KEY (`idbet`)
    REFERENCES `databettingspree`.`bet` (`idbet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_group1`
    FOREIGN KEY (`idgroup`)
    REFERENCES `databettingspree`.`group` (`idgroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `databettingspree`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databettingspree`.`comment` (
  `idcomment` INT NOT NULL AUTO_INCREMENT,
  `text` TEXT NOT NULL,
  `date` DATETIME NOT NULL,
  `iduser` INT NOT NULL,
  `idpost` INT NOT NULL,
  PRIMARY KEY (`idcomment`),
  INDEX `fk_comment_user1_idx` (`iduser` ASC) VISIBLE,
  INDEX `fk_comment_post1_idx` (`idpost` ASC) VISIBLE,
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`iduser`)
    REFERENCES `databettingspree`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_post1`
    FOREIGN KEY (`idpost`)
    REFERENCES `databettingspree`.`post` (`idpost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `databettingspree`.`upvotes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databettingspree`.`upvotes` (
  `iduser` INT NOT NULL,
  `idpost` INT NOT NULL,
  PRIMARY KEY (`iduser`, `idpost`),
  INDEX `fk_user_has_post_post1_idx` (`idpost` ASC) VISIBLE,
  INDEX `fk_user_has_post_user1_idx` (`iduser` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_post_user1`
    FOREIGN KEY (`iduser`)
    REFERENCES `databettingspree`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_post_post1`
    FOREIGN KEY (`idpost`)
    REFERENCES `databettingspree`.`post` (`idpost`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `databettingspree`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databettingspree`.`event` (
  `idevent` INT NOT NULL AUTO_INCREMENT,
  `idbetapi` VARCHAR(24) NOT NULL,
  `odd` FLOAT NOT NULL,
  `bettype` INT NOT NULL,
  `idbet` INT NOT NULL,
  `state` INT NOT NULL,
  PRIMARY KEY (`idevent`),
  INDEX `fk_event_bet1_idx` (`idbet` ASC) VISIBLE,
  CONSTRAINT `fk_event_bet1`
    FOREIGN KEY (`idbet`)
    REFERENCES `databettingspree`.`bet` (`idbet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `databettingspree`.`follower`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databettingspree`.`follower` (
  `me` INT NOT NULL,
  `following` INT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  INDEX `fk_user_has_user_user2_idx` (`following` ASC) VISIBLE,
  INDEX `fk_user_has_user_user1_idx` (`me` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`me`)
    REFERENCES `databettingspree`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`following`)
    REFERENCES `databettingspree`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `databettingspree`.`usergroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databettingspree`.`usergroup` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idgroup` INT NOT NULL,
  `iduser` INT NOT NULL,
  `isAdmin` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_group_has_user_user1_idx` (`iduser` ASC) VISIBLE,
  INDEX `fk_group_has_user_group1_idx` (`idgroup` ASC) VISIBLE,
  CONSTRAINT `fk_group_has_user_group1`
    FOREIGN KEY (`idgroup`)
    REFERENCES `databettingspree`.`group` (`idgroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_has_user_user1`
    FOREIGN KEY (`iduser`)
    REFERENCES `databettingspree`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `databettingspree`.`followrequests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databettingspree`.`followrequests` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `requester` INT NOT NULL,
  `requested` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_followrequests_user1_idx` (`requester` ASC) VISIBLE,
  INDEX `fk_followrequests_user2_idx` (`requested` ASC) VISIBLE,
  CONSTRAINT `fk_followrequests_user1`
    FOREIGN KEY (`requester`)
    REFERENCES `databettingspree`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_followrequests_user2`
    FOREIGN KEY (`requested`)
    REFERENCES `databettingspree`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `databettingspree`.`grouprequests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `databettingspree`.`grouprequests` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `iduser` INT NOT NULL,
  `idgroup` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_table1_user1_idx` (`iduser` ASC) VISIBLE,
  INDEX `fk_table1_group1_idx` (`idgroup` ASC) VISIBLE,
  CONSTRAINT `fk_table1_user1`
    FOREIGN KEY (`iduser`)
    REFERENCES `databettingspree`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_group1`
    FOREIGN KEY (`idgroup`)
    REFERENCES `databettingspree`.`group` (`idgroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ----------------------------------- USER ------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------

use databettingspree;


-- GRANT INSERT, SELECT, DELETE, UPDATE ON databettingspree.* TO 'bettingspree'@'localhost' IDENTIFIED BY 'PEI2020';
CREATE USER 'bettingspree'@'%' IDENTIFIED BY 'PEI2020';
ALTER USER 'bettingspree'@'%' IDENTIFIED WITH mysql_native_password BY 'PEI2020';
GRANT ALL PRIVILEGES ON * . * TO 'bettingspree'@'%';
FLUSH PRIVILEGES;


-- ----------------------------------- Triggers ------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------


Drop Trigger IF EXISTS follower_insert;
Delimiter $$
CREATE TRIGGER follower_insert
AFTER INSERT ON databettingspree.follower 
FOR EACH ROW
BEGIN
Update databettingspree.user Set followers = followers + 1 where iduser = NEW.following;
Update databettingspree.user Set following = following + 1 where iduser = NEW.me;
END $$
Delimiter ;

Drop Trigger IF EXISTS follower_delete;
Delimiter $$
CREATE TRIGGER follower_delete
AFTER DELETE ON databettingspree.follower 
FOR EACH ROW
BEGIN
Update databettingspree.user Set followers = followers - 1 where iduser = Old.following;
Update databettingspree.user Set following = following - 1 where iduser = Old.me;
END $$
Delimiter ;




-- ----------------------------------- Povoamento ------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------




INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user1', '1998-12-1', '$2a$10$oJuF.CMfsgamx/L8gj6WaOrSERX7i4RXfsk.GtvN/Ft9iH.g1p0U6','user1@hotmail.com', 'José Sousa', 0, 0, false, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user2', '1998-12-2', '$2a$10$bv9BRFsdhutQt0UPU0DdZe8Y935qDla9DxR5XI2twfe7tpd2MagCe','user2@hotmail.com', 'Gervásio Macedo', 0, 0, true, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user3', '1998-12-3', '$2a$10$Ppr.28duF/OvXL5wDNoj5OVgG6ffjCxd.1031VLB8WF1Mc4EGgHT.','user3@hotmail.com', 'Fernando Pinto', 0, 0, false, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user4', '1998-12-4', '$2a$10$Wfmbyq4XLo4KEIPtXsrR8uwNzd.ITpZh5j540pVNuVEScnKXzoUe.','user4@hotmail.com', 'Manuel Teixeira', 0, 0, true, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user5', '1998-12-5', '$2a$10$cGVDqiCWkYnVooCFNbE7iOXWpmvC9uzQ19FV2nkvT05A4JDCQ01tC','user5@hotmail.com', 'André Ferreira', 0, 0, false, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user7', '1998-12-7', '$2a$10$OEQzZjtmV9e.Iw9.6Rscw.QZ5YUQqLabOuyh.IQ3WeKzKER/6s3.2','user7@hotmail.com', 'Gabriel Magalhães', 0, 0, false, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user9', '1998-12-9', '$2a$10$k.2oF2dVjbx.Z/SFN4p/QOBuvDrkXPINCCjKlf0xyaMkDvTHnktsq','user9@hotmail.com', 'Ricardo Pereira', 0, 0, false, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user6', '1998-12-6', '$2a$10$7.REzbBDiG1v56RZC5256uQYc60/RMl.mev5CYOrP8Dqjp6OkhBwy','user6@hotmail.com', 'Carlos Dias', 0, 0, true, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user8', '1998-12-8', '$2a$10$qRPbFyNTAZLedgGTB0KtDeygW8dwKmRFfRmtaauDhu6dyQMETOKVG','user8@hotmail.com', 'Dinis Peixoto', 0, 0, true, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user10', '1998-12-10', '$2a$10$HutSSQX4wNNQC9mjOpHmkefebXM7wQrVBagARepu0kzSiLPT5MP5u','user10@hotmail.com', 'Sheila Dias', 0, 0, true, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user12', '1998-12-12', '$2a$10$oVUio9QAvWeSnoMdvgBtEuMurwRQd/h0zwImppoJM9mI020xITRU.','user12@hotmail.com', 'Daniel Esteves', 0, 0, true, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user11', '1998-12-11', '$2a$10$pmrD/aSL.Y03wWGnOwnNhezYBM0qhodBWEIxHY2qK6ePf7KAPH59y','user11@hotmail.com', 'Catarina Silva', 0, 0, false, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user15', '1998-12-15', '$2a$10$cWkH7VnMTMA1O0PUyQPRZ.pEzrAkKs.wfbLU4v/aKj.IH6yhpUU.e','user15@hotmail.com', 'Liliana Brandão', 0, 0, false, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user13', '1998-12-13', '$2a$10$1vEjepLrDhTZm0iWQBuZ8.jeMeA4QSOmRpEuar2N.kL7OxE419P8y','user13@hotmail.com', 'Joana Machado', 0, 0, false, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user17', '1998-12-17', '$2a$10$3RsWaUquWqiDAxmeKk/hUO053BynRJ1HAHh/5M3hLrnZ6Eo3RdnvC','user17@hotmail.com', 'Sara Guedes', 0, 0, false, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user14', '1998-12-14', '$2a$10$Z39noq/z3IIX1UsBnnQWfOZn/lNfuWG3XS93DreozfJttsMnGr5TO','user14@hotmail.com', 'Maria Valentim', 0, 0, true, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user19', '1998-12-19', '$2a$10$R9tXCTJKNJunqyofaJ9eVu8upHE9AegjsaO4U7M8tYCYKKuhSHMge','user19@hotmail.com', 'Rita Pereira', 0, 0, false, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user18', '1998-12-18', '$2a$10$KoGh3pk1TFJ9sbNUycZ66./k/r/QzV1FXypzuVoWz0pwk1nkfg8qy','user18@hotmail.com', 'Francisca Carvalho', 0, 0, true, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user20', '1998-12-20', '$2a$10$JQ.pzHk44X69fv8cYHSpM.PL6Vo245C0zenTmjP8.N2x.cb5Tf4uO','user20@hotmail.com', 'Raquel Matos', 0, 0, true, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user16', '1998-12-16', '$2a$10$kn8bUZDbut4jCBMtaoFf.uPFvwvc.gM7wgcpr32irP.eFmvDpkQfq','user16@hotmail.com', 'Inês Castro', 0, 0, true, 0); 
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (1, 'England Tips'); 
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (2, 'Portugal Tips'); 
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (3, 'Italy Tips'); 
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (4, 'France Tips'); 
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (5, 'Spain Tips'); 
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (6, 'Germany Tips'); 
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (7, 'Brazil Tips'); 
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (8, 'Champions Tips'); 
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (9, 'Holand Tips'); 
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (10, 'Turkey Tips'); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 1,true); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 2,true); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 3,true); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 4,true); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 5,true); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 6,true); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 7,true); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 8,true); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 9,true); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 10,true); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-12 12:17:27', 1, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-12 12:17:27', 1, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 12:17:27', 2, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-12 12:17:27', 2, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 12:17:27', 1, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 12:17:27', 2, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 12:17:27', 3, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', true, '2021-01-12 12:17:27', 3, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 12:17:27', 3, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 12:17:27', 4, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', true, '2021-01-12 12:17:27', 4, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-12 12:17:27', 4, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 12:17:27', 5, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-12 12:17:27', 5, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 12:17:27', 5, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 12:17:27', 6, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', true, '2021-01-12 12:17:27', 6, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 12:17:27', 6, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 12:17:27', 7, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', true, '2021-01-12 12:17:27', 7, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 12:17:27', 7, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 12:17:27', 8, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-12 12:17:27', 8, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', false, '2021-01-12 12:17:27', 8, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 12:17:27', 9, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', true, '2021-01-12 12:17:27', 9, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 12:17:27', 9, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 12:17:27', 10, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-12 12:17:27', 10, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 12:17:27', 10, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 12:17:27', 11, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-12 12:17:27', 11, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 12:17:27', 11, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 12:17:27', 12, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-12 12:17:27', 12, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 12:17:27', 12, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 12:17:27', 13, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-12 12:17:27', 13, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-12 12:17:27', 13, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 12:17:27', 14, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', true, '2021-01-12 12:17:27', 14, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 12:17:27', 14, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 12:17:27', 15, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-12 12:17:27', 15, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 12:17:27', 15, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 12:17:27', 16, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', true, '2021-01-12 12:17:27', 16, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 12:17:27', 16, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 12:17:27', 17, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', true, '2021-01-12 12:17:27', 17, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 12:17:27', 17, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-12 12:17:27', 18, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', true, '2021-01-12 12:17:27', 18, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 12:17:27', 18, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 12:17:27', 19, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', true, '2021-01-12 12:17:27', 19, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-12 12:17:27', 19, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 12:17:27', 20, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', true, '2021-01-12 12:17:27', 20, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', false, '2021-01-12 12:17:27', 20, null, null, null); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (12, 1); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (14, 1); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (18, 1); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (1, 1); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (4, 2); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (14, 2); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (7, 2); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (6, 2); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (16, 3); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (15, 3); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (1, 3); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 3); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (6, 4); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 4); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (16, 4); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (15, 4); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (8, 5); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (20, 5); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (10, 5); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (5, 5); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 6); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (7, 6); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 6); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (14, 6); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (3, 7); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (18, 7); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (9, 7); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (14, 7); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (15, 8); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (8, 8); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (12, 8); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 8); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (16, 9); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 9); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (20, 9); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (1, 9); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (15, 10); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 10); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (10, 10); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (1, 10); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (20, 11); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 11); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (12, 11); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 11); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (4, 12); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (1, 12); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 12); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 12); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (20, 13); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 13); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 13); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (5, 13); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (10, 14); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (9, 14); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (8, 14); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (6, 14); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (5, 15); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 15); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 15); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 15); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 16); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (15, 16); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (6, 16); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 16); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 17); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (9, 17); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (14, 17); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (7, 17); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (15, 18); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 18); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 18); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 18); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (9, 19); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (3, 19); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (1, 19); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 19); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 20); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (14, 20); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 20); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (18, 20); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 20,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 7,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 12,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 6,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 14,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 18,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 5,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 20,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 7,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 4,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 16,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 20,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 11,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 4,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 10,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 2,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 3,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 5,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 9,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 14,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 4,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 16,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 11,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 1,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 8,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 20,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 16,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 18,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 13,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 5,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 9,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 12,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 20,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 18,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 2,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 3,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 2,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 5,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 17,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 15,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 8,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 10,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 13,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 4,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 18,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 8,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 20,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 12,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 3,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 6,false); 
