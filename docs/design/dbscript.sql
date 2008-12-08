SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `public` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `public`;

-- -----------------------------------------------------
-- Table `public`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `public`.`user` (
  `userId` INT NOT NULL AUTO_INCREMENT ,
  `gatorLinkId` VARCHAR(45) NOT NULL ,
  `ufId` VARCHAR(8) NOT NULL ,
  `displayId` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`userId`) );

CREATE UNIQUE INDEX `gatorlinkId` ON `public`.`user` (`gatorLinkId` ASC) ;

CREATE UNIQUE INDEX `ufId` ON `public`.`user` (`ufId` ASC) ;


-- -----------------------------------------------------
-- Table `public`.`abkPerson`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `public`.`abkPerson` (
  `contactId` INT NOT NULL AUTO_INCREMENT ,
  `userId` INT NOT NULL ,
  `name` VARCHAR(45) NOT NULL ,
  `company` VARCHAR(45) NULL ,
  `position` VARCHAR(45) NULL ,
  `phoneHome` VARCHAR(20) NULL ,
  `phoneWork` VARCHAR(20) NULL ,
  `phoneCell` VARCHAR(20) NULL ,
  `address` VARCHAR(200) NULL ,
  `notes` TEXT NULL ,
  PRIMARY KEY (`contactId`) ,
  CONSTRAINT `personuid`
    FOREIGN KEY (`userId` )
    REFERENCES `public`.`user` (`userId` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE INDEX `personuid` ON `public`.`abkPerson` (`userId` ASC) ;


-- -----------------------------------------------------
-- Table `public`.`abkEmail`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `public`.`abkEmail` (
  `contactId` INT NOT NULL ,
  `userId` INT NOT NULL ,
  `email` VARCHAR(45) NOT NULL ,
  CONSTRAINT `emailcid`
    FOREIGN KEY (`contactId` )
    REFERENCES `public`.`abkPerson` (`contactId` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `emailuid`
    FOREIGN KEY (`userId` )
    REFERENCES `public`.`user` (`userId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `emailcid` ON `public`.`abkEmail` (`contactId` ASC) ;

CREATE INDEX `emailuid` ON `public`.`abkEmail` (`userId` ASC) ;


-- -----------------------------------------------------
-- Table `public`.`abkML`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `public`.`abkML` (
  `groupId` INT NOT NULL AUTO_INCREMENT ,
  `userId` INT NOT NULL ,
  `groupName` VARCHAR(30) NULL ,
  PRIMARY KEY (`groupId`) ,
  CONSTRAINT `mluid`
    FOREIGN KEY (`userId` )
    REFERENCES `public`.`user` (`userId` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE INDEX `mluid` ON `public`.`abkML` (`userId` ASC) ;


-- -----------------------------------------------------
-- Table `public`.`abkMLMember`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `public`.`abkMLMember` (
  `contactId` INT NOT NULL ,
  `groupId` INT NOT NULL ,
  CONSTRAINT `mlmembergid`
    FOREIGN KEY (`groupId` )
    REFERENCES `public`.`abkML` (`groupId` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `mlmembercid`
    FOREIGN KEY (`contactId` )
    REFERENCES `public`.`abkPerson` (`contactId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `mlmembergid` ON `public`.`abkMLMember` (`groupId` ASC) ;

CREATE INDEX `mlmembercid` ON `public`.`abkMLMember` (`contactId` ASC) ;


-- -----------------------------------------------------
-- Table `public`.`preferences`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `public`.`preferences` (
  `userId` INT NOT NULL ,
  `key` TEXT NOT NULL ,
  `entry` TEXT NOT NULL ,
  CONSTRAINT `prefsuid`
    FOREIGN KEY (`userId` )
    REFERENCES `public`.`user` (`userId` )
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE INDEX `prefsuid` ON `public`.`preferences` (`userId` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
