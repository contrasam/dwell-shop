DROP TABLE IF EXISTS `dwell_shop`.`users` ;

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
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;