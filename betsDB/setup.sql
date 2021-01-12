-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema betsbettingspree
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema betsbettingspree
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `betsbettingspree` DEFAULT CHARACTER SET utf8 ;
USE `betsbettingspree` ;

-- -----------------------------------------------------
-- Table `betsbettingspree`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betsbettingspree`.`country` (
  `idcountry` VARCHAR(10) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `flag` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idcountry`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betsbettingspree`.`league`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betsbettingspree`.`league` (
  `idleague` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `logo` VARCHAR(100) NOT NULL,
  `idcountry` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idleague`),
  INDEX `fk_league_country1_idx` (`idcountry` ASC) VISIBLE,
  CONSTRAINT `fk_league_country1`
    FOREIGN KEY (`idcountry`)
    REFERENCES `betsbettingspree`.`country` (`idcountry`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betsbettingspree`.`team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betsbettingspree`.`team` (
  `idteam` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `logo` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idteam`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betsbettingspree`.`team_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betsbettingspree`.`team_stats` (
  `idteam_stats` INT NOT NULL AUTO_INCREMENT,
  `idleague` INT NOT NULL,
  `idteam` INT NOT NULL,
  `matchsPlayedHome` INT NOT NULL,
  `matchsPlayedAway` INT NOT NULL,
  `winsHome` INT NOT NULL,
  `winsAway` INT NOT NULL,
  `drawsHome` INT NOT NULL,
  `drawsAway` INT NOT NULL,
  `losesHome` INT NOT NULL,
  `losesAway` INT NOT NULL,
  `goalsForHome` INT NOT NULL,
  `goalsForAway` INT NOT NULL,
  `goalsAgainstHome` INT NOT NULL,
  `goalsAgainstAway` INT NOT NULL,
  `matchsPlayedTotal` INT NOT NULL,
  `winsTotal` INT NOT NULL,
  `drawsTotal` INT NOT NULL,
  `losesTotal` INT NOT NULL,
  `goalsForTotal` INT NOT NULL,
  `goalsAgainstTotal` INT NOT NULL,
  `goalsDiff` FLOAT NOT NULL,
  `position` INT NOT NULL,
  `group` VARCHAR(50) NULL,
  `points` INT NOT NULL,
  `forme` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idteam_stats`),
  INDEX `fk_team_stats_league1_idx` (`idleague` ASC) VISIBLE,
  INDEX `fk_team_stats_team1_idx` (`idteam` ASC) VISIBLE,
  CONSTRAINT `fk_team_stats_league1`
    FOREIGN KEY (`idleague`)
    REFERENCES `betsbettingspree`.`league` (`idleague`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_team_stats_team1`
    FOREIGN KEY (`idteam`)
    REFERENCES `betsbettingspree`.`team` (`idteam`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betsbettingspree`.`fixture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betsbettingspree`.`fixture` (
  `idfixture` INT NOT NULL,
  `begintime` DATETIME NOT NULL,
  `homeTeam` INT NOT NULL,
  `awayTeam` INT NOT NULL,
  `idleague` INT NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `oddHome` DOUBLE NOT NULL,
  `oddAway` DOUBLE NOT NULL,
  `oddDraw` DOUBLE NOT NULL,
  `scoreHome` INT NULL,
  `scoreAway` INT NULL,
  PRIMARY KEY (`idfixture`),
  INDEX `fk_fixture_team1_idx` (`homeTeam` ASC) VISIBLE,
  INDEX `fk_fixture_team2_idx` (`awayTeam` ASC) VISIBLE,
  INDEX `fk_fixture_league1_idx` (`idleague` ASC) VISIBLE,
  CONSTRAINT `fk_fixture_team1`
    FOREIGN KEY (`homeTeam`)
    REFERENCES `betsbettingspree`.`team` (`idteam`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fixture_team2`
    FOREIGN KEY (`awayTeam`)
    REFERENCES `betsbettingspree`.`team` (`idteam`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fixture_league1`
    FOREIGN KEY (`idleague`)
    REFERENCES `betsbettingspree`.`league` (`idleague`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betsbettingspree`.`h2h`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betsbettingspree`.`h2h` (
  `idh2h` INT NOT NULL AUTO_INCREMENT,
  `idfixture` INT NOT NULL,
  `homeTeamId` INT NOT NULL,
  `awayTeamId` INT NOT NULL,
  `score` VARCHAR(10) NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`idh2h`),
  INDEX `fk_h2h_fixture1_idx` (`idfixture` ASC) VISIBLE,
  CONSTRAINT `fk_h2h_fixture1`
    FOREIGN KEY (`idfixture`)
    REFERENCES `betsbettingspree`.`fixture` (`idfixture`)
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


-- ----------------------------------- Povoamento ------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------




INSERT INTO country (idcountry, name, flag) VALUES ("EN", "England", "https://media.api-sports.io/flags/gb.svg");
INSERT INTO country (idcountry, name, flag) VALUES ("ES", "Spain", "https://media.api-sports.io/flags/es.svg");
INSERT INTO country (idcountry, name, flag) VALUES ("PT", "Portugal", "https://media.api-sports.io/flags/pt.svg");
INSERT INTO league (idleague, name, logo, idcountry) VALUES (2790, "Premier League", "https://media.api-sports.io/football/leagues/39.png", "EN");
INSERT INTO league (idleague, name, logo, idcountry) VALUES (2826, "Primeira Divisão", "https://media.api-sports.io/football/leagues/94.png", "PT");
INSERT INTO league (idleague, name, logo, idcountry) VALUES (2833, "Primera Division", "https://media.api-sports.io/football/leagues/140.png", "ES");
INSERT INTO team (idteam, name, logo) VALUES (33, "Manchester United", "https://media.api-sports.io/football/teams/33.png");
INSERT INTO team (idteam, name, logo) VALUES (34, "Newcastle", "https://media.api-sports.io/football/teams/34.png");
INSERT INTO team (idteam, name, logo) VALUES (36, "Fulham", "https://media.api-sports.io/football/teams/36.png");
INSERT INTO team (idteam, name, logo) VALUES (39, "Wolves", "https://media.api-sports.io/football/teams/39.png");
INSERT INTO team (idteam, name, logo) VALUES (40, "Liverpool", "https://media.api-sports.io/football/teams/40.png");
INSERT INTO team (idteam, name, logo) VALUES (41, "Southampton", "https://media.api-sports.io/football/teams/41.png");
INSERT INTO team (idteam, name, logo) VALUES (42, "Arsenal", "https://media.api-sports.io/football/teams/42.png");
INSERT INTO team (idteam, name, logo) VALUES (44, "Burnley", "https://media.api-sports.io/football/teams/44.png");
INSERT INTO team (idteam, name, logo) VALUES (45, "Everton", "https://media.api-sports.io/football/teams/45.png");
INSERT INTO team (idteam, name, logo) VALUES (46, "Leicester", "https://media.api-sports.io/football/teams/46.png");
INSERT INTO team (idteam, name, logo) VALUES (47, "Tottenham", "https://media.api-sports.io/football/teams/47.png");
INSERT INTO team (idteam, name, logo) VALUES (48, "West Ham", "https://media.api-sports.io/football/teams/48.png");
INSERT INTO team (idteam, name, logo) VALUES (49, "Chelsea", "https://media.api-sports.io/football/teams/49.png");
INSERT INTO team (idteam, name, logo) VALUES (50, "Manchester City", "https://media.api-sports.io/football/teams/50.png");
INSERT INTO team (idteam, name, logo) VALUES (51, "Brighton", "https://media.api-sports.io/football/teams/51.png");
INSERT INTO team (idteam, name, logo) VALUES (52, "Crystal Palace", "https://media.api-sports.io/football/teams/52.png");
INSERT INTO team (idteam, name, logo) VALUES (60, "West Brom", "https://media.api-sports.io/football/teams/60.png");
INSERT INTO team (idteam, name, logo) VALUES (62, "Sheffield Utd", "https://media.api-sports.io/football/teams/62.png");
INSERT INTO team (idteam, name, logo) VALUES (63, "Leeds", "https://media.api-sports.io/football/teams/63.png");
INSERT INTO team (idteam, name, logo) VALUES (66, "Aston Villa", "https://media.api-sports.io/football/teams/66.png");
INSERT INTO team (idteam, name, logo) VALUES (211, "Benfica", "https://media.api-sports.io/football/teams/211.png");
INSERT INTO team (idteam, name, logo) VALUES (212, "FC Porto", "https://media.api-sports.io/football/teams/212.png");
INSERT INTO team (idteam, name, logo) VALUES (214, "Maritimo", "https://media.api-sports.io/football/teams/214.png");
INSERT INTO team (idteam, name, logo) VALUES (215, "Moreirense", "https://media.api-sports.io/football/teams/215.png");
INSERT INTO team (idteam, name, logo) VALUES (216, "Portimonense", "https://media.api-sports.io/football/teams/216.png");
INSERT INTO team (idteam, name, logo) VALUES (217, "SC Braga", "https://media.api-sports.io/football/teams/217.png");
INSERT INTO team (idteam, name, logo) VALUES (218, "Tondela", "https://media.api-sports.io/football/teams/218.png");
INSERT INTO team (idteam, name, logo) VALUES (221, "Belenenses", "https://media.api-sports.io/football/teams/221.png");
INSERT INTO team (idteam, name, logo) VALUES (222, "Boavista", "https://media.api-sports.io/football/teams/222.png");
INSERT INTO team (idteam, name, logo) VALUES (224, "Guimaraes", "https://media.api-sports.io/football/teams/224.png");
INSERT INTO team (idteam, name, logo) VALUES (225, "Nacional", "https://media.api-sports.io/football/teams/225.png");
INSERT INTO team (idteam, name, logo) VALUES (226, "Rio Ave", "https://media.api-sports.io/football/teams/226.png");
INSERT INTO team (idteam, name, logo) VALUES (227, "Santa Clara", "https://media.api-sports.io/football/teams/227.png");
INSERT INTO team (idteam, name, logo) VALUES (228, "Sporting CP", "https://media.api-sports.io/football/teams/228.png");
INSERT INTO team (idteam, name, logo) VALUES (231, "Farense", "https://media.api-sports.io/football/teams/231.png");
INSERT INTO team (idteam, name, logo) VALUES (234, "Pacos Ferreira", "https://media.api-sports.io/football/teams/234.png");
INSERT INTO team (idteam, name, logo) VALUES (242, "Famalicao", "https://media.api-sports.io/football/teams/242.png");
INSERT INTO team (idteam, name, logo) VALUES (529, "Barcelona", "https://media.api-sports.io/football/teams/529.png");
INSERT INTO team (idteam, name, logo) VALUES (530, "Atletico Madrid", "https://media.api-sports.io/football/teams/530.png");
INSERT INTO team (idteam, name, logo) VALUES (531, "Athletic Club", "https://media.api-sports.io/football/teams/531.png");
INSERT INTO team (idteam, name, logo) VALUES (532, "Valencia", "https://media.api-sports.io/football/teams/532.png");
INSERT INTO team (idteam, name, logo) VALUES (533, "Villarreal", "https://media.api-sports.io/football/teams/533.png");
INSERT INTO team (idteam, name, logo) VALUES (536, "Sevilla", "https://media.api-sports.io/football/teams/536.png");
INSERT INTO team (idteam, name, logo) VALUES (538, "Celta Vigo", "https://media.api-sports.io/football/teams/538.png");
INSERT INTO team (idteam, name, logo) VALUES (539, "Levante", "https://media.api-sports.io/football/teams/539.png");
INSERT INTO team (idteam, name, logo) VALUES (541, "Real Madrid", "https://media.api-sports.io/football/teams/541.png");
INSERT INTO team (idteam, name, logo) VALUES (542, "Alaves", "https://media.api-sports.io/football/teams/542.png");
INSERT INTO team (idteam, name, logo) VALUES (543, "Real Betis", "https://media.api-sports.io/football/teams/543.png");
INSERT INTO team (idteam, name, logo) VALUES (545, "Eibar", "https://media.api-sports.io/football/teams/545.png");
INSERT INTO team (idteam, name, logo) VALUES (546, "Getafe", "https://media.api-sports.io/football/teams/546.png");
INSERT INTO team (idteam, name, logo) VALUES (548, "Real Sociedad", "https://media.api-sports.io/football/teams/548.png");
INSERT INTO team (idteam, name, logo) VALUES (715, "Granada CF", "https://media.api-sports.io/football/teams/715.png");
INSERT INTO team (idteam, name, logo) VALUES (720, "Valladolid", "https://media.api-sports.io/football/teams/720.png");
INSERT INTO team (idteam, name, logo) VALUES (724, "Cadiz", "https://media.api-sports.io/football/teams/724.png");
INSERT INTO team (idteam, name, logo) VALUES (726, "Huesca", "https://media.api-sports.io/football/teams/726.png");
INSERT INTO team (idteam, name, logo) VALUES (727, "Osasuna", "https://media.api-sports.io/football/teams/727.png");
INSERT INTO team (idteam, name, logo) VALUES (762, "GIL Vicente", "https://media.api-sports.io/football/teams/762.png");
INSERT INTO team (idteam, name, logo) VALUES (797, "Elche", "https://media.api-sports.io/football/teams/797.png");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (1, 2790, 47,8,8,4,4,2,3,2,1,13,16,8,7,16,8,5,3,29,15,14.0,4,"Premier League", 29,"WDLLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (2, 2790, 40,8,9,7,2,1,5,0,2,21,16,8,13,17,9,6,2,37,21,16.0,1,"Premier League", 33,"LDDWW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (3, 2790, 46,8,9,3,7,1,1,4,1,11,20,12,9,17,10,2,5,31,21,10.0,3,"Premier League", 32,"WDDWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (4, 2790, 41,9,8,5,3,1,4,3,1,14,12,9,10,17,8,5,4,26,19,7.0,6,"Premier League", 29,"WDDLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (5, 2790, 49,9,8,4,3,3,2,2,3,19,13,11,10,17,7,5,5,32,21,11.0,9,"Premier League", 26,"LDLWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (6, 2790, 48,8,9,3,4,3,2,2,3,12,12,10,11,17,7,5,5,24,21,3.0,10,"Premier League", 26,"WDDLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (7, 2790, 45,8,8,4,5,1,1,3,2,15,11,12,8,16,9,2,5,26,20,6.0,7,"Premier League", 29,"LWWWW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (8, 2790, 33,9,7,4,6,2,1,3,0,12,21,13,11,16,10,3,3,33,24,9.0,2,"Premier League", 33,"WWDWW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (9, 2790, 50,7,8,4,4,2,3,1,1,14,10,7,6,15,8,5,2,24,13,11.0,5,"Premier League", 29,"WWWDD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (10, 2790, 66,7,8,3,5,1,1,3,2,15,14,11,5,15,8,2,5,29,16,13.0,8,"Premier League", 26,"LDWWD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (11, 2790, 52,9,8,3,3,3,1,3,4,11,11,15,14,17,6,4,7,22,29,-7.0,14,"Premier League", 22,"WDLLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (12, 2790, 34,9,7,3,2,2,2,4,3,10,8,15,11,16,5,4,7,18,26,-8.0,15,"Premier League", 19,"LDLDL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (13, 2790, 39,8,9,3,3,3,1,2,5,9,9,8,16,17,6,4,7,18,24,-6.0,13,"Premier League", 22,"DLDLW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (14, 2790, 63,8,9,3,4,2,0,3,5,13,17,13,20,17,7,2,8,30,33,-3.0,12,"Premier League", 23,"LWWLW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (15, 2790, 42,8,9,3,4,1,1,4,4,9,11,11,8,17,7,2,8,20,19,1.0,11,"Premier League", 23,"WWWLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (16, 2790, 51,9,8,0,2,5,3,4,3,10,11,15,13,17,2,8,7,21,28,-7.0,17,"Premier League", 14,"DLDDD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (17, 2790, 44,7,8,3,1,1,3,3,4,5,4,7,13,15,4,4,7,9,20,-11.0,16,"Premier League", 16,"WLWDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (18, 2790, 36,8,7,1,1,3,2,4,4,6,7,12,11,15,2,5,8,13,23,-10.0,18,"Premier League", 11,"DDDDL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (19, 2790, 60,9,8,1,0,2,3,6,5,5,6,24,15,17,1,5,11,11,39,-28.0,19,"Premier League", 8,"LLDLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (20, 2790, 62,8,9,0,0,1,1,7,8,4,4,12,17,17,0,2,15,8,29,-21.0,20,"Premier League", 2,"LLLDL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (21, 2833, 548,9,9,3,5,4,2,2,2,12,15,7,6,18,8,6,4,27,13,14.0,4,"Primera División", 30,"DWLLL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (22, 2833, 530,8,7,7,5,1,1,0,1,19,10,2,4,15,12,2,1,29,6,23.0,1,"Primera División", 38,"WWWWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (23, 2833, 541,8,9,6,5,0,3,2,1,15,15,5,10,17,11,3,3,30,15,15.0,2,"Primera División", 36,"WDWWW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (24, 2833, 533,9,8,5,2,4,4,0,2,14,8,7,10,17,7,8,2,22,17,5.0,5,"Primera División", 29,"WLDWD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (25, 2833, 536,7,8,4,4,1,2,2,2,9,9,5,6,15,8,3,4,18,11,7.0,6,"Primera División", 27,"DWWDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (26, 2833, 715,8,8,5,2,2,1,1,5,14,5,9,16,16,7,3,6,19,25,-6.0,7,"Primera División", 24,"LWLWW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (27, 2833, 724,8,9,1,4,3,2,4,3,4,8,10,11,17,5,5,7,12,21,-9.0,10,"Primera División", 20,"DDLLL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (28, 2833, 529,9,8,5,4,3,1,1,3,21,12,10,7,17,9,4,4,33,17,16.0,3,"Primera División", 31,"WWDWD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (29, 2833, 538,8,9,5,1,0,5,3,3,14,8,12,12,17,6,5,6,22,24,-2.0,8,"Primera División", 23,"LWDWW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (30, 2833, 543,8,9,3,3,2,0,3,6,10,10,11,20,17,6,2,9,20,31,-11.0,11,"Primera División", 20,"DLWLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (31, 2833, 545,9,8,1,3,4,3,4,2,4,10,8,8,17,4,7,6,14,16,-2.0,12,"Primera División", 19,"WDLLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (32, 2833, 532,9,8,2,1,4,3,3,4,14,9,13,12,17,3,7,7,23,25,-2.0,17,"Primera División", 16,"DLLDD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (33, 2833, 531,9,9,5,1,0,3,4,5,13,8,8,14,18,6,3,9,21,22,-1.0,9,"Primera División", 21,"LWLDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (34, 2833, 797,8,7,1,2,5,2,2,3,7,6,10,8,15,3,7,5,13,18,-5.0,18,"Primera División", 16,"LDDLL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (35, 2833, 542,9,8,2,2,4,2,3,4,7,8,9,11,17,4,6,7,15,20,-5.0,14,"Primera División", 18,"LDWLL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (36, 2833, 546,9,7,3,1,2,3,4,3,8,4,8,9,16,4,5,7,12,17,-5.0,16,"Primera División", 17,"LLDWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (37, 2833, 720,8,9,2,2,3,3,3,4,9,7,13,11,17,4,6,7,16,24,-8.0,15,"Primera División", 18,"WDLDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (38, 2833, 539,7,9,3,1,3,3,1,5,12,9,9,14,16,4,6,6,21,23,-2.0,13,"Primera División", 18,"LWDWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (39, 2833, 726,8,9,1,0,4,5,3,4,5,9,8,18,17,1,9,7,14,26,-12.0,20,"Primera División", 12,"LLDLW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (40, 2833, 727,8,8,2,1,2,3,4,4,8,7,13,12,16,3,5,8,15,25,-10.0,19,"Primera División", 14,"DDDLL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (41, 2826, 228,6,6,5,5,1,1,0,0,14,14,4,4,12,10,2,0,28,8,20.0,1,"Primeira Liga", 32,"WWWDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (42, 2826, 211,6,6,5,4,0,1,1,1,13,13,7,6,12,9,1,2,26,13,13.0,3,"Primeira Liga", 28,"DWWWW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (43, 2826, 212,7,5,6,3,0,1,1,1,18,13,8,7,12,9,1,2,31,15,16.0,2,"Primeira Liga", 28,"WWWWW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (44, 2826, 217,5,7,4,4,0,0,1,3,7,14,2,10,12,8,0,4,21,12,9.0,4,"Primeira Liga", 24,"LWWLW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (45, 2826, 224,6,5,2,4,0,1,4,0,4,9,9,1,11,6,1,4,13,10,3.0,5,"Primeira Liga", 19,"LWWWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (46, 2826, 234,6,6,4,1,1,3,1,2,10,5,6,6,12,5,4,3,15,12,3.0,6,"Primeira Liga", 19,"WDDLW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (47, 2826, 227,6,6,1,3,2,0,3,3,4,7,8,7,12,4,2,6,11,15,-4.0,7,"Primeira Liga", 14,"DLLWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (48, 2826, 221,6,6,1,1,3,3,2,2,5,1,6,3,12,2,6,4,6,9,-3.0,12,"Primeira Liga", 12,"DLLWD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (49, 2826, 226,5,7,1,1,2,3,2,3,3,3,6,9,12,2,5,5,6,15,-9.0,16,"Primeira Liga", 11,"LLLDL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (50, 2826, 225,6,5,2,1,3,1,1,3,9,2,8,5,11,3,4,4,11,13,-2.0,9,"Primeira Liga", 13,"WLLLW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (51, 2826, 242,6,6,1,1,3,2,2,3,8,5,12,8,12,2,5,5,13,20,-7.0,14,"Primeira Liga", 11,"LLDDL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (52, 2826, 762,6,6,2,1,2,2,2,3,5,4,5,7,12,3,4,5,9,12,-3.0,11,"Primeira Liga", 13,"DWLDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (53, 2826, 215,6,6,3,0,2,2,1,4,7,1,4,9,12,3,4,5,8,13,-5.0,10,"Primeira Liga", 13,"LWDDL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (54, 2826, 231,6,6,2,0,2,1,2,5,9,3,8,10,12,2,3,7,12,18,-6.0,18,"Primeira Liga", 9,"LDLWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (55, 2826, 218,7,5,3,0,2,1,2,4,5,5,7,13,12,3,3,6,10,20,-10.0,13,"Primeira Liga", 12,"WLDLL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (56, 2826, 222,5,7,1,0,1,6,3,1,4,8,10,10,12,1,7,4,12,20,-8.0,17,"Primeira Liga", 10,"DLDDD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (57, 2826, 216,6,6,2,1,2,0,2,5,5,4,5,9,12,3,2,7,9,14,-5.0,15,"Primeira Liga", 11,"WLDLW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (58, 2826, 214,6,6,2,2,2,0,2,4,5,9,5,11,12,4,2,6,14,16,-2.0,8,"Primeira Liga", 14,"DWWLL");
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592141, "2021-01-12T20:15:00", 44, 33,2790, "Not Started", 6.5,1.48,4.5, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592255, "2020-12-12T16:26:00", 63, 48,2790, "Match Finished", 2.1,3.25,3.75, 1, 2);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592262, "2020-12-17T18:00:00", 66, 44,2790, "Not Started", 1.7,4.75,4.0, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592266, "2020-12-17T20:00:00", 62, 33,2790, "Not Started", 6.5,1.48,4.5, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592316, "2021-01-12T18:00:00", 62, 34,2790, "Not Started", 2.4,3.2,3.1, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592318, "2021-01-12T20:15:00", 39, 45,2790, "Not Started", 2.5,2.9,3.3, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (605074, "2021-01-12T20:30:00", 530, 536,2833, "Not Started", 2.05,4.25,2.9, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (605099, "2021-01-12T18:00:00", 715, 727,2833, "Not Started", 2.35,3.4,2.85, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (605187, "2020-12-14T22:10:00", 538, 724,2833, "Match Finished", 1.75,4.6,3.6, 4, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (605193, "2020-12-12T16:26:00", 720, 727,2833, "Match Finished", 2.25,3.3,3.1, 3, 2);
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (1,605187,538, 724,"None", "2020-12-14T20:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (2,605187,724, 538,"None", "2021-04-28T00:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (3,592255,48, 63,"2-2", "2011-08-21T12:15:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (4,592255,63, 48,"1-1", "2012-03-17T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (5,592255,63, 48,"None", "2020-12-11T20:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (6,592255,48, 63,"None", "2021-03-06T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (7,605193,727, 720,"0-1", "2012-11-04T16:50:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (8,605193,720, 727,"1-3", "2013-03-31T10:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (9,605193,720, 727,"0-1", "2013-11-22T20:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (10,605193,727, 720,"0-0", "2014-04-11T19:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (11,605193,727, 720,"4-2", "2018-01-07T11:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (12,605193,720, 727,"2-0", "2018-06-02T18:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (13,605193,720, 727,"1-1", "2019-09-15T16:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (14,605193,727, 720,"0-0", "2020-01-18T17:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (15,605193,720, 727,"None", "2020-12-11T20:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (16,605193,727, 720,"None", "2021-03-14T00:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (17,592262,44, 66,"1-1", "2014-11-29T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (18,592262,66, 44,"0-1", "2015-05-24T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (19,592262,66, 44,"2-2", "2019-09-28T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (20,592262,44, 66,"1-2", "2020-01-01T12:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (21,592262,66, 44,"None", "2020-12-17T18:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (22,592262,44, 66,"None", "2021-01-26T19:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (23,592266,33, 62,"1-0", "2016-01-09T17:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (24,592266,62, 33,"3-3", "2019-11-24T16:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (25,592266,33, 62,"3-0", "2020-06-24T17:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (26,592266,62, 33,"None", "2020-12-17T20:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (27,592266,33, 62,"None", "2021-01-26T20:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (28,592316,62, 34,"0-2", "2019-12-05T19:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (29,592316,34, 62,"3-0", "2020-06-21T13:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (30,592316,62, 34,"None", "2021-01-12T18:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (31,592316,34, 62,"None", "2021-05-15T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (32,605099,715, 727,"1-1", "2011-09-25T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (33,605099,727, 715,"2-1", "2012-02-26T17:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (34,605099,727, 715,"1-2", "2012-12-22T19:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (35,605099,715, 727,"3-0", "2013-05-18T18:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (36,605099,727, 715,"1-2", "2013-08-18T19:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (37,605099,715, 727,"0-0", "2014-01-18T19:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (38,605099,715, 727,"1-1", "2017-01-15T17:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (39,605099,727, 715,"2-1", "2017-05-13T16:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (40,605099,727, 715,"0-0", "2017-11-05T17:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (41,605099,715, 727,"1-1", "2018-04-07T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (42,605099,715, 727,"2-0", "2018-09-02T19:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (43,605099,727, 715,"1-0", "2019-02-03T17:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (44,605099,715, 727,"1-0", "2019-10-18T19:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (45,605099,727, 715,"0-3", "2020-02-23T11:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (46,605099,715, 727,"None", "2021-01-12T18:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (47,605099,727, 715,"None", "2021-01-24T13:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (48,592141,44, 33,"0-0", "2014-08-30T11:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (49,592141,33, 44,"3-1", "2015-02-11T19:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (50,592141,33, 44,"0-0", "2016-10-29T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (51,592141,44, 33,"0-2", "2017-04-23T13:15:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (52,592141,33, 44,"2-2", "2017-12-26T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (53,592141,44, 33,"0-1", "2018-01-20T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (54,592141,44, 33,"0-2", "2018-09-02T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (55,592141,33, 44,"2-2", "2019-01-29T20:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (56,592141,44, 33,"0-2", "2019-12-28T19:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (57,592141,33, 44,"0-2", "2020-01-22T20:15:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (58,592141,44, 33,"None", "2021-01-12T20:15:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (59,592141,33, 44,"None", "2021-04-17T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (60,592318,45, 39,"1-1", "2010-08-21T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (61,592318,39, 45,"0-3", "2011-04-09T11:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (62,592318,45, 39,"2-1", "2011-11-19T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (63,592318,39, 45,"0-0", "2012-05-06T13:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (64,592318,39, 45,"2-2", "2018-08-11T16:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (65,592318,45, 39,"1-3", "2019-02-02T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (66,592318,45, 39,"3-2", "2019-09-01T13:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (67,592318,39, 45,"3-0", "2020-07-12T11:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (68,592318,39, 45,"None", "2021-01-12T20:15:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (69,592318,45, 39,"None", "2021-05-15T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (70,605074,536, 530,"3-1", "2010-10-03T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (71,605074,530, 536,"2-2", "2011-02-26T17:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (72,605074,530, 536,"0-0", "2011-10-02T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (73,605074,536, 530,"1-1", "2012-03-03T21:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (74,605074,530, 536,"4-0", "2012-11-25T18:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (75,605074,536, 530,"0-1", "2013-04-21T19:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (76,605074,536, 530,"1-3", "2013-08-18T21:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (77,605074,530, 536,"1-1", "2014-01-19T20:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (78,605074,530, 536,"4-0", "2014-09-27T18:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (79,605074,536, 530,"0-0", "2015-03-01T18:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (80,605074,536, 530,"0-3", "2015-08-30T18:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (81,605074,530, 536,"0-0", "2016-01-24T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (82,605074,536, 530,"1-0", "2016-10-23T14:15:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (83,605074,530, 536,"3-1", "2017-03-19T15:15:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (84,605074,530, 536,"2-0", "2017-09-23T11:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (85,605074,536, 530,"2-5", "2018-02-25T19:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (86,605074,536, 530,"1-1", "2019-01-06T15:15:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (87,605074,530, 536,"1-1", "2019-05-12T16:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (88,605074,536, 530,"1-1", "2019-11-02T17:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (89,605074,530, 536,"2-2", "2020-03-07T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (90,605074,530, 536,"None", "2021-01-12T20:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (91,605074,536, 530,"None", "2021-04-04T00:00:00");
