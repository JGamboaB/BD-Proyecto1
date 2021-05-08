-- MySQL Script generated by MySQL Workbench
-- Tue May  4 19:41:57 2021
-- Model: New Model    Version: 1.0
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
-- Table `MyWorkouts`.`wk_paymentStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_paymentStatus` (
  `paymentStatusid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`paymentStatusid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_merchants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_merchants` (
  `merchantid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `enabled` BIT NOT NULL DEFAULT 1,
  `iconUrl` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`merchantid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_genders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_genders` (
  `genderid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`genderid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_users` (
  `userid` BIGINT NOT NULL AUTO_INCREMENT,
  `genderid` TINYINT NOT NULL,
  `email` VARCHAR(250) NOT NULL UNIQUE,
  `username` VARCHAR(20) NOT NULL UNIQUE,
  `password` VARBINARY(250) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `registeredAt` DATETIME NOT NULL,
  PRIMARY KEY (`userid`),
  INDEX `fk_wk_users_wk_genders1_idx` (`genderid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_users_wk_genders1`
    FOREIGN KEY (`genderid`)
    REFERENCES `MyWorkouts`.`wk_genders` (`genderid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_icons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_icons` (
  `iconid` BIGINT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`iconid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_plans` (
  `planid` INT NOT NULL AUTO_INCREMENT,
  `iconid` BIGINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `starttime` DATETIME NOT NULL,
  `endtime` DATETIME NULL,
  `enabled` BIT NOT NULL DEFAULT 1,
  `deleted` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`planid`),
  INDEX `fk_wk_plans_wk_icons1_idx` (`iconid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_plans_wk_icons1`
    FOREIGN KEY (`iconid`)
    REFERENCES `MyWorkouts`.`wk_icons` (`iconid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_clients` (
  `clientid` BIGINT NOT NULL AUTO_INCREMENT,
  `userid` BIGINT NOT NULL,
  `planid` INT NOT NULL,
  PRIMARY KEY (`clientid`),
  INDEX `fk_wk_clients_wk_users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_wk_clients_wk_plans1_idx` (`planid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_clients_wk_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `MyWorkouts`.`wk_users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_clients_wk_plans1`
    FOREIGN KEY (`planid`)
    REFERENCES `MyWorkouts`.`wk_plans` (`planid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_paymentAttemps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_paymentAttemps` (
  `paymentAttempid` BIGINT NOT NULL AUTO_INCREMENT,
  `clientid` BIGINT NOT NULL,
  `paymentStatusid` INT NOT NULL,
  `merchantid` INT NOT NULL,
  `posttime` DATETIME NOT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `currentSymbol` NVARCHAR(3) NOT NULL,
  `errorNumber` BIGINT NULL,
  `merchantTransNumber` BIGINT NOT NULL,
  `description` NVARCHAR(200) NOT NULL,
  `paymentTimeStamp` DATETIME NOT NULL,
  `computerName` VARCHAR(100) NOT NULL,
  `userName` VARCHAR(100) NOT NULL,
  `ipAdress` VARCHAR(16) NOT NULL,
  `checkSum` INT NOT NULL,
  PRIMARY KEY (`paymentAttempid`),
  INDEX `fk_wk_paymentAttemps_wk_paymentStatus1_idx` (`paymentStatusid` ASC) VISIBLE,
  INDEX `fk_wk_paymentAttemps_wk_merchants1_idx` (`merchantid` ASC) VISIBLE,
  INDEX `fk_wk_paymentAttemps_wk_clients1_idx` (`clientid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_paymentAttemps_wk_paymentStatus1`
    FOREIGN KEY (`paymentStatusid`)
    REFERENCES `MyWorkouts`.`wk_paymentStatus` (`paymentStatusid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_paymentAttemps_wk_merchants1`
    FOREIGN KEY (`merchantid`)
    REFERENCES `MyWorkouts`.`wk_merchants` (`merchantid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_paymentAttemps_wk_clients1`
    FOREIGN KEY (`clientid`)
    REFERENCES `MyWorkouts`.`wk_clients` (`clientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_chatStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_chatStatus` (
  `chatStatusid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`chatStatusid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_departments` (
  `departmentid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`departmentid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_employees` (
  `employeeid` BIGINT NOT NULL AUTO_INCREMENT,
  `userid` BIGINT NOT NULL,
  `departmentid` TINYINT NOT NULL,
  PRIMARY KEY (`employeeid`),
  INDEX `fk_wk_employees_wk_users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_wk_employees_wk_departments1_idx` (`departmentid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_employees_wk_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `MyWorkouts`.`wk_users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_employees_wk_departments1`
    FOREIGN KEY (`departmentid`)
    REFERENCES `MyWorkouts`.`wk_departments` (`departmentid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_chatSessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_chatSessions` (
  `chatSessionid` BIGINT NOT NULL AUTO_INCREMENT,
  `chatStatusid` TINYINT NOT NULL,
  `clientid` BIGINT NOT NULL,
  `employeeid` BIGINT NOT NULL,
  `started` DATETIME NOT NULL,
  `deleted` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`chatSessionid`),
  INDEX `fk_wk_chatSessions_wk_chatStatus_idx` (`chatStatusid` ASC) VISIBLE,
  INDEX `fk_wk_chatSessions_wk_clients1_idx` (`clientid` ASC) VISIBLE,
  INDEX `fk_wk_chatSessions_wk_employees1_idx` (`employeeid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_chatSessions_wk_chatStatus`
    FOREIGN KEY (`chatStatusid`)
    REFERENCES `MyWorkouts`.`wk_chatStatus` (`chatStatusid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_chatSessions_wk_clients1`
    FOREIGN KEY (`clientid`)
    REFERENCES `MyWorkouts`.`wk_clients` (`clientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_chatSessions_wk_employees1`
    FOREIGN KEY (`employeeid`)
    REFERENCES `MyWorkouts`.`wk_employees` (`employeeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_messages` (
  `messageid` BIGINT NOT NULL AUTO_INCREMENT,
  `chatSessionid` BIGINT NOT NULL,
  `senderid` BIGINT NOT NULL,
  `content` NVARCHAR(250) NOT NULL,
  `posttime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`messageid`),
  INDEX `fk_wk_messages_wk_chatSessions1_idx` (`chatSessionid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_messages_wk_chatSessions1`
    FOREIGN KEY (`chatSessionid`)
    REFERENCES `MyWorkouts`.`wk_chatSessions` (`chatSessionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_ticketCategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_ticketCategories` (
  `ticketCategoryid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ticketCategoryid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_ticketStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_ticketStatus` (
  `ticketStatusid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ticketStatusid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_ticketPriorities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_ticketPriorities` (
  `ticketPriorityid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ticketPriorityid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_tickets` (
  `ticketid` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(200) NOT NULL,
  `date` DATETIME NOT NULL,
  `ticketCategoryid` TINYINT NOT NULL,
  `ticketStatusid` TINYINT NOT NULL,
  `ticketPriorityid` INT NOT NULL,
  `clientid` BIGINT NOT NULL,
  `employeeid` BIGINT NOT NULL,
  PRIMARY KEY (`ticketid`),
  INDEX `fk_wk_tickets_wk_ticketCategories1_idx` (`ticketCategoryid` ASC) VISIBLE,
  INDEX `fk_wk_tickets_wk_ticketStatus1_idx` (`ticketStatusid` ASC) VISIBLE,
  INDEX `fk_wk_tickets_wk_ticketPriorities1_idx` (`ticketPriorityid` ASC) VISIBLE,
  INDEX `fk_wk_tickets_wk_clients1_idx` (`clientid` ASC) VISIBLE,
  INDEX `fk_wk_tickets_wk_employees1_idx` (`employeeid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_tickets_wk_ticketCategories1`
    FOREIGN KEY (`ticketCategoryid`)
    REFERENCES `MyWorkouts`.`wk_ticketCategories` (`ticketCategoryid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_tickets_wk_ticketStatus1`
    FOREIGN KEY (`ticketStatusid`)
    REFERENCES `MyWorkouts`.`wk_ticketStatus` (`ticketStatusid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_tickets_wk_ticketPriorities1`
    FOREIGN KEY (`ticketPriorityid`)
    REFERENCES `MyWorkouts`.`wk_ticketPriorities` (`ticketPriorityid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_tickets_wk_clients1`
    FOREIGN KEY (`clientid`)
    REFERENCES `MyWorkouts`.`wk_clients` (`clientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_tickets_wk_employees1`
    FOREIGN KEY (`employeeid`)
    REFERENCES `MyWorkouts`.`wk_employees` (`employeeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_steps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_steps` (
  `stepid` INT NOT NULL AUTO_INCREMENT,
  `ticketid` INT NOT NULL,
  `employeeid` BIGINT NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `started` DATETIME NOT NULL,
  `finished` DATETIME NULL,
  PRIMARY KEY (`stepid`),
  INDEX `fk_wk_steps_wk_tickets1_idx` (`ticketid` ASC) VISIBLE,
  INDEX `fk_wk_steps_wk_employees1_idx` (`employeeid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_steps_wk_tickets1`
    FOREIGN KEY (`ticketid`)
    REFERENCES `MyWorkouts`.`wk_tickets` (`ticketid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_steps_wk_employees1`
    FOREIGN KEY (`employeeid`)
    REFERENCES `MyWorkouts`.`wk_employees` (`employeeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_roles` (
  `roleid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`roleid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_rolesPerEmployee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_rolesPerEmployee` (
  `rolesPerEmployeeid` BIGINT NOT NULL AUTO_INCREMENT,
  `employeeid` BIGINT NOT NULL,
  `roleid` INT NOT NULL,
  `editedby` VARCHAR(30) NOT NULL,
  `editorid` BIGINT NOT NULL,
  `enabled` BIT NOT NULL DEFAULT 1,
  `lastupdate` DATETIME NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  PRIMARY KEY (`rolesPerEmployeeid`),
  INDEX `fk_wk_rolesPerEmployee_wk_employees1_idx` (`employeeid` ASC) VISIBLE,
  INDEX `fk_wk_rolesPerEmployee_wk_roles1_idx` (`roleid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_rolesPerEmployee_wk_employees1`
    FOREIGN KEY (`employeeid`)
    REFERENCES `MyWorkouts`.`wk_employees` (`employeeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_rolesPerEmployee_wk_roles1`
    FOREIGN KEY (`roleid`)
    REFERENCES `MyWorkouts`.`wk_roles` (`roleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_applications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_applications` (
  `applicationid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`applicationid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_modules` (
  `moduleid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `applicationid` INT NOT NULL,
  PRIMARY KEY (`moduleid`),
  INDEX `fk_wk_modules_wk_applications1_idx` (`applicationid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_modules_wk_applications1`
    FOREIGN KEY (`applicationid`)
    REFERENCES `MyWorkouts`.`wk_applications` (`applicationid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_permissions` (
  `permissionid` INT NOT NULL AUTO_INCREMENT,
  `moduleid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `code` VARCHAR(30) NOT NULL,
  `enabled` BIT NOT NULL DEFAULT 1,
  `deleted` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`permissionid`),
  INDEX `fk_wk_permissions_wk_modules1_idx` (`moduleid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_permissions_wk_modules1`
    FOREIGN KEY (`moduleid`)
    REFERENCES `MyWorkouts`.`wk_modules` (`moduleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_permissionsPerRole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_permissionsPerRole` (
  `permissionid` INT NOT NULL,
  `roleid` INT NOT NULL,
  `editedby` VARCHAR(30) NOT NULL,
  `editorid` BIGINT NOT NULL,
  `enabled` BIT NOT NULL DEFAULT 1,
  `lastupdate` DATETIME NOT NULL,
  `checksum` VARBINARY(250) NOT NULL,
  INDEX `fk_wk_permissionsPerRole_wk_permissions1_idx` (`permissionid` ASC) VISIBLE,
  INDEX `fk_wk_permissionsPerRole_wk_roles1_idx` (`roleid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_permissionsPerRole_wk_permissions1`
    FOREIGN KEY (`permissionid`)
    REFERENCES `MyWorkouts`.`wk_permissions` (`permissionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_permissionsPerRole_wk_roles1`
    FOREIGN KEY (`roleid`)
    REFERENCES `MyWorkouts`.`wk_roles` (`roleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_recurrenceTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_recurrenceTypes` (
  `recurrenceTypeid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `datepart` VARCHAR(4) NOT NULL,
  `valuetoadd` SMALLINT NOT NULL,
  PRIMARY KEY (`recurrenceTypeid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_days`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_days` (
  `dayid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`dayid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_workouts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_workouts` (
  `workoutid` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `deleted` BIT NOT NULL DEFAULT 0,
  `preset` BIT NOT NULL,
  `creationDate` DATE NULL,
  PRIMARY KEY (`workoutid`))
ENGINE = InnoDB;


-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_recurrencePerWorkouts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_recurrencePerWorkouts` (
  `recurrencePerWorkoutid` BIGINT NOT NULL AUTO_INCREMENT,
  `setTime` TIME NOT NULL,
  `recurrenceTypeid` INT NOT NULL,  
  `workoutid` BIGINT NOT NULL,
  PRIMARY KEY (`recurrencePerWorkoutid`),
  INDEX `fk_wk_recurrencePerWorkouts_wk_recurrenceTypes1_idx` (`recurrenceTypeid` ASC) VISIBLE,
  INDEX `fk_wk_recurrencePerWorkouts_wk_days1_idx` (`dayid` ASC) VISIBLE,
  INDEX `fk_wk_recurrencePerWorkouts_wk_workouts1_idx` (`workoutid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_recurrencePerWorkouts_wk_recurrenceTypes1`
    FOREIGN KEY (`recurrenceTypeid`)
    REFERENCES `MyWorkouts`.`wk_recurrenceTypes` (`recurrenceTypeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_recurrencePerWorkouts_wk_days1`
  CONSTRAINT `fk_wk_recurrencePerWorkouts_wk_workouts1`
    FOREIGN KEY (`workoutid`)
    REFERENCES `MyWorkouts`.`wk_workouts` (`workoutid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_daysPerRecurrencePerWorkout`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_daysPerRecurrencePerWorkout` (
	`dayid` TINYINT NOT NULL,
    `recurrencePerWorkoutid` BIGINT NOT NULL AUTO_INCREMENT,
    INDEX `fk_wk_daysPerRecurrencePerWorkouts_wk_days1_idx` (`dayid` ASC) VISIBLE,
    INDEX `fk_wk_daysPerRecurrencePerWorkouts_wk_recurrencePerWorkouts1_idx` (`recurrencePerWorkoutid` ASC) VISIBLE,
    CONSTRAINT `fk_wk_daysPerRecurrencePerWorkouts_wk_days1`
	  FOREIGN KEY (`dayid`)
      REFERENCES `MyWorkouts`.`wk_days` (`dayid`)
	  ON DELETE NO ACTION
      ON UPDATE NO ACTION,
    CONSTRAINT `fk_wk_daysPerRecurrencePerWorkouts_wk_recurrencePerWorkouts1`
	  FOREIGN KEY (`recurrencePerWorkoutid`)
      REFERENCES `MyWorkouts`.`wk_recurrencePerWorkouts` (`recurrencePerWorkoutid`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_notifications` (
  `notificationid` BIGINT NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(100) NOT NULL,
  `clientid` BIGINT NOT NULL,
  `iconid` BIGINT NOT NULL,
  `recurrencePerWorkoutid` BIGINT NOT NULL,
  PRIMARY KEY (`notificationid`),
  INDEX `fk_wk_notifications_wk_clients1_idx` (`clientid` ASC) VISIBLE,
  INDEX `fk_wk_notifications_wk_icons1_idx` (`iconid` ASC) VISIBLE,
  INDEX `fk_wk_notifications_wk_recurrencePerWorkouts1_idx` (`recurrencePerWorkoutid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_notifications_wk_clients1`
    FOREIGN KEY (`clientid`)
    REFERENCES `MyWorkouts`.`wk_clients` (`clientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_notifications_wk_icons1`
    FOREIGN KEY (`iconid`)
    REFERENCES `MyWorkouts`.`wk_icons` (`iconid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_notifications_wk_recurrencePerWorkouts1`
    FOREIGN KEY (`recurrencePerWorkoutid`)
    REFERENCES `MyWorkouts`.`wk_recurrencePerWorkouts` (`recurrencePerWorkoutid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_tracking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_tracking` (
  `trackingid` BIGINT NOT NULL AUTO_INCREMENT,
  `clientid` BIGINT NOT NULL,
  `height` DOUBLE NULL,
  `weight` DOUBLE NULL,
  `BMI` DOUBLE NULL,
  `posttime` DATE NULL,
  `additionalNotes` VARCHAR(100) NULL,
  PRIMARY KEY (`trackingid`),
  INDEX `fk_wk_tracking_wk_clients1_idx` (`clientid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_tracking_wk_clients1`
    FOREIGN KEY (`clientid`)
    REFERENCES `MyWorkouts`.`wk_clients` (`clientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_pictures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_pictures` (
  `pictureid` BIGINT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(250) NOT NULL,
  `deleted` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`pictureid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_picturesPerTracking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_picturesPerTracking` (
  `picturePerTrackingid` BIGINT NOT NULL AUTO_INCREMENT,
  `trackingid` BIGINT NOT NULL,
  `pictureid` BIGINT NULL,
  PRIMARY KEY (`picturePerTrackingid`),
  INDEX `fk_wk_picturesPerTracking_wk_tracking1_idx` (`trackingid` ASC) VISIBLE,
  INDEX `fk_wk_picturesPerTracking_wk_pictures1_idx` (`pictureid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_picturesPerTracking_wk_tracking1`
    FOREIGN KEY (`trackingid`)
    REFERENCES `MyWorkouts`.`wk_tracking` (`trackingid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_picturesPerTracking_wk_pictures1`
    FOREIGN KEY (`pictureid`)
    REFERENCES `MyWorkouts`.`wk_pictures` (`pictureid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_categories` (
  `categoryid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`categoryid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_exerciseFocus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_exerciseFocus` (
  `focusid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`focusid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_difficultyLevels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_difficultyLevels` (
  `difficultyid` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`difficultyid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_equipment` (
  `equipmentid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `description` VARCHAR(50) NOT NULL,
  `weight` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`equipmentid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_exercises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_exercises` (
  `exerciseid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `categoryid` TINYINT NOT NULL,
  `focusid` TINYINT NOT NULL,
  `difficultyid` TINYINT NOT NULL,
  `equipmentid` INT NULL,
  `steps` VARCHAR(250) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `recommendedReps` TINYINT NOT NULL,
  `recommendedSets` TINYINT NOT NULL,
  `recommendedDuration` TIME NULL,
  PRIMARY KEY (`exerciseid`),
  INDEX `fk_wk_exercises_wk_categories1_idx` (`categoryid` ASC) VISIBLE,
  INDEX `fk_wk_exercises_wk_exerciseFocus1_idx` (`focusid` ASC) VISIBLE,
  INDEX `fk_wk_exercises_wk_difficultyLevels1_idx` (`difficultyid` ASC) VISIBLE,
  INDEX `fk_wk_exercises_wk_equipment1_idx` (`equipmentid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_exercises_wk_categories1`
    FOREIGN KEY (`categoryid`)
    REFERENCES `MyWorkouts`.`wk_categories` (`categoryid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_exercises_wk_exerciseFocus1`
    FOREIGN KEY (`focusid`)
    REFERENCES `MyWorkouts`.`wk_exerciseFocus` (`focusid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_exercises_wk_difficultyLevels1`
    FOREIGN KEY (`difficultyid`)
    REFERENCES `MyWorkouts`.`wk_difficultyLevels` (`difficultyid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_exercises_wk_equipment1`
    FOREIGN KEY (`equipmentid`)
    REFERENCES `MyWorkouts`.`wk_equipment` (`equipmentid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_picturesPerExercise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_picturesPerExercise` (
  `picturePerExerciseid` BIGINT NOT NULL AUTO_INCREMENT,
  `pictureid` BIGINT NOT NULL,
  `exerciseid` INT NOT NULL,
  PRIMARY KEY (`picturePerExerciseid`),
  INDEX `fk_wk_picturesPerExercise_wk_pictures1_idx` (`pictureid` ASC) VISIBLE,
  INDEX `fk_wk_picturesPerExercise_wk_exercises1_idx` (`exerciseid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_picturesPerExercise_wk_pictures1`
    FOREIGN KEY (`pictureid`)
    REFERENCES `MyWorkouts`.`wk_pictures` (`pictureid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_picturesPerExercise_wk_exercises1`
    FOREIGN KEY (`exerciseid`)
    REFERENCES `MyWorkouts`.`wk_exercises` (`exerciseid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_workoutSessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_workoutSessions` (
  `workoutSessionid` BIGINT NOT NULL AUTO_INCREMENT,
  `workoutid` BIGINT NOT NULL,
  `clientid` BIGINT NOT NULL,
  `started` DATETIME NOT NULL,
  `finished` DATETIME NULL,
  PRIMARY KEY (`workoutSessionid`),
  INDEX `fk_wk_workoutSessions_wk_clients1_idx` (`clientid` ASC) VISIBLE,
  INDEX `fk_wk_workoutSessions_wk_workouts1_idx` (`workoutid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_workoutSessions_wk_clients1`
    FOREIGN KEY (`clientid`)
    REFERENCES `MyWorkouts`.`wk_clients` (`clientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_workoutSessions_wk_workouts1`
    FOREIGN KEY (`workoutid`)
    REFERENCES `MyWorkouts`.`wk_workouts` (`workoutid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_exercisesPerWorkout`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_exercisesPerWorkout` (
  `exercisePerWorkoutid` INT NOT NULL AUTO_INCREMENT,
  `workoutid` BIGINT NOT NULL,
  `exerciseid` INT NOT NULL,
  `reps` TINYINT NOT NULL,
  `sets` TINYINT NOT NULL,
  `timeDuration` TIME NULL,
  PRIMARY KEY (`exercisePerWorkoutid`),
  INDEX `fk_wk_exercisesPerWorkout_wk_workouts1_idx` (`workoutid` ASC) VISIBLE,
  INDEX `fk_wk_exercisesPerWorkout_wk_exercises1_idx` (`exerciseid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_exercisesPerWorkout_wk_workouts1`
    FOREIGN KEY (`workoutid`)
    REFERENCES `MyWorkouts`.`wk_workouts` (`workoutid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_exercisesPerWorkout_wk_exercises1`
    FOREIGN KEY (`exerciseid`)
    REFERENCES `MyWorkouts`.`wk_exercises` (`exerciseid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_exercisesLogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_exercisesLogs` (
  `exerciseLogid` BIGINT NOT NULL AUTO_INCREMENT,
  `timestamp` DATETIME NOT NULL,
  `workoutSessionid` BIGINT NOT NULL,
  `exercisePerWorkoutid` INT NOT NULL,
  `repsLog` TINYINT NOT NULL,
  `setsLog` TINYINT NOT NULL,
  `timeDurationLog` TIME NULL,
  PRIMARY KEY (`exerciseLogid`),
  INDEX `fk_wk_exercisesLogs_wk_workoutSessions1_idx` (`workoutSessionid` ASC) VISIBLE,
  INDEX `fk_wk_exercisesLogs_wk_exercisesPerWorkout1_idx` (`exercisePerWorkoutid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_exercisesLogs_wk_workoutSessions1`
    FOREIGN KEY (`workoutSessionid`)
    REFERENCES `MyWorkouts`.`wk_workoutSessions` (`workoutSessionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_exercisesLogs_wk_exercisesPerWorkout1`
    FOREIGN KEY (`exercisePerWorkoutid`)
    REFERENCES `MyWorkouts`.`wk_exercisesPerWorkout` (`exercisePerWorkoutid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_videos` (
  `videoid` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(250) NOT NULL,
  `deleted` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`videoid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MyWorkouts`.`wk_videosPerExercise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MyWorkouts`.`wk_videosPerExercise` (
  `videoid` INT NOT NULL,
  `exerciseid` INT NOT NULL,
  INDEX `fk_wk_videosPerExercise_wk_videos1_idx` (`videoid` ASC) VISIBLE,
  INDEX `fk_wk_videosPerExercise_wk_exercises1_idx` (`exerciseid` ASC) VISIBLE,
  CONSTRAINT `fk_wk_videosPerExercise_wk_videos1`
    FOREIGN KEY (`videoid`)
    REFERENCES `MyWorkouts`.`wk_videos` (`videoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_wk_videosPerExercise_wk_exercises1`
    FOREIGN KEY (`exerciseid`)
    REFERENCES `MyWorkouts`.`wk_exercises` (`exerciseid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
