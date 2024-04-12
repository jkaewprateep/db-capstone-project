-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customer_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer_details` (
  `CustomerID` INT NOT NULL,
  `Fullname` VARCHAR(255) NULL,
  `Address` VARCHAR(255) NULL,
  `Contact` VARCHAR(255) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingsID` INT NOT NULL,
  `BookingDate` DATE NOT NULL,
  `TableNo` INT NOT NULL,
  `CustomerID` INT NULL,
  `Customer_details_CustomerID` INT NOT NULL,
  PRIMARY KEY (`BookingsID`),
  INDEX `fk_Bookings_Customer_details_idx` (`Customer_details_CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customer_details`
    FOREIGN KEY (`Customer_details_CustomerID`)
    REFERENCES `LittleLemonDB`.`Customer_details` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff_information` (
  `EmployeeID` INT NOT NULL,
  `Fullname` VARCHAR(255) NULL,
  `Role` VARCHAR(255) NULL,
  `Salary` DECIMAL(10,2) NULL,
  `OrderID` INT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrdersID` INT NOT NULL,
  `OrderDate` DATE NOT NULL,
  `Quantity` INT NULL,
  `Cost` DECIMAL(10,2) NULL,
  `CustomerID` INT NULL,
  `MenuID` INT NULL,
  `Customer_details_CustomerID` INT NOT NULL,
  `EmployeeID` VARCHAR(45) NULL,
  `Staff_information_EmployeeID` INT NOT NULL,
  PRIMARY KEY (`OrdersID`),
  INDEX `fk_Orders_Customer_details1_idx` (`Customer_details_CustomerID` ASC) VISIBLE,
  INDEX `fk_Orders_Staff_information1_idx` (`Staff_information_EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Customer_details1`
    FOREIGN KEY (`Customer_details_CustomerID`)
    REFERENCES `LittleLemonDB`.`Customer_details` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Staff_information1`
    FOREIGN KEY (`Staff_information_EmployeeID`)
    REFERENCES `LittleLemonDB`.`Staff_information` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Order_delivery_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Order_delivery_status` (
  `DeliveryID` INT NOT NULL,
  `DeliveryStatus` VARCHAR(45) NULL,
  `DeliveryDate` DATE NULL,
  `OrderID` INT NULL,
  `Orders_OrdersID` INT NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `fk_Order_delivery_status_Orders1_idx` (`Orders_OrdersID` ASC) VISIBLE,
  CONSTRAINT `fk_Order_delivery_status_Orders1`
    FOREIGN KEY (`Orders_OrdersID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrdersID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuID` INT NOT NULL,
  `cuisines` VARCHAR(255) NULL,
  `starters` VARCHAR(255) NULL,
  `courses` VARCHAR(255) NULL,
  `drinks` VARCHAR(255) NULL,
  `desserts` VARCHAR(255) NULL,
  `Orders_OrdersID` INT NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `fk_Menu_Orders1_idx` (`Orders_OrdersID` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_Orders1`
    FOREIGN KEY (`Orders_OrdersID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrdersID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
