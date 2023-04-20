-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema VentasPreliminar
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema VentasPreliminar
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `VentasPreliminar` DEFAULT CHARACTER SET utf8 ;
USE `VentasPreliminar` ;

-- -----------------------------------------------------
-- Table `VentasPreliminar`.`tbl_clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VentasPreliminar`.`tbl_clientes` (
  `Pk_idCliente` INT NOT NULL,
  `Nombre_cl` VARCHAR(45) NOT NULL,
  `Telefono_cl` VARCHAR(45) NOT NULL,
  `Direccion_cl` VARCHAR(45) NOT NULL,
  `nit_cl` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Pk_idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VentasPreliminar`.`tbl_devolucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VentasPreliminar`.`tbl_devolucion` (
  `Pk_idDevolucion` INT NOT NULL,
  `Fk_idCliente` INT NOT NULL,
  `Fecha_dev` DATETIME NOT NULL,
  `Nota_cred` INT NOT NULL,
  PRIMARY KEY (`Pk_idDevolucion`),
  INDEX `Fk_idcliente_idx` (`Fk_idCliente` ASC) VISIBLE,
  CONSTRAINT `Fk_idcliente`
    FOREIGN KEY (`Fk_idCliente`)
    REFERENCES `VentasPreliminar`.`tbl_clientes` (`Pk_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VentasPreliminar`.`tbl_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VentasPreliminar`.`tbl_pedido` (
  `Pk_idPedido` INT NOT NULL,
  `Fecha_ped` DATETIME NOT NULL,
  `Fk_idcliente_ped` INT NOT NULL,
  PRIMARY KEY (`Pk_idPedido`),
  INDEX `fk_cliente_idx` (`Fk_idcliente_ped` ASC) VISIBLE,
  CONSTRAINT `fk_cliente`
    FOREIGN KEY (`Fk_idcliente_ped`)
    REFERENCES `VentasPreliminar`.`tbl_clientes` (`Pk_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VentasPreliminar`.`tbl_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VentasPreliminar`.`tbl_venta` (
  `Pk_idVenta` INT NOT NULL,
  `Fecha_venta` DATETIME NOT NULL,
  `Total` FLOAT NOT NULL,
  `Fk_pedido` INT NOT NULL,
  PRIMARY KEY (`Pk_idVenta`),
  INDEX `num_pedido_idx` (`Fk_pedido` ASC) VISIBLE,
  CONSTRAINT `num_pedido`
    FOREIGN KEY (`Fk_pedido`)
    REFERENCES `VentasPreliminar`.`tbl_pedido` (`Pk_idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VentasPreliminar`.`tbl_factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VentasPreliminar`.`tbl_factura` (
  `Pk_idFactura` INT NOT NULL,
  `fecha_fac` DATETIME NOT NULL,
  `Descuento_fac` FLOAT NOT NULL,
  `Fk_pedido` INT NOT NULL,
  `Fk_idcliente_fac` INT NOT NULL,
  `IVA` FLOAT NOT NULL,
  `Total_fac` FLOAT NOT NULL,
  `Estado_fac` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Pk_idFactura`),
  INDEX `cliente_fac_idx` (`Fk_idcliente_fac` ASC) VISIBLE,
  INDEX `pedido_fac_idx` (`Fk_pedido` ASC) VISIBLE,
  CONSTRAINT `cliente_fac`
    FOREIGN KEY (`Fk_idcliente_fac`)
    REFERENCES `VentasPreliminar`.`tbl_clientes` (`Pk_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `pedido_fac`
    FOREIGN KEY (`Fk_pedido`)
    REFERENCES `VentasPreliminar`.`tbl_pedido` (`Pk_idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VentasPreliminar`.`tbl_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VentasPreliminar`.`tbl_productos` (
  `Pk_idproductos` INT NOT NULL,
  `nombre_produc` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Pk_idproductos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VentasPreliminar`.`tbl_detalle_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VentasPreliminar`.`tbl_detalle_venta` (
  `Pk_idDetalle` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  `Precio_uni` FLOAT NOT NULL,
  `Total_detalle` FLOAT NOT NULL,
  `Estado_venta` VARCHAR(45) NOT NULL,
  `Fk_idventa_detalle` INT NOT NULL,
  `Fk_id_produc` INT NOT NULL,
  PRIMARY KEY (`Pk_idDetalle`),
  INDEX `venta_idx` (`Fk_idventa_detalle` ASC) VISIBLE,
  INDEX `producto_idx` (`Fk_id_produc` ASC) VISIBLE,
  CONSTRAINT `venta`
    FOREIGN KEY (`Fk_idventa_detalle`)
    REFERENCES `VentasPreliminar`.`tbl_venta` (`Pk_idVenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `producto`
    FOREIGN KEY (`Fk_id_produc`)
    REFERENCES `VentasPreliminar`.`tbl_productos` (`Pk_idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VentasPreliminar`.`Existencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VentasPreliminar`.`Existencias` (
  `Pk_idExistencia` INT NOT NULL,
  `No_almance` INT NOT NULL,
  `Id_producto_exis` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  PRIMARY KEY (`Pk_idExistencia`),
  INDEX `Fk_producto_idx` (`Id_producto_exis` ASC) VISIBLE,
  CONSTRAINT `Fk_producto`
    FOREIGN KEY (`Id_producto_exis`)
    REFERENCES `VentasPreliminar`.`tbl_productos` (`Pk_idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VentasPreliminar`.`tbl_cotizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VentasPreliminar`.`tbl_cotizacion` (
  `Pk_idCotizacion` INT NOT NULL,
  `Fk_Idcliente` INT NOT NULL,
  `Fk_detalleVenta` INT NOT NULL,
  PRIMARY KEY (`Pk_idCotizacion`),
  INDEX `clienteCoti_idx` (`Fk_Idcliente` ASC) VISIBLE,
  INDEX `detalleCoti_idx` (`Fk_detalleVenta` ASC) VISIBLE,
  CONSTRAINT `clienteCoti`
    FOREIGN KEY (`Fk_Idcliente`)
    REFERENCES `VentasPreliminar`.`tbl_clientes` (`Pk_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `detalleCoti`
    FOREIGN KEY (`Fk_detalleVenta`)
    REFERENCES `VentasPreliminar`.`tbl_detalle_venta` (`Pk_idDetalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;






/********************SEGURIDAD*******************************/
DROP TABLE IF EXISTS `tbl_modulos`;
CREATE TABLE IF NOT EXISTS `tbl_modulos` (
	pk_id_modulos INT NOT NULL,
    nombre_modulo VARCHAR(50) NOT NULL,
    descripcion_modulo VARCHAR(150) NOT NULL,
    estado_modulo TINYINT DEFAULT 0,
    primary key (`pk_id_modulos`)
);

DROP TABLE IF EXISTS `tbl_aplicaciones`;
CREATE TABLE IF NOT EXISTS `tbl_aplicaciones` (
	pk_id_aplicacion INT NOT NULL,
    nombre_aplicacion VARCHAR(50) NOT NULL,
    descripcion_aplicacion VARCHAR(150) NOT NULL,
    estado_aplicacion TINYINT DEFAULT 0,
    primary key (`pk_id_aplicacion`)
);

DROP TABLE IF EXISTS `tbl_AsignacionModuloAplicacion`;
CREATE TABLE IF NOT EXISTS `tbl_AsignacionModuloAplicacion` (
  fk_id_modulos INT NOT NULL,
  fk_id_aplicacion INT NOT NULL, 
  PRIMARY KEY (`fk_id_modulos`,`fk_id_aplicacion` ),
  FOREIGN KEY (`fk_id_modulos`) REFERENCES `tbl_modulos` (`pk_id_modulos`),
  FOREIGN KEY (`fk_id_aplicacion`) REFERENCES `tbl_aplicaciones` (`pk_id_aplicacion`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `tbl_usuarios`;
CREATE TABLE IF NOT EXISTS `tbl_usuarios` (
  pk_id_usuario INT AUTO_INCREMENT NOT NULL,
  nombre_usuario VARCHAR(50) NOT NULL,
  apellido_usuario VARCHAR(50) NOT NULL,
  username_usuario VARCHAR(20) NOT NULL,
  password_usuario VARCHAR(100) NOT NULL,
  email_usuario VARCHAR(50) NOT NULL,
  ultima_conexion_usuario DATETIME NULL DEFAULT NULL,
  estado_usuario TINYINT DEFAULT 0 NOT NULL,
  pregunta varchar(50) not null,
  respuesta varchar(50) not null,
  PRIMARY KEY (`pk_id_usuario`)
);

DROP TABLE IF EXISTS `tbl_perfiles`;
CREATE TABLE IF NOT EXISTS `tbl_perfiles` (
	pk_id_perfil INT AUTO_INCREMENT NOT NULL,
    nombre_perfil VARCHAR(50) NOT NULL,
    descripcion_perfil VARCHAR(150) NOT NULL,
    estado_perfil TINYINT DEFAULT 0,
    primary key (pk_id_perfil)
);

DROP TABLE IF EXISTS `tbl_permisosAplicacionesUsuario`;
CREATE TABLE IF NOT EXISTS `tbl_permisosAplicacionesUsuario` (
  fk_id_aplicacion INT NOT NULL, 
  fk_id_usuario INT NOT NULL, 
  guardar_permiso BOOLEAN DEFAULT FALSE,
  modificar_permiso BOOLEAN DEFAULT FALSE,
  eliminar_permiso BOOLEAN DEFAULT FALSE,
  buscar_permiso BOOLEAN DEFAULT FALSE,
  imprimir_permiso BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (`fk_id_aplicacion`,`fk_id_usuario`),
  FOREIGN KEY (`fk_id_aplicacion`) REFERENCES `tbl_aplicaciones` (`pk_id_aplicacion`),
  FOREIGN KEY (`fk_id_usuario`) REFERENCES `tbl_usuarios` (`pk_id_usuario`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `tbl_permisosAplicacionPerfil`;
CREATE TABLE IF NOT EXISTS `tbl_permisosAplicacionPerfil` (
  fk_id_perfil INT NOT NULL, 
  fk_id_aplicacion INT NOT NULL, 
  guardar_permiso BOOLEAN DEFAULT FALSE,
  modificar_permiso BOOLEAN DEFAULT FALSE,
  eliminar_permiso BOOLEAN DEFAULT FALSE,
  buscar_permiso BOOLEAN DEFAULT FALSE,
  imprimir_permiso BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (`fk_id_perfil`,`fk_id_aplicacion`),
  FOREIGN KEY (`fk_id_aplicacion`) REFERENCES `tbl_aplicaciones` (`pk_id_aplicacion`),
  FOREIGN KEY (`fk_id_perfil`) REFERENCES `tbl_perfiles` (`pk_id_perfil`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `tbl_asignacionesPerfilsUsuario`;
CREATE TABLE IF NOT EXISTS `tbl_asignacionesPerfilsUsuario` (
  fk_id_usuario INT NOT NULL, 
  fk_id_perfil INT NOT NULL,
  PRIMARY KEY (`fk_id_usuario`,`fk_id_perfil` ),
  FOREIGN KEY (`fk_id_usuario`) REFERENCES `tbl_usuarios` (`pk_id_usuario`),
  FOREIGN KEY (`fk_id_perfil`) REFERENCES `tbl_perfiles` (`pk_id_perfil`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `tbl_bitacoraDeEventos`;
CREATE TABLE IF NOT EXISTS `tbl_bitacoraDeEventos` (
  pk_id_bitacora INT AUTO_INCREMENT NOT NULL,
  fk_id_usuario INT NOT NULL,
  fk_id_aplicacion INT NOT NULL,
  fecha_bitacora DATE NOT NULL,
  hora_bitacora TIME NOT NULL,
  host_bitacora VARCHAR(45) NOT NULL,
  ip_bitacora VARCHAR(100) NOT NULL,
  accion_bitacora VARCHAR(50) NOT NULL,
  PRIMARY KEY (`pk_id_bitacora`),
  FOREIGN KEY (`fk_id_usuario`) REFERENCES `tbl_usuarios` (`pk_id_usuario`),
  FOREIGN KEY (`fk_id_aplicacion`) REFERENCES `tbl_aplicaciones` (`pk_id_aplicacion`)
)ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;



/*-------------------------------------------------------------------------------------------*/
INSERT INTO `tbl_usuarios` VALUES 
('8', 'Examen', 'Examen', 'examen', '1234', 'examen@gmail.com', '2022-07-02 21:00:48', '1','COLOR FAVORITO','celeste');
/*
('7', 'Ventas', 'Ventas', 'ventas', '1234', 'ventas@gmail.com', '2022-07-02 21:00:48', '1','COLOR FAVORITO','celeste');
*/
INSERT INTO `tbl_perfiles` VALUES ('6', 'Bancos', 'Todo Bancos', '1');
INSERT INTO `tbl_perfiles` VALUES ('7', 'Ventasss', 'Todo Ventasss', '1');
INSERT INTO `tbl_perfiles` VALUES ('8', 'Examen', 'Todo Examen', '1');

INSERT INTO `tbl_asignacionesperfilsusuario` VALUES 
('6', '6');


INSERT INTO `tbl_modulos` VALUES
('7000', 'BANCOS', 'Bancos', 1);


INSERT INTO `tbl_aplicaciones` VALUES
('7000', 'MDI BANCOS', 'PARA BANCOS', '1');

-- -----PERMISOS DE APLICACIONES A PERFILES
INSERT INTO `tbl_permisosAplicacionPerfil` VALUES
('6', '7000', '1', '1', '1', '1', '1');




INSERT INTO `colchoneria`.`tbl_aplicaciones` (`pk_id_aplicacion`, `nombre_aplicacion`, `descripcion_aplicacion`, `estado_aplicacion`) VALUES(7001, 'MDI Ventas', 'Para Ventas','1');


INSERT INTO `tbl_permisosaplicacionperfil` VALUES 
(7, '7001','1','1','1','1','1');

INSERT INTO `tbl_permisosaplicacionperfil` VALUES 
(8, '7000','1','1','1','1','1');

INSERT INTO `tbl_clientes` VALUES (1,"Velvet Samayoa","54212541","15 calle zona 12","125412-8");
INSERT INTO `tbl_clientes` VALUES (2,"Cori Samayoa","84652541","15 calle zona 12","125412-8");

















