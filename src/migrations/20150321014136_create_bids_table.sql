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