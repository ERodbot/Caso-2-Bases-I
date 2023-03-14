-- MySQL Script generated by MySQL Workbench
-- Mon Mar 13 09:35:01 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Copos
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Copos` ;

-- -----------------------------------------------------
-- Schema Copos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Copos` DEFAULT CHARACTER SET utf8 ;
USE `Copos` ;

-- -----------------------------------------------------
-- Table `Copos`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`products` ;

CREATE TABLE IF NOT EXISTS `Copos`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(35) NOT NULL,
  `enabled` BIT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`bank_accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`bank_accounts` ;

CREATE TABLE IF NOT EXISTS `Copos`.`bank_accounts` (
  `bank_account_id` INT NOT NULL,
  `account_number` VARCHAR(30) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`bank_account_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`beaches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`beaches` ;

CREATE TABLE IF NOT EXISTS `Copos`.`beaches` (
  `beach_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`beach_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`users` ;

CREATE TABLE IF NOT EXISTS `Copos`.`users` (
  `user_id` INT NOT NULL,
  `bank_account_id` INT NOT NULL,
  `beach_id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `nationality` VARCHAR(30) NOT NULL,
  `birth_date` DATE NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone_number` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `fk_usuarios_cuentas_bancarias1_idx` (`bank_account_id` ASC) VISIBLE,
  INDEX `fk_users_beaches1_idx` (`beach_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_cuentas_bancarias1`
    FOREIGN KEY (`bank_account_id`)
    REFERENCES `Copos`.`bank_accounts` (`bank_account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_beaches1`
    FOREIGN KEY (`beach_id`)
    REFERENCES `Copos`.`beaches` (`beach_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`coperos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`coperos` ;

CREATE TABLE IF NOT EXISTS `Copos`.`coperos` (
  `copero_id` INT NOT NULL COMMENT 'identificacion del copero',
  `bank_account_id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `phone_number` INT NOT NULL,
  `enabled` BIT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`copero_id`),
  INDEX `fk_coperos_cuentas_bancarias1_idx` (`bank_account_id` ASC) VISIBLE,
  CONSTRAINT `fk_coperos_cuentas_bancarias1`
    FOREIGN KEY (`bank_account_id`)
    REFERENCES `Copos`.`bank_accounts` (`bank_account_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`invoices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`invoices` ;

CREATE TABLE IF NOT EXISTS `Copos`.`invoices` (
  `invoice_id` INT NOT NULL,
  `copero_id` INT NOT NULL,
  `user_id` INT NULL,
  `total_cost` DECIMAL(10,2) NULL,
  `total_paid` DECIMAL(10,2) NOT NULL,
  `total_change` DECIMAL(10,2) NULL,
  `payment_method` VARCHAR(10) NOT NULL,
  `date` DATETIME NOT NULL,
  `invoice_type` VARCHAR(20) NOT NULL,
  `invoice_status` VARCHAR(20) NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`invoice_id`),
  INDEX `fk_transacciones_usuarios1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_transactions_coperos1_idx` (`copero_id` ASC) VISIBLE,
  CONSTRAINT `fk_transacciones_usuarios1`
    FOREIGN KEY (`user_id`)
    REFERENCES `Copos`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_coperos1`
    FOREIGN KEY (`copero_id`)
    REFERENCES `Copos`.`coperos` (`copero_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`orders` ;

CREATE TABLE IF NOT EXISTS `Copos`.`orders` (
  `order_id` INT NOT NULL,
  `user_id` INT NULL,
  `product_id` INT NOT NULL,
  `comment` VARCHAR(500) NULL,
  `status` BIT NOT NULL,
  `quantity` SMALLINT NOT NULL,
  `specific_location` VARCHAR(100) NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_orders_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `Copos`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Copos`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`invoice_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`invoice_details` ;

CREATE TABLE IF NOT EXISTS `Copos`.`invoice_details` (
  `invoice_detail_id` INT NOT NULL AUTO_INCREMENT,
  `invoice_id` INT NOT NULL,
  `order_id` INT NULL,
  `subtotal_cost` DECIMAL(7,2) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`invoice_detail_id`),
  INDEX `fk_copo_ventas_transacciones1_idx` (`invoice_id` ASC) VISIBLE,
  INDEX `fk_invoice_details_orders1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_copo_ventas_transacciones1`
    FOREIGN KEY (`invoice_id`)
    REFERENCES `Copos`.`invoices` (`invoice_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_details_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `Copos`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`cars`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`cars` ;

CREATE TABLE IF NOT EXISTS `Copos`.`cars` (
  `car_id` SMALLINT NOT NULL,
  `color` VARCHAR(10) NOT NULL,
  `enabled` BIT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`car_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`schedules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`schedules` ;

CREATE TABLE IF NOT EXISTS `Copos`.`schedules` (
  `schedule_id` INT NOT NULL,
  `copero_id` INT NOT NULL,
  `carrito_id` SMALLINT NOT NULL,
  `playa_id` INT NOT NULL,
  `pickup_date` DATETIME NOT NULL,
  `dropoff_date` DATETIME NOT NULL,
  `pickup_location` VARCHAR(50) NOT NULL,
  `dropoff_location` VARCHAR(50) NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `created_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `checksum(150)` VARCHAR(45) NOT NULL,
  INDEX `fk_carritos_por_copero_coperos1_idx` (`copero_id` ASC) VISIBLE,
  INDEX `fk_carritos_por_copero_carritos1_idx` (`carrito_id` ASC) VISIBLE,
  INDEX `fk_carritos_por_copero_playas1_idx` (`playa_id` ASC) VISIBLE,
  PRIMARY KEY (`schedule_id`),
  CONSTRAINT `fk_carritos_por_copero_coperos1`
    FOREIGN KEY (`copero_id`)
    REFERENCES `Copos`.`coperos` (`copero_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carritos_por_copero_carritos1`
    FOREIGN KEY (`carrito_id`)
    REFERENCES `Copos`.`cars` (`car_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carritos_por_copero_playas1`
    FOREIGN KEY (`playa_id`)
    REFERENCES `Copos`.`beaches` (`beach_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`ingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`ingredients` ;

CREATE TABLE IF NOT EXISTS `Copos`.`ingredients` (
  `ingredient_id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `measurement` VARCHAR(10) NOT NULL,
  `enabled` BIT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`ingredient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`ingredients_per_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`ingredients_per_products` ;

CREATE TABLE IF NOT EXISTS `Copos`.`ingredients_per_products` (
  `product_id` INT NOT NULL,
  `ingredient_id` INT NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL COMMENT 'amount of engredient used for each product',
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  INDEX `fk_ingredientes_por_productos_copo_productos1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_ingredientes_por_productos_ingredientes1_idx` (`ingredient_id` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientes_por_productos_copo_productos1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Copos`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientes_por_productos_ingredientes1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `Copos`.`ingredients` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`check_statuses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`check_statuses` ;

CREATE TABLE IF NOT EXISTS `Copos`.`check_statuses` (
  `check_status_id` INT NOT NULL,
  `status_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`check_status_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`check_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`check_types` ;

CREATE TABLE IF NOT EXISTS `Copos`.`check_types` (
  `check_type_id` INT NOT NULL,
  `type_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`check_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`inventory_checks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`inventory_checks` ;

CREATE TABLE IF NOT EXISTS `Copos`.`inventory_checks` (
  `inventory_check_id` INT NOT NULL,
  `check_statuses_id` INT NOT NULL,
  `check_types_id` INT NOT NULL,
  `first_copero` INT NOT NULL,
  `second_copero` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`inventory_check_id`),
  INDEX `fk_inventory_checks_check_statuses1_idx` (`check_statuses_id` ASC) VISIBLE,
  INDEX `fk_inventory_checks_check_types1_idx` (`check_types_id` ASC) VISIBLE,
  INDEX `fk_inventory_checks_coperos1_idx` (`first_copero` ASC) VISIBLE,
  INDEX `fk_inventory_checks_coperos2_idx` (`second_copero` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_checks_check_statuses1`
    FOREIGN KEY (`check_statuses_id`)
    REFERENCES `Copos`.`check_statuses` (`check_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_checks_check_types1`
    FOREIGN KEY (`check_types_id`)
    REFERENCES `Copos`.`check_types` (`check_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_checks_coperos1`
    FOREIGN KEY (`first_copero`)
    REFERENCES `Copos`.`coperos` (`copero_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_checks_coperos2`
    FOREIGN KEY (`second_copero`)
    REFERENCES `Copos`.`coperos` (`copero_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`inventories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`inventories` ;

CREATE TABLE IF NOT EXISTS `Copos`.`inventories` (
  `inventory_id` INT NOT NULL,
  `car_id` SMALLINT NOT NULL,
  `ingredient_id` INT NOT NULL,
  `quantity` DECIMAL(7,2) NOT NULL,
  `created_at` VARCHAR(45) NOT NULL,
  `updated_at` VARCHAR(45) NOT NULL,
  `operation_type` VARCHAR(10) NOT NULL,
  `inventory_check_id` INT NULL,
  INDEX `fk_ingredientes_por_carrito_carritos1_idx` (`car_id` ASC) VISIBLE,
  INDEX `fk_ingredientes_por_carrito_ingredientes1_idx` (`ingredient_id` ASC) VISIBLE,
  PRIMARY KEY (`inventory_id`),
  INDEX `fk_inventories_inventory_checks1_idx` (`inventory_check_id` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientes_por_carrito_carritos1`
    FOREIGN KEY (`car_id`)
    REFERENCES `Copos`.`cars` (`car_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientes_por_carrito_ingredientes1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `Copos`.`ingredients` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventories_inventory_checks1`
    FOREIGN KEY (`inventory_check_id`)
    REFERENCES `Copos`.`inventory_checks` (`inventory_check_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`commissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`commissions` ;

CREATE TABLE IF NOT EXISTS `Copos`.`commissions` (
  `commission_id` INT NOT NULL,
  `percentage` DECIMAL(10,2) NOT NULL,
  `initial_date` DATE NOT NULL,
  `final_date` DATE NOT NULL,
  `enabled` BIT NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`commission_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`price_logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`price_logs` ;

CREATE TABLE IF NOT EXISTS `Copos`.`price_logs` (
  `price_log_id` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `product_id` INT NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`price_log_id`),
  INDEX `fk_price_logs_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_price_logs_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Copos`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`beach_prices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`beach_prices` ;

CREATE TABLE IF NOT EXISTS `Copos`.`beach_prices` (
  `beach_price_id` INT NOT NULL,
  `start_date` DATETIME NOT NULL,
  `final_date` DATETIME NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `beach_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `chesksum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`beach_price_id`),
  INDEX `fk_beach_prices_beaches1_idx` (`beach_id` ASC) VISIBLE,
  INDEX `fk_beach_prices_products1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_beach_prices_beaches1`
    FOREIGN KEY (`beach_id`)
    REFERENCES `Copos`.`beaches` (`beach_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_beach_prices_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `Copos`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`copero_payments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`copero_payments` ;

CREATE TABLE IF NOT EXISTS `Copos`.`copero_payments` (
  `copero_payment_id` INT NOT NULL,
  `payday` DECIMAL(10,2) NOT NULL,
  `commission_id` INT NOT NULL,
  `invoices_invoice_id` INT NOT NULL,
  `enabled` BIT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NULL,
  `username` VARCHAR(45) NOT NULL,
  `chechsum` VARBINARY(150) NOT NULL,
  PRIMARY KEY (`copero_payment_id`),
  INDEX `fk_copero_payments_commissions1_idx` (`commission_id` ASC) VISIBLE,
  INDEX `fk_copero_payments_invoices1_idx` (`invoices_invoice_id` ASC) VISIBLE,
  CONSTRAINT `fk_copero_payments_commissions1`
    FOREIGN KEY (`commission_id`)
    REFERENCES `Copos`.`commissions` (`commission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_copero_payments_invoices1`
    FOREIGN KEY (`invoices_invoice_id`)
    REFERENCES `Copos`.`invoices` (`invoice_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`cashbox_checks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`cashbox_checks` ;

CREATE TABLE IF NOT EXISTS `Copos`.`cashbox_checks` (
  `cashbox_check_id` INT NOT NULL,
  `check_statuses_id` INT NOT NULL,
  `check_types_id` INT NOT NULL,
  `first_copero` INT NOT NULL,
  `second_copero` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `computer` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `checksum` VARBINARY(150) NULL,
  PRIMARY KEY (`cashbox_check_id`),
  INDEX `fk_box_checks_check_statuses1_idx` (`check_statuses_id` ASC) VISIBLE,
  INDEX `fk_box_checks_check_types1_idx` (`check_types_id` ASC) VISIBLE,
  INDEX `fk_box_checks_coperos1_idx` (`first_copero` ASC) VISIBLE,
  INDEX `fk_box_checks_coperos2_idx` (`second_copero` ASC) VISIBLE,
  CONSTRAINT `fk_box_checks_check_statuses1`
    FOREIGN KEY (`check_statuses_id`)
    REFERENCES `Copos`.`check_statuses` (`check_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_box_checks_check_types1`
    FOREIGN KEY (`check_types_id`)
    REFERENCES `Copos`.`check_types` (`check_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_box_checks_coperos1`
    FOREIGN KEY (`first_copero`)
    REFERENCES `Copos`.`coperos` (`copero_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_box_checks_coperos2`
    FOREIGN KEY (`second_copero`)
    REFERENCES `Copos`.`coperos` (`copero_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`cashboxes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`cashboxes` ;

CREATE TABLE IF NOT EXISTS `Copos`.`cashboxes` (
  `cashbox_id` INT NOT NULL,
  `amount` DECIMAL(11,2) NOT NULL,
  `car_id` SMALLINT NOT NULL,
  `box_check_id` INT NOT NULL,
  PRIMARY KEY (`cashbox_id`),
  INDEX `fk_boxes_cars1_idx` (`car_id` ASC) VISIBLE,
  INDEX `fk_boxes_box_checks1_idx` (`box_check_id` ASC) VISIBLE,
  CONSTRAINT `fk_boxes_cars1`
    FOREIGN KEY (`car_id`)
    REFERENCES `Copos`.`cars` (`car_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_boxes_box_checks1`
    FOREIGN KEY (`box_check_id`)
    REFERENCES `Copos`.`cashbox_checks` (`cashbox_check_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`event_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`event_types` ;

CREATE TABLE IF NOT EXISTS `Copos`.`event_types` (
  `event_type_id` INT NOT NULL,
  `type_name` VARCHAR(20) NULL,
  PRIMARY KEY (`event_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`object_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`object_types` ;

CREATE TABLE IF NOT EXISTS `Copos`.`object_types` (
  `object_type_id` INT NOT NULL,
  `object_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`object_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`levels`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`levels` ;

CREATE TABLE IF NOT EXISTS `Copos`.`levels` (
  `level_id` INT NOT NULL,
  `level_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`level_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`sources`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`sources` ;

CREATE TABLE IF NOT EXISTS `Copos`.`sources` (
  `source_id` INT NOT NULL,
  `source_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`source_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Copos`.`event_logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Copos`.`event_logs` ;

CREATE TABLE IF NOT EXISTS `Copos`.`event_logs` (
  `event_log_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `computer` VARCHAR(20) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `checksum` VARBINARY(150) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `reference_id1` BIGINT NOT NULL,
  `referenci_id2` BIGINT NOT NULL,
  `value1` VARCHAR(60) NOT NULL,
  `value2` VARCHAR(60) NOT NULL,
  `event_type_id` INT NOT NULL,
  `object_type_id` INT NOT NULL,
  `level_id` INT NOT NULL,
  `source_id` INT NOT NULL,
  PRIMARY KEY (`event_log_id`),
  INDEX `fk_event_logs_event_types1_idx` (`event_type_id` ASC) VISIBLE,
  INDEX `fk_event_logs_object_types1_idx` (`object_type_id` ASC) VISIBLE,
  INDEX `fk_event_logs_levels1_idx` (`level_id` ASC) VISIBLE,
  INDEX `fk_event_logs_sources1_idx` (`source_id` ASC) VISIBLE,
  CONSTRAINT `fk_event_logs_event_types1`
    FOREIGN KEY (`event_type_id`)
    REFERENCES `Copos`.`event_types` (`event_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_logs_object_types1`
    FOREIGN KEY (`object_type_id`)
    REFERENCES `Copos`.`object_types` (`object_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_logs_levels1`
    FOREIGN KEY (`level_id`)
    REFERENCES `Copos`.`levels` (`level_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_logs_sources1`
    FOREIGN KEY (`source_id`)
    REFERENCES `Copos`.`sources` (`source_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;