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
  `copiaspriv` INT NOT NULL,
  `avgodd` FLOAT NOT NULL,
  `rankscore` INT NOT NULL,
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
  `oddtotal` FLOAT NOT NULL,
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


GRANT INSERT, SELECT, DELETE, UPDATE ON databettingspree.* TO 'bettingspree'@'localhost' IDENTIFIED BY 'PEI2020';
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


use databettingspree;

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




Drop Trigger IF EXISTS copias_privadas;
Delimiter $$
CREATE TRIGGER copias_privadas
AFTER insert ON databettingspree.bet
FOR EACH ROW
BEGIN
declare originaluserid INT;
IF not isnull(new.originalbetid)
THEN
	select iduser into originaluserid from databettingspree.bet where idbet = NEW.originalbetid;
	Update databettingspree.user Set copiaspriv = copiaspriv + 1 where iduser = originaluserid;
    
    update databettingspree.user set rankscore = rankscore + 1 where iduser = originaluserid;
END IF;
END $$
Delimiter ;


Drop Trigger IF EXISTS total_odd_aposta;
Delimiter $$
CREATE TRIGGER total_odd_aposta
AFTER insert ON databettingspree.event
FOR EACH ROW
BEGIN
	Update databettingspree.bet Set oddtotal = oddtotal * NEW.odd where idbet = NEW.idbet;
END $$
Delimiter ;


Drop Trigger IF EXISTS update_aposta;
Delimiter $$
CREATE TRIGGER update_aposta
AFTER update ON databettingspree.bet
FOR EACH ROW
BEGIN

declare avg_bet FLOAT;
declare copias INT;
declare bets_ganhas INT;
declare bets_perdidas INT;

IF NEW.state != 0 THEN

	select AVG(oddtotal) into avg_bet from databettingspree.bet where iduser = old.iduser and isnull(originalbetid) and isDraft = false and state != 0;
    
    IF isnull(avg_bet) THEN
		set avg_bet = 0;
	END IF;
    
	Update databettingspree.user Set avgodd = avg_bet where iduser = old.iduser;
    
    select avgodd into avg_bet from databettingspree.user where iduser = OLD.iduser;
    select copiaspriv into copias from databettingspree.user where iduser = OLD.iduser;
    select count(idbet) into bets_ganhas from databettingspree.bet where old.iduser = iduser and state = 1 and isnull(originalbetid) and isDraft = false;
    select count(idbet) into bets_perdidas from databettingspree.bet where old.iduser = iduser and state = 2 and isnull(originalbetid) and isDraft = false;
    
    IF (bets_ganhas - bets_perdidas) > 0 THEN
    
		Update databettingspree.user Set rankscore = avg_bet * (bets_ganhas - bets_perdidas) + copias where iduser = old.iduser;
        
	ELSE 
		
        Update databettingspree.user Set rankscore = copias where iduser = old.iduser;
    
    END IF;

END IF;

END $$
Delimiter ;




-- ----------------------------------- Povoamento ------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------




INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user1', '1998-12-1', '$2a$10$uuFgNytz3v1pWx2j49gh7eQkNmPlWf8Xw3HoH9fFImcV42cK10hBu','user1@hotmail.com', 'José Sousa', 0, 0, false, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user2', '1998-12-2', '$2a$10$dysX6L113czg1QBjnMI7Yu2jva7OeelLkKS5avU9D7V9vJ7g0MjQe','user2@hotmail.com', 'Gervásio Macedo', 0, 0, true, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user3', '1998-12-3', '$2a$10$4CsNdxznPwMHuhPTFRg2SuJxiYqQoRXNZvKzKoFSMn39dSR8QhPhi','user3@hotmail.com', 'Fernando Pinto', 0, 0, false, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user4', '1998-12-4', '$2a$10$3z049anVDXxK6IyVk9QTjOx.64vUuGXGa/a9ePpToyeVzOfm3lDki','user4@hotmail.com', 'Manuel Teixeira', 0, 0, true, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user5', '1998-12-5', '$2a$10$kkFz7PUXg/Z0Ggu/rKXu.eUKGC8oC6geRP7rIrlhRia.pnlsZlKMq','user5@hotmail.com', 'André Ferreira', 0, 0, false, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user6', '1998-12-6', '$2a$10$YpfOUfpjVHOjcn958f4.sOvroh6H/7Y/Zl84qiE0e/JEVqvwZ.J.G','user6@hotmail.com', 'Carlos Dias', 0, 0, true, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user7', '1998-12-7', '$2a$10$ssJPsZMHDQjuXlz3.k1qkeESJJdcPnT9wzmhbKk4OX1xEmna.UyPq','user7@hotmail.com', 'Gabriel Magalhães', 0, 0, false, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user8', '1998-12-8', '$2a$10$O9.4sVAu7FYqzYM2v6zlZOm48sB7SWPdIuOvxRgTMXmW//XJFTrmi','user8@hotmail.com', 'Dinis Peixoto', 0, 0, true, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user9', '1998-12-9', '$2a$10$z7idaOCs8YF6fDMre4p4sOsbGHYGtvEN3FggH/ZWNoNYJPQi4DcoW','user9@hotmail.com', 'Ricardo Pereira', 0, 0, false, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user11', '1998-12-11', '$2a$10$msEuG7y14oXeGIATL1HqquMYfpeueE0l1P/xycAuX.nc6jEyZrfXK','user11@hotmail.com', 'Catarina Silva', 0, 0, false, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user10', '1998-12-10', '$2a$10$D/X0Hxo4ms3M/q3LnBsXSuDvtKbXhJXA0sGjileDloyCv9ZmyfVAu','user10@hotmail.com', 'Sheila Dias', 0, 0, true, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user12', '1998-12-12', '$2a$10$BkVAj4L.QPf3A5Roziay1e7EiJnCDqKWWlYd5DpI1ga0FYKn56Zcm','user12@hotmail.com', 'Daniel Esteves', 0, 0, true, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user14', '1998-12-14', '$2a$10$l0SBDvWP9xZyVehnozqzguNRnyyn833h1se4oJ2R8ax9/2HXqkXBC','user14@hotmail.com', 'Maria Valentim', 0, 0, true, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user15', '1998-12-15', '$2a$10$g2Sk30aKm4ebf3YqQ19vzu18kMsnXJNXvMYwpZzIUbg6SLvrK.0ba','user15@hotmail.com', 'Liliana Brandão', 0, 0, false, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user16', '1998-12-16', '$2a$10$a9kKjFXUDlisjdBLGrRgCuPIyQ1sq5/Zta96tMEbFiyH/d0oIoJre','user16@hotmail.com', 'Inês Castro', 0, 0, true, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user13', '1998-12-13', '$2a$10$PyAd3nKB1jxJ2rcjKPpyPet6apK2THZaDjiSSSFT9nh.vo6dgv3CK','user13@hotmail.com', 'Joana Machado', 0, 0, false, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user18', '1998-12-18', '$2a$10$sGlN/hd4YPtqSbePu.K1fOf017jbyDyQK.crfV/VnA4HbbVv4yMVa','user18@hotmail.com', 'Francisca Carvalho', 0, 0, true, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user20', '1998-12-20', '$2a$10$1BGtLrCVTcIECocMW6LaMulVdIoKDiAVQ/xppmG6qDv8GzNP5i/1u','user20@hotmail.com', 'Raquel Matos', 0, 0, true, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user19', '1998-12-19', '$2a$10$bFuJiLz1Q4HxawPwZ4FF1eOlROK1MmTfwf4qfDtakoYEDctIiUJX6','user19@hotmail.com', 'Rita Pereira', 0, 0, false, 0, 0, 0.0, 0); 
INSERT INTO `databettingspree`.`user` (`username`, `birthdate`, `password`, `email`, `name`, `followers`, `following`, `private`, `balance`, `copiaspriv`, `avgodd`, `rankscore`) VALUES ('user17', '1998-12-17', '$2a$10$liO06TSjtPMLi0wWlqQPv.uQB3tUgnrbYKV/fazdrtferg0rwc4F6','user17@hotmail.com', 'Sara Guedes', 0, 0, false, 0, 0, 0.0, 0); 

