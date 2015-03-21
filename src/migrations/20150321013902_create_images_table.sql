CREATE TABLE IF NOT EXISTS `dwell_shop`.`images` (
  `id` INT NOT NULL,
  `code` VARCHAR(100) NULL,
  `caption` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;