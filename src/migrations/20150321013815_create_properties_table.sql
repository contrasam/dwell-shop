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