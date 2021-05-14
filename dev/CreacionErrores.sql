-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema MyWorkouts
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema MyWorkouts
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MyWorkouts` DEFAULT CHARACTER SET utf8 ;
USE `MyWorkouts` ;

-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_errors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_errors` (
  `errorid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `message` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`errorid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_errorHistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_errorHistory` (
  `errorHistoryid` INT NOT NULL AUTO_INCREMENT,
  `posttime` DATETIME NOT NULL,
  `errorid` INT NOT NULL,
  PRIMARY KEY (`errorHistoryid`),
  INDEX `fk_wk_errorHistory_wk_errors_idx` (`errorid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_errorHistory_wk_errors`
    FOREIGN KEY (`errorid`)
    REFERENCES `MyWorkouts`.`wk_errors` (`errorid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO wk_errors(errorid, name, message)
VALUES (45000, 'NOT_ENOUGH_MONEY', 'La cantidad de dinero ingresada no es suficiente para realizar el pago.');
