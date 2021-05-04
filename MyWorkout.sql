-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`wk_genders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_genders` (
  `gendersid` TINYINT NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`gendersid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_users` (
  `userid` BIGINT NOT NULL,
  `gendersid` TINYINT NOT NULL,
  `email` VARCHAR(250) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `password` VARBINARY(250) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `birthdate` DATE NOT NULL,
  `registeredAt` DATETIME NOT NULL,
  PRIMARY KEY (`userid`),
  INDEX `fk_mw_users_mw_genders1_idx` (`gendersid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_users_mw_genders1`
    FOREIGN KEY (`gendersid`)
    REFERENCES `mydb`.`wk_genders` (`gendersid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_icons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_icons` (
  `iconid` BIGINT NOT NULL,
  `url` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`iconid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_plans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_plans` (
  `planid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(250) NOT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `starttime` DATETIME NOT NULL,
  `endtime` DATETIME NULL,
  `enabled` BIT NOT NULL,
  `deleted` BIT NOT NULL,
  `iconid` BIGINT NOT NULL,
  PRIMARY KEY (`planid`),
  INDEX `fk_mw_plans_mw_icons1_idx` (`iconid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_plans_mw_icons1`
    FOREIGN KEY (`iconid`)
    REFERENCES `mydb`.`wk_icons` (`iconid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_clients` (
  `clientid` BIGINT NOT NULL,
  `userid` BIGINT NOT NULL,
  `planid` INT NOT NULL,
  PRIMARY KEY (`clientid`),
  INDEX `fk_mw_clients_mw_users1_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_mw_clients_mw_plans1_idx` (`planid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_clients_mw_users1`
    FOREIGN KEY (`userid`)
    REFERENCES `mydb`.`wk_users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_clients_mw_plans1`
    FOREIGN KEY (`planid`)
    REFERENCES `mydb`.`wk_plans` (`planid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_tracking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_tracking` (
  `trackingid` BIGINT NOT NULL,
  `clientid` BIGINT NOT NULL,
  `height` DOUBLE NULL,
  `weight` DOUBLE NULL,
  `BMI` DOUBLE NULL,
  `posttime` DATE NULL,
  `additionalNotes` VARCHAR(100) NULL,
  PRIMARY KEY (`trackingid`),
  INDEX `fk_mw_tracking_mw_clients1_idx` (`clientid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_tracking_mw_clients1`
    FOREIGN KEY (`clientid`)
    REFERENCES `mydb`.`wk_clients` (`clientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_workouts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_workouts` (
  `workoutid` BIGINT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `deleted` BIT NOT NULL DEFAULT 0,
  `preset` BIT NOT NULL DEFAULT 0,
  `creationDate` DATE NULL,
  PRIMARY KEY (`workoutid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_category` (
  `categoryid` TINYINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`categoryid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_difficultyLevels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_difficultyLevels` (
  `difficultylid` TINYINT NOT NULL,
  `name` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`difficultylid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_equipment` (
  `equipmentid` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `description` VARCHAR(50) NOT NULL,
  `weight` DECIMAL(5,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`equipmentid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_exerciseFocus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_exerciseFocus` (
  `focusid` TINYINT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`focusid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_exercises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_exercises` (
  `exerciseid` INT NOT NULL,
  `categoryid` TINYINT NOT NULL,
  `focusid` TINYINT NOT NULL,
  `difficultyid` TINYINT NOT NULL,
  `equipmentid` INT NULL,
  `name` VARCHAR(45) NOT NULL,
  `steps` VARCHAR(250) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `recommendedReps` TINYINT NOT NULL,
  `recommendedSets` TINYINT NOT NULL,
  `recommendedDuration` TIME NULL,
  PRIMARY KEY (`exerciseid`),
  INDEX `fk_mw_exercises_category1_idx` (`categoryid` ASC) VISIBLE,
  INDEX `fk_mw_exercises_mw_levels1_idx` (`difficultyid` ASC) VISIBLE,
  INDEX `fk_mw_exercises_mw_equipment1_idx` (`equipmentid` ASC) VISIBLE,
  INDEX `fk_mw_exercises_mw_exerciseFocus1_idx` (`focusid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_exercises_category1`
    FOREIGN KEY (`categoryid`)
    REFERENCES `mydb`.`wk_category` (`categoryid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_exercises_mw_levels1`
    FOREIGN KEY (`difficultyid`)
    REFERENCES `mydb`.`wk_difficultyLevels` (`difficultylid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_exercises_mw_equipment1`
    FOREIGN KEY (`equipmentid`)
    REFERENCES `mydb`.`wk_equipment` (`equipmentid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_exercises_mw_exerciseFocus1`
    FOREIGN KEY (`focusid`)
    REFERENCES `mydb`.`wk_exerciseFocus` (`focusid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_days`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_days` (
  `dayid` TINYINT NOT NULL,
  `name` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`dayid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_recurrenceTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_recurrenceTypes` (
  `recurrenceTypeid` BIGINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `datepart` DATE NOT NULL,
  `valuetoadd` SMALLINT NOT NULL,
  PRIMARY KEY (`recurrenceTypeid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_recurrencePerWorkouts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_recurrencePerWorkouts` (
  `recurrencePerWorkoutid` BIGINT NOT NULL,
  `workoutid` BIGINT NOT NULL,
  `setTime` TIME NOT NULL,
  `dayid` TINYINT NOT NULL,
  `recurrenceTypeid` BIGINT NOT NULL,
  PRIMARY KEY (`recurrencePerWorkoutid`),
  INDEX `fk_mw_recurrencePerWorkouts_mw_workouts1_idx` (`workoutid` ASC) VISIBLE,
  INDEX `fk_mw_recurrencePerWorkouts_days1_idx` (`dayid` ASC) VISIBLE,
  INDEX `fk_mw_recurrencePerWorkouts_mw_recurrenceTypes1_idx` (`recurrenceTypeid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_recurrencePerWorkouts_mw_workouts1`
    FOREIGN KEY (`workoutid`)
    REFERENCES `mydb`.`wk_workouts` (`workoutid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_recurrencePerWorkouts_days1`
    FOREIGN KEY (`dayid`)
    REFERENCES `mydb`.`wk_days` (`dayid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_recurrencePerWorkouts_mw_recurrenceTypes1`
    FOREIGN KEY (`recurrenceTypeid`)
    REFERENCES `mydb`.`wk_recurrenceTypes` (`recurrenceTypeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_notifications` (
  `notificationid` BIGINT NOT NULL,
  `clientid` BIGINT NOT NULL,
  `recurrencePerWorkoutid` BIGINT NOT NULL,
  `message` VARCHAR(100) NOT NULL,
  `iconid` BIGINT NOT NULL,
  PRIMARY KEY (`notificationid`),
  INDEX `fk_mw_notifications_mw_icons1_idx` (`iconid` ASC) VISIBLE,
  INDEX `fk_mw_notifications_mw_clients1_idx` (`clientid` ASC) VISIBLE,
  INDEX `fk_mw_notifications_mw_recurrencePerWorkouts1_idx` (`recurrencePerWorkoutid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_notifications_mw_icons1`
    FOREIGN KEY (`iconid`)
    REFERENCES `mydb`.`wk_icons` (`iconid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_notifications_mw_clients1`
    FOREIGN KEY (`clientid`)
    REFERENCES `mydb`.`wk_clients` (`clientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_notifications_mw_recurrencePerWorkouts1`
    FOREIGN KEY (`recurrencePerWorkoutid`)
    REFERENCES `mydb`.`wk_recurrencePerWorkouts` (`recurrencePerWorkoutid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_exercisesPerWorkout`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_exercisesPerWorkout` (
  `exercisePerWorkoutid` INT NOT NULL,
  `workoutid` BIGINT NOT NULL,
  `exerciseid` INT NOT NULL,
  `reps` TINYINT NOT NULL,
  `sets` TINYINT NOT NULL,
  `timeDuration` TIME NULL,
  PRIMARY KEY (`exercisePerWorkoutid`),
  INDEX `fk_mw_exercisesPerWorkout_mw_workouts1_idx` (`workoutid` ASC) VISIBLE,
  INDEX `fk_mw_exercisesPerWorkout_mw_exercises1_idx` (`exerciseid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_exercisesPerWorkout_mw_workouts1`
    FOREIGN KEY (`workoutid`)
    REFERENCES `mydb`.`wk_workouts` (`workoutid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_exercisesPerWorkout_mw_exercises1`
    FOREIGN KEY (`exerciseid`)
    REFERENCES `mydb`.`wk_exercises` (`exerciseid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_pictures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_pictures` (
  `pictureid` BIGINT NOT NULL,
  `url` VARCHAR(250) NOT NULL,
  `deleted` BIT NOT NULL,
  PRIMARY KEY (`pictureid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_picturesPerTracking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_picturesPerTracking` (
  `picturePerTrackingid` BIGINT NOT NULL,
  `pictureid` BIGINT NULL,
  `trackingid` BIGINT NOT NULL,
  PRIMARY KEY (`picturePerTrackingid`),
  INDEX `fk_mw_picturesPerTracking_mw_pictures1_idx` (`pictureid` ASC) VISIBLE,
  INDEX `fk_mw_picturesPerTracking_mw_tracking1_idx` (`trackingid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_picturesPerTracking_mw_pictures1`
    FOREIGN KEY (`pictureid`)
    REFERENCES `mydb`.`wk_pictures` (`pictureid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_picturesPerTracking_mw_tracking1`
    FOREIGN KEY (`trackingid`)
    REFERENCES `mydb`.`wk_tracking` (`trackingid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_picturesPerExercise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_picturesPerExercise` (
  `picturePerExerciseid` BIGINT NOT NULL,
  `pictureid` BIGINT NOT NULL,
  `exerciseid` INT NOT NULL,
  PRIMARY KEY (`picturePerExerciseid`),
  INDEX `fk_mw_picturesPerExercise_mw_pictures1_idx` (`pictureid` ASC) VISIBLE,
  INDEX `fk_mw_picturesPerExercise_mw_exercises1_idx` (`exerciseid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_picturesPerExercise_mw_pictures1`
    FOREIGN KEY (`pictureid`)
    REFERENCES `mydb`.`wk_pictures` (`pictureid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_picturesPerExercise_mw_exercises1`
    FOREIGN KEY (`exerciseid`)
    REFERENCES `mydb`.`wk_exercises` (`exerciseid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_videos` (
  `videoid` INT NOT NULL,
  `url` VARCHAR(250) NOT NULL,
  `deleted` BIT(1) NOT NULL,
  PRIMARY KEY (`videoid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_videosPerExercise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_videosPerExercise` (
  `videoid` INT NOT NULL,
  `exerciseid` INT NOT NULL,
  INDEX `fk_mw_videos_has_mw_exercises_mw_exercises1_idx` (`exerciseid` ASC) VISIBLE,
  INDEX `fk_mw_videos_has_mw_exercises_mw_videos1_idx` (`videoid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_videos_has_mw_exercises_mw_videos1`
    FOREIGN KEY (`videoid`)
    REFERENCES `mydb`.`wk_videos` (`videoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_videos_has_mw_exercises_mw_exercises1`
    FOREIGN KEY (`exerciseid`)
    REFERENCES `mydb`.`wk_exercises` (`exerciseid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_picturesPerWorkout`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_picturesPerWorkout` (
  `workoutid` BIGINT NOT NULL,
  `pictureid` BIGINT NOT NULL,
  INDEX `fk_mw_workouts_has_mw_pictures_mw_pictures1_idx` (`pictureid` ASC) VISIBLE,
  INDEX `fk_mw_workouts_has_mw_pictures_mw_workouts1_idx` (`workoutid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_workouts_has_mw_pictures_mw_workouts1`
    FOREIGN KEY (`workoutid`)
    REFERENCES `mydb`.`wk_workouts` (`workoutid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_workouts_has_mw_pictures_mw_pictures1`
    FOREIGN KEY (`pictureid`)
    REFERENCES `mydb`.`wk_pictures` (`pictureid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_workoutSessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_workoutSessions` (
  `sessionid` BIGINT NOT NULL,
  `clientid` BIGINT NOT NULL,
  `workoutid` BIGINT NOT NULL,
  `started` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finished` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_mw_clients_has_mw_workouts_mw_workouts1_idx` (`workoutid` ASC) VISIBLE,
  INDEX `fk_mw_clients_has_mw_workouts_mw_clients1_idx` (`clientid` ASC) VISIBLE,
  PRIMARY KEY (`sessionid`),
  CONSTRAINT `fk_mw_clients_has_mw_workouts_mw_clients1`
    FOREIGN KEY (`clientid`)
    REFERENCES `mydb`.`wk_clients` (`clientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_clients_has_mw_workouts_mw_workouts1`
    FOREIGN KEY (`workoutid`)
    REFERENCES `mydb`.`wk_workouts` (`workoutid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_exercisesLogs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_exercisesLogs` (
  `exerciseLogid` BIGINT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `sessionid` BIGINT NOT NULL,
  `exercisePerWorkoutid` INT NOT NULL,
  `repsLog` TINYINT NOT NULL,
  `setsLog` TINYINT NOT NULL,
  `timeDurationLog` TIME NULL,
  PRIMARY KEY (`exerciseLogid`),
  INDEX `fk_mw_exercisesLogs_mw_workoutSessions1_idx` (`sessionid` ASC) VISIBLE,
  INDEX `fk_mw_exercisesLogs_mw_exercisesPerWorkout1_idx` (`exercisePerWorkoutid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_exercisesLogs_mw_workoutSessions1`
    FOREIGN KEY (`sessionid`)
    REFERENCES `mydb`.`wk_workoutSessions` (`sessionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_exercisesLogs_mw_exercisesPerWorkout1`
    FOREIGN KEY (`exercisePerWorkoutid`)
    REFERENCES `mydb`.`wk_exercisesPerWorkout` (`exercisePerWorkoutid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_ticketCategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_ticketCategories` (
  `ticketCategoryid` TINYINT NOT NULL,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ticketCategoryid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_ticketPriorities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_ticketPriorities` (
  `ticketPriorityid` TINYINT NOT NULL,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ticketPriorityid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_departments` (
  `departmentid` TINYINT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`departmentid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_employee` (
  `employeeid` BIGINT NOT NULL,
  `userid` BIGINT NOT NULL,
  `departmentid` TINYINT NOT NULL,
  PRIMARY KEY (`employeeid`),
  INDEX `fk_mw_employee_mw_departments1_idx` (`departmentid` ASC) VISIBLE,
  INDEX `fk_mw_employee_mw_users2_idx` (`userid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_employee_mw_departments1`
    FOREIGN KEY (`departmentid`)
    REFERENCES `mydb`.`wk_departments` (`departmentid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_employee_mw_users2`
    FOREIGN KEY (`userid`)
    REFERENCES `mydb`.`wk_users` (`userid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_ticketStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_ticketStatus` (
  `ticketStateid` TINYINT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ticketStateid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_tickets` (
  `ticketsid` INT NOT NULL,
  `employeeid` BIGINT NOT NULL,
  `stateid` TINYINT NOT NULL,
  `categoryid` TINYINT NOT NULL,
  `priorityid` TINYINT NOT NULL,
  `technicianid` BIGINT NOT NULL,
  `clientid` BIGINT NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ticketsid`),
  INDEX `fk_mw_tickets_mw_ticketCategories1_idx` (`categoryid` ASC) VISIBLE,
  INDEX `fk_mw_tickets_mw_ticketPriorities1_idx` (`priorityid` ASC) VISIBLE,
  INDEX `fk_mw_tickets_mw_employee1_idx` (`employeeid` ASC) VISIBLE,
  INDEX `fk_mw_tickets_mw_ticketStatus1_idx` (`stateid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_tickets_mw_ticketCategories1`
    FOREIGN KEY (`categoryid`)
    REFERENCES `mydb`.`wk_ticketCategories` (`ticketCategoryid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_tickets_mw_ticketPriorities1`
    FOREIGN KEY (`priorityid`)
    REFERENCES `mydb`.`wk_ticketPriorities` (`ticketPriorityid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_tickets_mw_employee1`
    FOREIGN KEY (`employeeid`)
    REFERENCES `mydb`.`wk_employee` (`employeeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_tickets_mw_ticketStatus1`
    FOREIGN KEY (`stateid`)
    REFERENCES `mydb`.`wk_ticketStatus` (`ticketStateid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_applications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_applications` (
  `applicationsid` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`applicationsid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_modules` (
  `moduleid` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  `applicationsid` INT NOT NULL,
  PRIMARY KEY (`moduleid`),
  INDEX `fk_mw_modules_mw_applications_idx` (`applicationsid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_modules_mw_applications`
    FOREIGN KEY (`applicationsid`)
    REFERENCES `mydb`.`wk_applications` (`applicationsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_permissions` (
  `permissionid` INT NOT NULL,
  `moduleid` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `code` VARCHAR(30) NOT NULL,
  `enabled` BIT NOT NULL,
  `deleted` BIT NOT NULL,
  PRIMARY KEY (`permissionid`),
  INDEX `fk_mw_permissions_mw_modules2_idx` (`moduleid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_permissions_mw_modules2`
    FOREIGN KEY (`moduleid`)
    REFERENCES `mydb`.`wk_modules` (`moduleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_roles` (
  `roleid` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`roleid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_rolesPerEmployee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_rolesPerEmployee` (
  `employeeid` BIGINT NOT NULL,
  `roleid` INT NOT NULL,
  `editedby` VARCHAR(30) NOT NULL,
  `editorid` BIGINT NOT NULL,
  `enabled` BIT(1) NOT NULL,
  `lastupdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `checksum` VARBINARY(250) NOT NULL,
  INDEX `fk_mw_employee_has_mw_roles_mw_roles1_idx` (`roleid` ASC) VISIBLE,
  INDEX `fk_mw_employee_has_mw_roles_mw_employee1_idx` (`employeeid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_employee_has_mw_roles_mw_employee1`
    FOREIGN KEY (`employeeid`)
    REFERENCES `mydb`.`wk_employee` (`employeeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_employee_has_mw_roles_mw_roles1`
    FOREIGN KEY (`roleid`)
    REFERENCES `mydb`.`wk_roles` (`roleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_permissonsPerRole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_permissonsPerRole` (
  `permissionid` INT NOT NULL,
  `roleid` INT NOT NULL,
  `editedby` VARCHAR(30) NOT NULL,
  `editorid` BIGINT NOT NULL,
  `enabled` BIT(1) NOT NULL,
  `lastupdated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `checksum` VARBINARY(250) NOT NULL,
  INDEX `fk_mw_permissions_has_mw_roles_mw_roles1_idx` (`roleid` ASC) VISIBLE,
  INDEX `fk_mw_permissions_has_mw_roles_mw_permissions1_idx` (`permissionid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_permissions_has_mw_roles_mw_permissions1`
    FOREIGN KEY (`permissionid`)
    REFERENCES `mydb`.`wk_permissions` (`permissionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_permissions_has_mw_roles_mw_roles1`
    FOREIGN KEY (`roleid`)
    REFERENCES `mydb`.`wk_roles` (`roleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_chatStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_chatStatus` (
  `stateid` TINYINT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`stateid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_chatSessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_chatSessions` (
  `sessionid` INT NOT NULL,
  `technicianid` BIGINT NOT NULL,
  `clientid` BIGINT NOT NULL,
  `employeeid` BIGINT NOT NULL,
  `stateid` TINYINT NOT NULL,
  `started` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` BIT(1) NOT NULL,
  PRIMARY KEY (`sessionid`),
  INDEX `fk_mw_chatSessions_mw_chatStatus1_idx` (`stateid` ASC) VISIBLE,
  INDEX `fk_mw_chatSessions_mw_employee1_idx` (`employeeid` ASC) VISIBLE,
  INDEX `fk_mw_chatSessions_mw_clients1_idx` (`clientid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_chatSessions_mw_chatStatus1`
    FOREIGN KEY (`stateid`)
    REFERENCES `mydb`.`wk_chatStatus` (`stateid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_chatSessions_mw_employee1`
    FOREIGN KEY (`employeeid`)
    REFERENCES `mydb`.`wk_employee` (`employeeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_chatSessions_mw_clients1`
    FOREIGN KEY (`clientid`)
    REFERENCES `mydb`.`wk_clients` (`clientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_messages` (
  `messageid` BIGINT NOT NULL,
  `sessionid` INT NOT NULL,
  `senderid` BIGINT NOT NULL,
  `content` NVARCHAR(250) NOT NULL,
  `posttime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`messageid`),
  INDEX `fk_mw_messages_mw_chatSessions2_idx` (`sessionid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_messages_mw_chatSessions2`
    FOREIGN KEY (`sessionid`)
    REFERENCES `mydb`.`wk_chatSessions` (`sessionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_steps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_steps` (
  `stepid` INT NOT NULL,
  `employeeid` BIGINT NOT NULL,
  `ticketid` INT NOT NULL,
  `technicianid` INT NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `started` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finished` TIMESTAMP NULL,
  INDEX `fk_mw_ticketStatus_has_mw_tickets_mw_tickets1_idx` (`ticketid` ASC) VISIBLE,
  PRIMARY KEY (`stepid`),
  INDEX `fk_mw_steps_mw_employee1_idx` (`employeeid` ASC) VISIBLE,
  CONSTRAINT `fk_mw_ticketStatus_has_mw_tickets_mw_tickets1`
    FOREIGN KEY (`ticketid`)
    REFERENCES `mydb`.`wk_tickets` (`ticketsid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_steps_mw_employee1`
    FOREIGN KEY (`employeeid`)
    REFERENCES `mydb`.`wk_employee` (`employeeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_merchants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_merchants` (
  `merchantid` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `enabled` BIT NOT NULL,
  `iconUrl` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`merchantid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_paymentStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_paymentStatus` (
  `paymentStatusid` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`paymentStatusid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`wk_paymentAttemps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`wk_paymentAttemps` (
  `idPaymentAttemps` BIGINT NOT NULL,
  `clientid` BIGINT NOT NULL,
  `postTime` DATETIME NOT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `currentSymbol` NVARCHAR(3) NOT NULL,
  `errorNumber` BIGINT NULL,
  `merchantTransNumber` BIGINT NOT NULL,
  `description` NVARCHAR(200) NOT NULL,
  `paymentTimeStamp` DATETIME NOT NULL,
  `computerName` VARCHAR(100) NOT NULL,
  `userName` VARCHAR(100) NOT NULL,
  `ipAdress` VARBINARY(16) NOT NULL,
  `checkSum` INT NOT NULL,
  `merchantid` INT NOT NULL,
  `paymentStatusid` INT NOT NULL,
  PRIMARY KEY (`idPaymentAttemps`),
  INDEX `fk_PaymentAttemps_Merchants_idx` (`merchantid` ASC) VISIBLE,
  INDEX `fk_PaymentAttemps_PaymentStatus1_idx` (`paymentStatusid` ASC) VISIBLE,
  INDEX `fk_mw_paymentAttemps_mw_clients1_idx` (`clientid` ASC) VISIBLE,
  CONSTRAINT `fk_PaymentAttemps_Merchants`
    FOREIGN KEY (`merchantid`)
    REFERENCES `mydb`.`wk_merchants` (`merchantid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PaymentAttemps_PaymentStatus1`
    FOREIGN KEY (`paymentStatusid`)
    REFERENCES `mydb`.`wk_paymentStatus` (`paymentStatusid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mw_paymentAttemps_mw_clients1`
    FOREIGN KEY (`clientid`)
    REFERENCES `mydb`.`wk_clients` (`clientid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
