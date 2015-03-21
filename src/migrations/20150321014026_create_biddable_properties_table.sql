DROP TABLE IF EXISTS `dwell_shop`.`biddable_properties` ;

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