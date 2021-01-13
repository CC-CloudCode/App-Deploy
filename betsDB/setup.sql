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

use betsbettingspree;


CREATE USER 'bettingspree'@'%' IDENTIFIED BY 'PEI2020';
ALTER USER 'bettingspree'@'%' IDENTIFIED WITH mysql_native_password BY 'PEI2020';
GRANT ALL PRIVILEGES ON * . * TO 'bettingspree'@'%';
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
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (12, 2790, 34,9,8,3,2,2,2,4,4,10,8,15,12,17,5,4,8,18,27,-9.0,15,"Premier League", 19,"LLDLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (13, 2790, 39,8,9,3,3,3,1,2,5,9,9,8,16,17,6,4,7,18,24,-6.0,13,"Premier League", 22,"DLDLW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (14, 2790, 63,8,9,3,4,2,0,3,5,13,17,13,20,17,7,2,8,30,33,-3.0,12,"Premier League", 23,"LWWLW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (15, 2790, 42,8,9,3,4,1,1,4,4,9,11,11,8,17,7,2,8,20,19,1.0,11,"Premier League", 23,"WWWLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (16, 2790, 51,9,8,0,2,5,3,4,3,10,11,15,13,17,2,8,7,21,28,-7.0,17,"Premier League", 14,"DLDDD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (17, 2790, 44,7,8,3,1,1,3,3,4,5,4,7,13,15,4,4,7,9,20,-11.0,16,"Premier League", 16,"WLWDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (18, 2790, 36,8,7,1,1,3,2,4,4,6,7,12,11,15,2,5,8,13,23,-10.0,18,"Premier League", 11,"DDDDL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (19, 2790, 60,9,8,1,0,2,3,6,5,5,6,24,15,17,1,5,11,11,39,-28.0,19,"Premier League", 8,"LLDLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (20, 2790, 62,9,9,1,0,1,1,7,8,5,4,12,17,18,1,2,15,9,29,-20.0,20,"Premier League", 5,"WLLLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (21, 2833, 548,9,10,3,5,4,2,2,3,12,17,7,9,19,8,6,5,29,16,13.0,5,"Primera División", 30,"LDWLL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (22, 2833, 530,8,7,7,5,1,1,0,1,19,10,2,4,15,12,2,1,29,6,23.0,1,"Primera División", 38,"WWWWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (23, 2833, 541,8,10,6,5,0,4,2,1,15,15,5,10,18,11,4,3,30,15,15.0,2,"Primera División", 37,"DWDWW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (24, 2833, 533,9,9,5,3,4,4,0,2,14,12,7,10,18,8,8,2,26,17,9.0,4,"Primera División", 32,"WWLDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (25, 2833, 536,8,8,5,4,1,2,2,2,12,9,7,6,16,9,3,4,21,13,8.0,6,"Primera División", 30,"WDWWD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (26, 2833, 715,10,8,6,2,2,1,2,5,16,5,13,16,18,8,3,7,21,29,-8.0,7,"Primera División", 27,"WLLWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (27, 2833, 724,9,9,2,4,3,2,4,3,7,8,11,11,18,6,5,7,15,22,-7.0,9,"Primera División", 23,"WDDLL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (28, 2833, 529,9,9,5,5,3,1,1,3,21,16,10,7,18,10,4,4,37,17,20.0,3,"Primera División", 34,"WWWDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (29, 2833, 538,9,9,5,1,0,5,4,3,14,8,16,12,18,6,5,7,22,28,-6.0,8,"Primera División", 23,"LLWDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (30, 2833, 543,8,10,3,4,2,0,3,6,10,12,11,20,18,7,2,9,22,31,-9.0,10,"Primera División", 23,"WDLWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (31, 2833, 545,9,9,1,3,4,3,4,3,4,11,8,10,18,4,7,7,15,18,-3.0,15,"Primera División", 19,"LWDLL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (32, 2833, 532,9,9,2,2,4,3,3,4,14,10,13,12,18,4,7,7,24,25,-1.0,14,"Primera División", 19,"WDLLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (33, 2833, 531,9,9,5,1,0,3,4,5,13,8,8,14,18,6,3,9,21,22,-1.0,12,"Primera División", 21,"LWLDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (34, 2833, 797,9,7,1,2,5,2,3,3,8,6,13,8,16,3,7,6,14,21,-7.0,18,"Primera División", 16,"LLDDL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (35, 2833, 542,9,9,2,2,4,2,3,5,7,9,9,14,18,4,6,8,16,23,-7.0,16,"Primera División", 18,"LLDWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (36, 2833, 546,9,8,3,2,2,3,4,3,8,7,8,10,17,5,5,7,15,18,-3.0,13,"Primera División", 20,"WLLDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (37, 2833, 720,9,9,2,2,3,3,4,4,9,7,14,11,18,4,6,8,16,25,-9.0,17,"Primera División", 18,"LWDLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (38, 2833, 539,8,9,4,1,3,3,1,5,14,9,10,14,17,5,6,6,23,24,-1.0,11,"Primera División", 21,"WLWDW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (39, 2833, 726,9,9,1,0,4,5,4,4,5,9,10,18,18,1,9,8,14,28,-14.0,20,"Primera División", 12,"LLLDL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (40, 2833, 727,9,9,2,1,3,3,4,5,8,7,13,14,18,3,6,9,15,27,-12.0,19,"Primera División", 15,"LDDDD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (41, 2826, 228,6,7,5,6,1,1,0,0,14,16,4,4,13,11,2,0,30,8,22.0,1,"Primeira Liga", 35,"WWWWD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (42, 2826, 211,7,6,6,4,0,1,1,1,15,13,7,6,13,10,1,2,28,13,15.0,3,"Primeira Liga", 31,"WDWWW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (43, 2826, 212,7,6,6,4,0,1,1,1,18,17,8,8,13,10,1,2,35,16,19.0,2,"Primeira Liga", 31,"WWWWW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (44, 2826, 217,6,7,5,4,0,0,1,3,9,14,3,10,13,9,0,4,23,13,10.0,4,"Primeira Liga", 27,"WLWWL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (45, 2826, 224,6,6,2,4,0,2,4,0,4,11,9,3,12,6,2,4,15,12,3.0,6,"Primeira Liga", 20,"DLWWW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (46, 2826, 234,6,7,4,2,1,3,1,2,10,7,6,6,13,6,4,3,17,12,5.0,5,"Primeira Liga", 22,"WWDDL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (47, 2826, 227,6,7,1,3,2,1,3,3,4,8,8,8,13,4,3,6,12,16,-4.0,7,"Primeira Liga", 15,"DDLLW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (48, 2826, 221,7,6,1,1,3,3,3,2,5,1,8,3,13,2,6,5,6,11,-5.0,14,"Primeira Liga", 12,"LDLLW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (49, 2826, 226,6,7,2,1,2,3,2,3,6,3,6,9,13,3,5,5,9,15,-6.0,9,"Primeira Liga", 14,"WLLLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (50, 2826, 225,7,5,2,1,3,1,2,3,9,2,10,5,12,3,4,5,11,15,-4.0,11,"Primeira Liga", 13,"LWLLL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (51, 2826, 242,7,6,1,1,3,2,3,3,9,5,16,8,13,2,5,6,14,24,-10.0,16,"Primeira Liga", 11,"LLLDD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (52, 2826, 762,6,7,2,1,2,2,2,4,5,5,5,10,13,3,4,6,10,15,-5.0,12,"Primeira Liga", 13,"LDWLD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (53, 2826, 215,7,6,3,0,3,2,1,4,9,1,6,9,13,3,5,5,10,15,-5.0,10,"Primeira Liga", 14,"DLWDD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (54, 2826, 231,7,6,3,0,2,1,2,5,12,3,9,10,13,3,3,7,15,19,-4.0,13,"Primeira Liga", 12,"WLDLW");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (55, 2826, 218,7,6,3,0,2,1,2,5,5,5,7,15,13,3,3,7,10,22,-12.0,15,"Primeira Liga", 12,"LWLDL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (56, 2826, 222,6,7,1,0,2,6,3,1,5,8,11,10,13,1,8,4,13,21,-8.0,17,"Primeira Liga", 11,"DDLDD");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (57, 2826, 216,6,7,2,1,2,0,2,6,5,4,5,12,13,3,2,8,9,17,-8.0,18,"Primeira Liga", 11,"LWLDL");
INSERT INTO team_stats (idteam_stats, idleague, idteam, matchsPlayedHome, matchsPlayedAway, winsHome,winsAway, drawsHome, drawsAway, losesHome, losesAway, goalsForHome,goalsForAway, goalsAgainstHome, goalsAgainstAway,matchsPlayedTotal, winsTotal, drawsTotal, losesTotal, goalsForTotal, goalsAgainstTotal, goalsDiff, position, team_stats.group, points, forme) VALUES (58, 2826, 214,6,7,2,2,2,0,2,5,5,10,5,13,13,4,2,7,15,18,-3.0,8,"Primeira Liga", 14,"LDWWL");
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592141, "2021-01-12T20:15:00", 44, 33,2790, "Not Started", 6.5,1.48,4.5, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592255, "2020-12-12T16:26:00", 63, 48,2790, "Match Finished", 2.1,3.25,3.75, 1, 2);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592262, "2020-12-17T18:00:00", 66, 44,2790, "Not Started", 1.7,4.75,4.0, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592266, "2020-12-17T20:00:00", 62, 33,2790, "Not Started", 6.5,1.48,4.5, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592316, "2021-01-12T18:00:00", 62, 34,2790, "Not Started", 2.4,3.2,3.1, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592318, "2021-01-12T20:15:00", 39, 45,2790, "Not Started", 2.5,2.9,3.3, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592322, "2021-01-17T12:00:00", 66, 45,2790, "Not Started", 2.25,2.95,3.75, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592326, "2021-01-17T16:30:00", 40, 33,2790, "Not Started", 1.95,3.6,3.8, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592327, "2021-01-17T19:15:00", 50, 52,2790, "Not Started", 1.16,15.5,8.0, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (592328, "2021-01-17T14:05:00", 62, 47,2790, "Not Started", 6.5,1.5,4.33, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (601138, "2021-01-17T20:00:00", 762, 214,2826, "Not Started", 0.0,0.0,0.0, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (601140, "2021-01-17T15:00:00", 225, 215,2826, "Not Started", 0.0,0.0,0.0, 0, 0);
INSERT INTO fixture (idfixture, begintime, hometeam,awayteam, idleague, state, oddhome, oddaway, odddraw, scoreHome, scoreAway) VALUES (601141, "2021-01-17T17:30:00", 227, 242,2826, "Not Started", 0.0,0.0,0.0, 0, 0);
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
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (92,592322,66, 45,"1-0", "2010-08-29T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (93,592322,45, 66,"2-2", "2011-04-02T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (94,592322,45, 66,"2-2", "2011-09-10T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (95,592322,66, 45,"1-1", "2012-01-14T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (96,592322,66, 45,"1-3", "2012-08-25T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (97,592322,45, 66,"3-3", "2013-02-02T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (98,592322,66, 45,"0-2", "2013-10-26T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (99,592322,45, 66,"2-1", "2014-02-01T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (100,592322,45, 66,"3-0", "2014-10-18T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (101,592322,66, 45,"3-2", "2015-05-02T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (102,592322,45, 66,"4-0", "2015-11-21T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (103,592322,66, 45,"1-3", "2016-03-01T19:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (104,592322,66, 45,"2-0", "2019-08-23T19:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (105,592322,45, 66,"1-1", "2020-07-16T17:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (106,592322,66, 45,"None", "2021-01-17T12:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (107,592322,45, 66,"None", "2021-05-01T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (108,592328,47, 62,"1-0", "2015-01-21T20:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (109,592328,62, 47,"2-2", "2015-01-28T19:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (110,592328,47, 62,"1-1", "2019-11-09T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (111,592328,62, 47,"3-1", "2020-07-02T17:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (112,592328,62, 47,"None", "2021-01-17T14:05:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (113,592328,47, 62,"None", "2021-05-01T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (114,601140,215, 225,"3-1", "2012-08-26T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (115,601140,225, 215,"1-2", "2013-02-03T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (116,601140,225, 215,"0-1", "2014-08-17T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (117,601140,215, 225,"2-3", "2015-01-25T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (118,601140,215, 225,"2-0", "2015-12-20T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (119,601140,225, 215,"0-1", "2016-04-24T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (120,601140,215, 225,"3-1", "2016-12-04T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (121,601140,225, 215,"0-1", "2017-04-17T19:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (122,601140,225, 215,"1-2", "2018-08-19T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (123,601140,215, 225,"2-1", "2019-01-28T19:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (124,601140,225, 215,"None", "2021-01-17T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (125,601140,215, 225,"None", "2021-05-09T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (126,592326,33, 40,"3-2", "2010-09-19T12:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (127,592326,40, 33,"3-1", "2011-03-06T13:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (128,592326,40, 33,"1-1", "2011-10-15T11:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (129,592326,40, 33,"2-1", "2012-01-28T12:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (130,592326,33, 40,"2-1", "2012-02-11T12:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (131,592326,40, 33,"1-2", "2012-09-23T12:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (132,592326,33, 40,"2-1", "2013-01-13T13:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (133,592326,40, 33,"1-0", "2013-09-01T12:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (134,592326,33, 40,"1-0", "2013-09-25T18:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (135,592326,33, 40,"0-3", "2014-03-16T13:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (136,592326,33, 40,"3-0", "2014-12-14T13:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (137,592326,40, 33,"1-2", "2015-03-22T13:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (138,592326,33, 40,"3-1", "2015-09-12T16:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (139,592326,40, 33,"0-1", "2016-01-17T14:05:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (140,592326,40, 33,"2-0", "2016-03-10T20:05:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (141,592326,33, 40,"1-1", "2016-03-17T20:05:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (142,592326,40, 33,"0-0", "2016-10-17T19:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (143,592326,33, 40,"1-1", "2017-01-15T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (144,592326,40, 33,"0-0", "2017-10-14T11:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (145,592326,33, 40,"2-1", "2018-03-10T12:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (146,592326,33, 40,"1-4", "2018-07-28T21:05:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (147,592326,40, 33,"3-1", "2018-12-16T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (148,592326,33, 40,"0-0", "2019-02-24T14:05:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (149,592326,33, 40,"1-1", "2019-10-20T15:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (150,592326,40, 33,"2-0", "2020-01-19T16:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (151,592326,40, 33,"None", "2021-01-17T16:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (152,592326,33, 40,"None", "2021-01-23T00:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (153,592326,33, 40,"None", "2021-05-01T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (154,601141,227, 242,"2-1", "2016-08-20T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (155,601141,242, 227,"0-1", "2017-01-28T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (156,601141,242, 227,"5-2", "2017-12-09T11:15:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (157,601141,227, 242,"2-0", "2018-04-22T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (158,601141,227, 242,"0-2", "2019-08-10T15:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (159,601141,242, 227,"0-1", "2020-01-26T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (160,601141,227, 242,"None", "2021-01-17T17:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (161,601141,242, 227,"None", "2021-05-09T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (162,592327,50, 52,"1-0", "2013-12-28T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (163,592327,52, 50,"0-2", "2014-04-27T15:10:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (164,592327,50, 52,"3-0", "2014-12-20T12:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (165,592327,52, 50,"2-1", "2015-04-06T19:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (166,592327,52, 50,"0-1", "2015-09-12T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (167,592327,50, 52,"5-1", "2015-10-28T19:45:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (168,592327,50, 52,"4-0", "2016-01-16T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (169,592327,52, 50,"1-2", "2016-11-19T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (170,592327,52, 50,"0-3", "2017-01-28T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (171,592327,50, 52,"5-0", "2017-05-06T11:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (172,592327,50, 52,"5-0", "2017-09-23T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (173,592327,52, 50,"0-0", "2017-12-31T12:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (174,592327,50, 52,"2-3", "2018-12-22T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (175,592327,52, 50,"1-3", "2019-04-14T13:05:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (176,592327,52, 50,"0-2", "2019-10-19T16:30:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (177,592327,50, 52,"2-2", "2020-01-18T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (178,592327,50, 52,"None", "2021-01-17T19:15:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (179,592327,52, 50,"None", "2021-05-01T14:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (180,601138,762, 214,"0-0", "2011-11-01T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (181,601138,214, 762,"3-2", "2012-03-26T17:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (182,601138,214, 762,"0-0", "2012-08-26T17:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (183,601138,762, 214,"4-2", "2013-02-03T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (184,601138,214, 762,"3-2", "2013-11-24T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (185,601138,762, 214,"1-1", "2014-03-30T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (186,601138,762, 214,"1-2", "2014-08-31T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (187,601138,214, 762,"1-2", "2015-02-08T16:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (188,601138,762, 214,"2-0", "2019-11-03T15:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (189,601138,214, 762,"2-1", "2020-06-15T18:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (190,601138,762, 214,"None", "2021-01-17T20:00:00");
INSERT INTO h2h (idh2h, idfixture, homeTeamId, awayTeamId, score, date) VALUES (191,601138,214, 762,"None", "2021-05-09T15:00:00");
