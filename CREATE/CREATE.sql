-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema gyms
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gyms
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gyms` DEFAULT CHARACTER SET utf8 ;
USE `gyms` ;

-- -----------------------------------------------------
-- Table `gyms`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `country` NVARCHAR(55) NOT NULL,
  `postal_code` VARCHAR(12) NOT NULL,
  `city` NVARCHAR(60) NOT NULL,
  `street` NVARCHAR(100) NOT NULL,
  `house_number` VARCHAR(9) NOT NULL,
  `flat_number` VARCHAR(45) NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`gym`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`gym` (
  `gym_id` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(50) NOT NULL,
  `description` NVARCHAR(500) NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`gym_id`),
  INDEX `fk_gym_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_gym_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `gyms`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`salary_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`salary_status` (
  `salary_status_id` INT NOT NULL AUTO_INCREMENT,
  `country_code` VARCHAR(8) NOT NULL,
  `status` NVARCHAR(30) NOT NULL,
  `salary` INT NOT NULL,
  `currency` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`salary_status_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`staff_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`staff_group` (
  `staff_group_id` INT NOT NULL AUTO_INCREMENT,
  `group_name` NVARCHAR(50) NOT NULL,
  PRIMARY KEY (`staff_group_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`person_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`person_data` (
  `person_data_id` INT NOT NULL AUTO_INCREMENT,
  `surname` NVARCHAR(50) NOT NULL,
  `name` NVARCHAR(50) NOT NULL,
  `e_mail` VARCHAR(100) NOT NULL,
  `gender` NVARCHAR(10) NOT NULL,
  `phone_number` VARCHAR(15) NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`person_data_id`),
  INDEX `fk_person_data_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_person_data_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `gyms`.`address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `gym_id` INT NOT NULL,
  `salary_status_id` INT NOT NULL,
  `staff_group_id` INT NOT NULL,
  `person_data_id` INT NOT NULL,
  PRIMARY KEY (`staff_id`),
  INDEX `fk_staff_gym1_idx` (`gym_id` ASC) VISIBLE,
  INDEX `fk_staff_salary_status1_idx` (`salary_status_id` ASC) VISIBLE,
  INDEX `fk_staff_staff_group1_idx` (`staff_group_id` ASC) VISIBLE,
  INDEX `fk_staff_person_data1_idx` (`person_data_id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_gym1`
    FOREIGN KEY (`gym_id`)
    REFERENCES `gyms`.`gym` (`gym_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_salary_status1`
    FOREIGN KEY (`salary_status_id`)
    REFERENCES `gyms`.`salary_status` (`salary_status_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_staff_group1`
    FOREIGN KEY (`staff_group_id`)
    REFERENCES `gyms`.`staff_group` (`staff_group_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_person_data1`
    FOREIGN KEY (`person_data_id`)
    REFERENCES `gyms`.`person_data` (`person_data_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`equipment` (
  `equipment_id` INT NOT NULL AUTO_INCREMENT,
  `treadmill_number` INT NOT NULL,
  `rowing_machine_number` INT NOT NULL,
  `cross_trainer_number` INT NOT NULL,
  `bike_number` INT NOT NULL,
  `stair_mill_number` INT NOT NULL,
  `leg_machine_number` INT NOT NULL,
  `multi_gym_number` INT NOT NULL,
  `dumbbell_set_number` INT NOT NULL,
  `gym_id` INT NOT NULL,
  PRIMARY KEY (`equipment_id`),
  INDEX `fk_equipment_gym1_idx` (`gym_id` ASC) VISIBLE,
  CONSTRAINT `fk_equipment_gym1`
    FOREIGN KEY (`gym_id`)
    REFERENCES `gyms`.`gym` (`gym_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`trainer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`trainer` (
  `trainer_id` INT NOT NULL AUTO_INCREMENT,
  `salary_status_id` INT NOT NULL,
  `person_data_id` INT NOT NULL,
  PRIMARY KEY (`trainer_id`),
  INDEX `fk_trainer_salary_status1_idx` (`salary_status_id` ASC) VISIBLE,
  INDEX `fk_trainer_person_data1_idx` (`person_data_id` ASC) VISIBLE,
  CONSTRAINT `fk_trainer_salary_status1`
    FOREIGN KEY (`salary_status_id`)
    REFERENCES `gyms`.`salary_status` (`salary_status_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_trainer_person_data1`
    FOREIGN KEY (`person_data_id`)
    REFERENCES `gyms`.`person_data` (`person_data_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`member` (
  `member_id` INT NOT NULL AUTO_INCREMENT,
  `trainer_id` INT NULL,
  `gym_id` INT NULL,
  `person_data_id` INT NOT NULL,
  PRIMARY KEY (`member_id`),
  INDEX `fk_member_gym1_idx` (`gym_id` ASC) VISIBLE,
  INDEX `fk_member_trainer1_idx` (`trainer_id` ASC) VISIBLE,
  INDEX `fk_member_person_data1_idx` (`person_data_id` ASC) VISIBLE,
  CONSTRAINT `fk_member_gym1`
    FOREIGN KEY (`gym_id`)
    REFERENCES `gyms`.`gym` (`gym_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_member_trainer1`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `gyms`.`trainer` (`trainer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_member_person_data1`
    FOREIGN KEY (`person_data_id`)
    REFERENCES `gyms`.`person_data` (`person_data_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`opening_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`opening_info` (
  `opening_info_id` INT NOT NULL AUTO_INCREMENT,
  `day` VARCHAR(15) NOT NULL,
  `open_hour` TIME NOT NULL,
  `close_hour` TIME NOT NULL,
  PRIMARY KEY (`opening_info_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`fees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`fees` (
  `fees_id` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `type` VARCHAR(30) NOT NULL,
  `amount` VARCHAR(15) NOT NULL,
  `currency` VARCHAR(5) NOT NULL,
  `is_active` BIT(1) NOT NULL,
  `member_id` INT NOT NULL,
  PRIMARY KEY (`fees_id`, `member_id`),
  INDEX `fk_fees_member1_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_fees_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `gyms`.`member` (`member_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`exercise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`exercise` (
  `exercise_id` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(50) NOT NULL,
  `description` NVARCHAR(500) NOT NULL,
  `calories` VARCHAR(15) NOT NULL,
  `sets` VARCHAR(10) NOT NULL,
  `reps` VARCHAR(10) NOT NULL,
  `break_time` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`exercise_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`schedule` (
  `gym_id` INT NOT NULL,
  `opening_info_id` INT NOT NULL,
  PRIMARY KEY (`gym_id`, `opening_info_id`),
  INDEX `fk_schedule_gym1_idx` (`gym_id` ASC) VISIBLE,
  INDEX `fk_schedule_opening_info1_idx` (`opening_info_id` ASC) VISIBLE,
  CONSTRAINT `fk_schedule_gym1`
    FOREIGN KEY (`gym_id`)
    REFERENCES `gyms`.`gym` (`gym_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_schedule_opening_info1`
    FOREIGN KEY (`opening_info_id`)
    REFERENCES `gyms`.`opening_info` (`opening_info_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`training_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`training_group` (
  `training_group_id` INT NOT NULL AUTO_INCREMENT,
  `group_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`training_group_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`exercise_set`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`exercise_set` (
  `member_id` INT NOT NULL,
  `exercise_id` INT NOT NULL,
  `training_group_id` INT NOT NULL,
  PRIMARY KEY (`member_id`, `exercise_id`, `training_group_id`),
  INDEX `fk_exercise_set_member1_idx` (`member_id` ASC) VISIBLE,
  INDEX `fk_exercise_set_exercise1_idx` (`exercise_id` ASC) VISIBLE,
  INDEX `fk_exercise_set_training_group1_idx` (`training_group_id` ASC) VISIBLE,
  CONSTRAINT `fk_exercise_set_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `gyms`.`member` (`member_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_exercise_set_exercise1`
    FOREIGN KEY (`exercise_id`)
    REFERENCES `gyms`.`exercise` (`exercise_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_exercise_set_training_group1`
    FOREIGN KEY (`training_group_id`)
    REFERENCES `gyms`.`training_group` (`training_group_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`diet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`diet` (
  `diet_id` INT NOT NULL AUTO_INCREMENT,
  `diet_description` NVARCHAR(5000) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `trainer_id` INT NULL,
  `member_id` INT NULL,
  PRIMARY KEY (`diet_id`),
  INDEX `fk_diet_trainer1_idx` (`trainer_id` ASC) VISIBLE,
  INDEX `fk_diet_member1_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_diet_trainer1`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `gyms`.`trainer` (`trainer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_diet_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `gyms`.`member` (`member_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`trainer_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`trainer_history` (
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `trainer_id` INT NOT NULL,
  `member_id` INT NOT NULL,
  INDEX `fk_trainer_history_trainer1_idx` (`trainer_id` ASC) VISIBLE,
  INDEX `fk_trainer_history_member1_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_trainer_history_trainer1`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `gyms`.`trainer` (`trainer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_trainer_history_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `gyms`.`member` (`member_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gyms`.`trainer_has_gym`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gyms`.`trainer_has_gym` (
  `trainer_id` INT NOT NULL,
  `gym_id` INT NOT NULL,
  PRIMARY KEY (`trainer_id`, `gym_id`),
  INDEX `fk_trainer_has_gym_gym1_idx` (`gym_id` ASC) VISIBLE,
  INDEX `fk_trainer_has_gym_trainer1_idx` (`trainer_id` ASC) VISIBLE,
  CONSTRAINT `fk_trainer_has_gym_trainer1`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `gyms`.`trainer` (`trainer_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_trainer_has_gym_gym1`
    FOREIGN KEY (`gym_id`)
    REFERENCES `gyms`.`gym` (`gym_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
