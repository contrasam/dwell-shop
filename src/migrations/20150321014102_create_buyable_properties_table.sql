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