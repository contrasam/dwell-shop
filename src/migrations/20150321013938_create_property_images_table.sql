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