INSERT INTO `databettingspree`.`group` (`idgroup`, `createdby`, `name`) VALUES (-1, 1, 'Apagados');

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
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-18 17:05:52', 1, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-18 17:05:52', 1, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-18 17:05:52', 1, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-18 17:05:52', 2, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', false, '2021-01-18 17:05:52', 2, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-18 17:05:52', 3, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', true, '2021-01-18 17:05:52', 2, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', true, '2021-01-18 17:05:52', 3, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-18 17:05:52', 4, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-18 17:05:52', 3, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-18 17:05:52', 4, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-18 17:05:52', 4, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-18 17:05:52', 5, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', true, '2021-01-18 17:05:52', 5, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-18 17:05:52', 6, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', true, '2021-01-18 17:05:52', 6, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-18 17:05:52', 5, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-18 17:05:52', 7, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-18 17:05:52', 7, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-18 17:05:52', 6, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-18 17:05:52', 8, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-18 17:05:52', 8, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-18 17:05:52', 8, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-18 17:05:52', 9, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-18 17:05:52', 7, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-18 17:05:52', 9, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-18 17:05:52', 10, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', true, '2021-01-18 17:05:52', 10, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-18 17:05:52', 10, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-18 17:05:52', 11, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-18 17:05:52', 9, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', true, '2021-01-18 17:05:52', 11, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-18 17:05:52', 11, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', false, '2021-01-18 17:05:52', 12, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-18 17:05:52', 12, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-18 17:05:52', 12, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-18 17:05:52', 13, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-18 17:05:52', 13, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-18 17:05:52', 13, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa noite, viram o jogo do Real Madrid? Levou baile do Shakthar.', false, '2021-01-18 17:05:52', 14, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-18 17:05:52', 14, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', true, '2021-01-18 17:05:52', 14, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', true, '2021-01-18 17:05:52', 15, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-18 17:05:52', 15, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-18 17:05:52', 15, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-18 17:05:52', 16, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-18 17:05:52', 17, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', true, '2021-01-18 17:05:52', 16, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-18 17:05:52', 16, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-18 17:05:52', 18, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', true, '2021-01-18 17:05:52', 17, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-18 17:05:52', 17, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Bom dia, acham que é seguro apostar no Tondela ou é muito arriscado?', true, '2021-01-18 17:05:52', 18, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Estou farto de apostar no Barcelona e perder dinheiro.', false, '2021-01-18 17:05:52', 19, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', false, '2021-01-18 17:05:52', 18, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', true, '2021-01-18 17:05:52', 19, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-18 17:05:52', 19, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Esta aplicação está muito boa! Já recomendei aos meus amigos', true, '2021-01-18 17:05:52', 20, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Sigam as minhas apostas se quiserem ganhar dinheiro!', false, '2021-01-18 17:05:52', 20, null, null, null); 
INSERT INTO `databettingspree`.`post` (`text`, `public`, `date`, `iduser`, `idbet`, `betpublic`, `idgroup`) VALUES ('Boa tarde, acham que o Manchester United ganha hoje?', false, '2021-01-18 17:05:52', 20, null, null, null); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (1, 1); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (1, 2); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (5, 1); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 1); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 1); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (12, 2); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 2); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (20, 3); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (8, 2); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 3); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (5, 3); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (4, 4); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (6, 3); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 4); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (16, 4); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 5); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (7, 4); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (12, 5); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (4, 5); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 6); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (7, 5); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 6); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (14, 6); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (20, 7); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (7, 7); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 6); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 7); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 7); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (15, 8); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 8); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (9, 8); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (16, 9); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (5, 8); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (12, 9); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (3, 9); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (12, 10); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (3, 10); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (1, 10); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 10); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 11); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 9); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (20, 11); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (5, 11); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (16, 11); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (7, 12); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 12); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (15, 12); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (20, 13); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (10, 13); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 13); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (5, 14); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (20, 12); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 14); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (14, 14); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 14); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 13); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (8, 15); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (17, 15); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (7, 15); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (14, 15); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (6, 16); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 16); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (9, 16); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 17); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (5, 16); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 17); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (12, 17); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (16, 17); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (18, 18); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (4, 18); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 18); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (5, 19); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 18); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 19); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (3, 19); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (11, 19); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (19, 20); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (13, 20); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (8, 20); 
INSERT INTO `databettingspree`.`follower` (`me`, `following`) VALUES (2, 20); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 3,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 8,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 6,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 14,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 18,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (1, 13,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 5,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 6,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 19,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 2,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (2, 20,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 14,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 17,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 5,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (3, 11,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 7,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 5,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 10,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 18,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 2,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (4, 11,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 15,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 19,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 9,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (5, 16,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 12,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 8,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 13,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 9,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (6, 11,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 15,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 4,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 20,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 11,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (7, 19,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 20,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 1,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 3,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 16,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 5,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (8, 2,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 13,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 5,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 16,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 19,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 14,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (9, 7,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 8,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 11,false); 
INSERT INTO `databettingspree`.`usergroup` (`idgroup`, `iduser`, `isAdmin`) VALUES (10, 7,false); 
