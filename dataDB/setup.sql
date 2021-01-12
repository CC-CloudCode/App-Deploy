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

CREATE USER 'bettingspree'@'localhost' IDENTIFIED BY 'PEI2020';
ALTER USER 'bettingspree'@'localhost' IDENTIFIED WITH mysql_native_password BY 'PEI2020';
GRANT ALL PRIVILEGES ON * . * TO 'bettingspree'@'localhost';
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




INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user1', '1998-12-1', '$2a$10$4SZlK7ld/tIcxGU33i.vQO9YpTo08/TolWc7gZrPMrBARAK.ff1Ey','user1@hotmail.com', 'José Sousa', 0, 0, false, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user2', '1998-12-2', '$2a$10$qsQR9wdty0y8ecZBBleSjOKzEawdn1szNmmVLqB08DqDRba1l5be2','user2@hotmail.com', 'Gervásio Macedo', 0, 0, true, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user3', '1998-12-3', '$2a$10$vRxaM10fzBzD1ifbpK7sQuz2ypVN6Jgjg0OVL6l2AfO5WBNFJM/sO','user3@hotmail.com', 'Fernando Pinto', 0, 0, false, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user5', '1998-12-5', '$2a$10$pnZ0HuFa57q1.AUAiUfeaudiMxKz/4J3ekWcJ5goXNsowDgf9JUgm','user5@hotmail.com', 'André Ferreira', 0, 0, false, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user6', '1998-12-6', '$2a$10$FnYFD6c5KAkKYcUs8CZ3..RQAUndgCBNfbCJqWhKBdRjOuwa6Fg4W','user6@hotmail.com', 'Carlos Dias', 0, 0, true, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user4', '1998-12-4', '$2a$10$n.CK18HO9YMBffigcjCrc.2vQFAwuH1E9rsTlMFH4giqEprtGmNLG','user4@hotmail.com', 'Manuel Teixeira', 0, 0, true, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user9', '1998-12-9', '$2a$10$aBpJ00UIqPu9/zHN6iIt7.U8VFJBsaT6kVk3B3tLpHU7gykpBRJR.','user9@hotmail.com', 'Ricardo Pereira', 0, 0, false, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user7', '1998-12-7', '$2a$10$jaNuuXEgNYBJCzfShR1V3eCqxaClUm15Azc2kdk.KLA8RlrrOMi0u','user7@hotmail.com', 'Gabriel Magalhães', 0, 0, false, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user11', '1998-12-11', '$2a$10$YaQLSaVQ5/bWgJ9eCA4ZIeoOTf6Oq8NOq..hqL/2UwOBU.0qv6W32','user11@hotmail.com', 'Catarina Silva', 0, 0, false, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user8', '1998-12-8', '$2a$10$P8v2CzgAkYN934Q8EYWz5OLu.ZEzP5rh.tgYohxuLte.5W8NuFrGC','user8@hotmail.com', 'Dinis Peixoto', 0, 0, true, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user10', '1998-12-10', '$2a$10$79P0bUr.tFYMjzkoTa6whu7821h7bZY9FV3ppC7hLIAXTk8tj.92.','user10@hotmail.com', 'Sheila Dias', 0, 0, true, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user12', '1998-12-12', '$2a$10$DAU.6FTM11EkLqXyUqLAKOkrfqK1NUZ1kV.UsDx.qPpHM1dKuwbLS','user12@hotmail.com', 'Daniel Esteves', 0, 0, true, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user15', '1998-12-15', '$2a$10$0kKtWUl9yccz.mhzxwA8IODa8nzILUnWY/fNlTskonqbJYdEJeIvO','user15@hotmail.com', 'Liliana Brandão', 0, 0, false, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user14', '1998-12-14', '$2a$10$8u65y8ua0.wCUPdcd1XQpuJ8y2kKpTYYzhmmeQqtAg9CHhzW8iJqm','user14@hotmail.com', 'Maria Valentim', 0, 0, true, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user17', '1998-12-17', '$2a$10$E8ZPLGRUYKn3DhLF9WZmMecH.0f3hBJYLzQbjqpOArkXNBZoI7nem','user17@hotmail.com', 'Sara Guedes', 0, 0, false, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user13', '1998-12-13', '$2a$10$zN1T2zoRp.tQVeK8Lek74.fYfNaWA13x3Rhg/TqS//GQPbToLcEE2','user13@hotmail.com', 'Joana Machado', 0, 0, false, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user16', '1998-12-16', '$2a$10$09dgdAiiln8AssGFnUyXAuRaXGKA6U/L11Xd4TByF7.RMy6XWfZ5W','user16@hotmail.com', 'Inês Castro', 0, 0, true, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user18', '1998-12-18', '$2a$10$JUraCizkiwxgCgUafGzvOewumg1lmGbWco/84WjnqeHNazEyv6npa','user18@hotmail.com', 'Francisca Carvalho', 0, 0, true, 0)
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user20', '1998-12-20', '$2a$10$D9Oc93h/ksMp6zG5YVVd6ennXZcMgOtqy0HViP3.HaU9te0qffsiq','user20@hotmail.com', 'Raquel Matos', 0, 0, true, 0)
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (1, 'England Tips')
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`) VALUES ('user19', '1998-12-19', '$2a$10$rpHuiwqNFx9lRF1/6rx2Ne.FB.uJlHnS2cWScc/JoDVhb9E39PkOm','user19@hotmail.com', 'Rita Pereira', 0, 0, false, 0)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 2,true)
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (3, 'Italy Tips')
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (2, 'Portugal Tips')
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 3,true)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 1,true)
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (4, 'France Tips')
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 4,true)
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (6, 'Germany Tips')
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (5, 'Spain Tips')
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 6,true)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 7,true)
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (8, 'Champions Tips')
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 5,true)
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (7, 'Brazil Tips')
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 8,true)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 9,true)
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (9, 'Holand Tips')
INSERT INTO `databettingspree`.`group` (`createdby`, `name`) VALUES (10, 'Turkey Tips')
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 10,true)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-12 11:39:37', 1, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', false, '2021-01-12 11:39:37', 1, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', true, '2021-01-12 11:39:37', 2, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', true, '2021-01-12 11:39:37', 1, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 11:39:37', 2, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-12 11:39:37', 2, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 11:39:37', 3, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', true, '2021-01-12 11:39:37', 3, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', true, '2021-01-12 11:39:37', 4, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 11:39:37', 3, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 11:39:37', 4, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 11:39:37', 5, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-12 11:39:37', 5, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 11:39:37', 5, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-12 11:39:37', 6, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 11:39:37', 4, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 11:39:37', 6, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 11:39:37', 6, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-12 11:39:37', 7, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-12 11:39:37', 7, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 11:39:37', 8, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 11:39:37', 7, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 11:39:37', 9, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', true, '2021-01-12 11:39:37', 9, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 11:39:37', 9, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', true, '2021-01-12 11:39:37', 8, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 11:39:37', 8, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 11:39:37', 10, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', true, '2021-01-12 11:39:37', 10, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', true, '2021-01-12 11:39:37', 11, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', false, '2021-01-12 11:39:37', 11, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 11:39:37', 11, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 11:39:37', 12, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 11:39:37', 10, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 11:39:37', 12, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', false, '2021-01-12 11:39:37', 13, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 11:39:37', 13, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-12 11:39:37', 12, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 11:39:37', 14, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 11:39:37', 14, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', true, '2021-01-12 11:39:37', 13, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 11:39:37', 15, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-12 11:39:37', 15, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 11:39:37', 15, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-12 11:39:37', 16, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 11:39:37', 16, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-12 11:39:37', 16, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-12 11:39:37', 14, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-12 11:39:37', 17, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-12 11:39:37', 18, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 11:39:37', 17, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-12 11:39:37', 17, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', true, '2021-01-12 11:39:37', 18, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', true, '2021-01-12 11:39:37', 19, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-12 11:39:37', 19, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-12 11:39:37', 20, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', true, '2021-01-12 11:39:37', 20, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-12 11:39:37', 20, null, null, null)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (7, 1)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 11:39:37', 19, null, null, null)
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-12 11:39:37', 18, null, null, null)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (14, 1)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (3, 1)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (15, 2)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (8, 1)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (12, 2)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 2)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 3)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (5, 2)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 3)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (4, 4)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (7, 3)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 4)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 4)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (4, 3)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (3, 5)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 5)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (16, 5)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 5)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 6)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (7, 6)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (10, 6)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 6)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (3, 4)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 7)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (3, 7)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (20, 8)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (10, 8)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (9, 7)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (18, 8)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (18, 7)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (9, 8)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (9, 9)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (6, 9)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (20, 9)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (1, 10)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (16, 10)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 9)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (4, 10)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 10)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (4, 11)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 11)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (18, 12)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (15, 12)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (6, 11)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (3, 12)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (10, 12)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 13)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (3, 13)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (20, 13)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 14)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (10, 14)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (1, 13)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (7, 11)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 14)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 14)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 15)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (10, 15)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (12, 15)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (8, 15)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 16)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (12, 16)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (15, 17)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (14, 16)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (6, 16)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (6, 17)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 17)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (8, 17)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (18, 18)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (8, 18)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 18)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (5, 18)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 19)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 19)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (4, 19)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (16, 20)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (1, 20)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 20)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 12,false)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (8, 19)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 2,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 14,false)
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 20)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 15,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 5,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 13,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 16,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 19,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 20,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 1,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 8,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 18,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 11,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 20,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 9,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 10,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 8,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 12,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 1,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 18,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 18,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 16,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 7,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 10,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 3,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 10,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 7,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 16,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 2,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 15,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 17,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 6,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 11,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 1,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 1,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 16,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 11,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 18,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 6,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 9,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 17,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 14,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 18,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 13,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 20,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 12,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 13,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 17,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 9,false)
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 3,false)
