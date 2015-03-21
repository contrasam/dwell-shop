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