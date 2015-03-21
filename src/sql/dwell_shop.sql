SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `dwell_shop` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `dwell_shop` ;

-- -----------------------------------------------------
-- Table `dwell_shop`.`locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwell_shop`.`locations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street_number` INT NULL,
  `street_name` VARCHAR(200) NULL,
  `suite_number` VARCHAR(45) NULL,
  `city` VARCHAR(100) NULL,
  `state` VARCHAR(100) NULL,
  `zip_code` VARCHAR(10) NULL,
  `country` VARCHAR(100) NULL,
  `latitude` DECIMAL(9,6) NULL,
  `longitude` DECIMAL(9,6) NULL,
  PRIMARY KEY (`id`),
  FULLTEXT INDEX `CITY` (`city` ASC),
  FULLTEXT INDEX `STATE` (`state` ASC),
  FULLTEXT INDEX `STREET_NAME` (`street_name` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `dwell_shop`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwell_shop`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `location_id` INT NULL,
  `first_name` VARCHAR(100) NULL,
  `last_name` VARCHAR(100) NULL,
  `email_address` VARCHAR(200) NULL,
  `profession` VARCHAR(100) NULL,
  `company` VARCHAR(200) NULL,
  `password` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_user_address_idx` (`location_id` ASC),
  CONSTRAINT `FK_user_location`
    FOREIGN KEY (`location_id`)
    REFERENCES `dwell_shop`.`locations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dwell_shop`.`properties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwell_shop`.`properties` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `location_id` INT NULL,
  `owner_id` INT NULL,
  `type` VARCHAR(100) NULL,
  `year` YEAR NULL,
  `sale_type` VARCHAR(100) NULL,
  `sale_status` VARCHAR(45) NULL,
  `sub_type` VARCHAR(100) NULL,
  `number_of_rooms` INT NULL,
  `created` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_property_location_idx` (`location_id` ASC),
  INDEX `FK_property_owner_idx` (`owner_id` ASC),
  CONSTRAINT `FK_property_location`
    FOREIGN KEY (`location_id`)
    REFERENCES `dwell_shop`.`locations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_property_owner`
    FOREIGN KEY (`owner_id`)
    REFERENCES `dwell_shop`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dwell_shop`.`images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwell_shop`.`images` (
  `id` INT NOT NULL,
  `code` VARCHAR(100) NULL,
  `caption` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dwell_shop`.`property_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwell_shop`.`property_images` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `property_id` INT NULL,
  `image_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_property_image_idx` (`property_id` ASC),
  INDEX `FK_image_property_idx` (`image_id` ASC),
  CONSTRAINT `FK_property_image`
    FOREIGN KEY (`property_id`)
    REFERENCES `dwell_shop`.`properties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_image_property`
    FOREIGN KEY (`image_id`)
    REFERENCES `dwell_shop`.`images` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dwell_shop`.`biddable_properties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwell_shop`.`biddable_properties` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `property_id` INT NULL,
  `number_of_bids` INT NULL,
  `minimum_bidding_price` DECIMAL(6,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_biddable_property_idx` (`property_id` ASC),
  CONSTRAINT `FK_biddable_property`
    FOREIGN KEY (`property_id`)
    REFERENCES `dwell_shop`.`properties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dwell_shop`.`buyable_properties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwell_shop`.`buyable_properties` (
  `id` INT NOT NULL,
  `property_id` INT NULL,
  `price` DECIMAL(6,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_buyable_property_idx` (`property_id` ASC),
  CONSTRAINT `FK_buyable_property`
    FOREIGN KEY (`property_id`)
    REFERENCES `dwell_shop`.`properties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dwell_shop`.`bids`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dwell_shop`.`bids` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bidder_id` INT NULL,
  `biddable_property_id` INT NULL,
  `status` VARCHAR(45) NULL,
  `price` DECIMAL(6,2) NULL,
  `created` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_bid_user_idx` (`bidder_id` ASC),
  INDEX `FK_bid_property_idx` (`biddable_property_id` ASC),
  CONSTRAINT `FK_bid_user`
    FOREIGN KEY (`bidder_id`)
    REFERENCES `dwell_shop`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_bid_property`
    FOREIGN KEY (`biddable_property_id`)
    REFERENCES `dwell_shop`.`biddable_properties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
