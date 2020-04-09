-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-04-2020 a las 01:27:49
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `yelizthza`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `param_company`
--

CREATE TABLE `param_company` (
  `id_company` int(3) NOT NULL,
  `company_name` varchar(120) NOT NULL,
  `company_type` int(1) NOT NULL DEFAULT 2 COMMENT '1: VCI; 2: subcontractor',
  `contact` varchar(100) NOT NULL,
  `movil_number` varchar(12) NOT NULL,
  `email` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `param_menu`
--

CREATE TABLE `param_menu` (
  `id_menu` int(3) NOT NULL,
  `menu_name` varchar(50) NOT NULL,
  `menu_url` varchar(200) NOT NULL DEFAULT '0',
  `menu_icon` varchar(50) NOT NULL,
  `menu_order` int(1) NOT NULL,
  `menu_type` tinyint(1) NOT NULL COMMENT '1:Left; 2:Top'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `param_menu_access`
--

CREATE TABLE `param_menu_access` (
  `id_access` int(3) NOT NULL,
  `fk_id_menu` int(3) NOT NULL,
  `fk_id_link` int(3) NOT NULL,
  `fk_id_role` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `param_menu_links`
--

CREATE TABLE `param_menu_links` (
  `id_link` int(3) NOT NULL,
  `fk_id_menu` int(3) NOT NULL,
  `link_name` varchar(100) NOT NULL,
  `link_url` varchar(200) NOT NULL,
  `link_icon` varchar(50) NOT NULL,
  `order` int(1) NOT NULL,
  `date_issue` datetime NOT NULL,
  `link_state` tinyint(1) NOT NULL COMMENT '1:Active;2:Inactive',
  `link_type` tinyint(1) NOT NULL COMMENT '1:System URL;2:Complete URL; 3:Divider; 4:Complete URL, Videos; 5:Complete URL, Manuals'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `param_role`
--

CREATE TABLE `param_role` (
  `id_role` int(1) NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `style` varchar(50) NOT NULL,
  `dashboard_url` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id_user` int(10) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `log_user` varchar(50) NOT NULL,
  `movil` varchar(12) NOT NULL,
  `email` varchar(70) DEFAULT NULL,
  `password` varchar(50) NOT NULL,
  `state` int(1) NOT NULL DEFAULT 0 COMMENT '0: newUser; 1:active; 2:inactive',
  `fk_id_user_role` int(1) NOT NULL DEFAULT 7 COMMENT '99: Super Admin;',
  `photo` varchar(250) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `param_company`
--
ALTER TABLE `param_company`
  ADD PRIMARY KEY (`id_company`),
  ADD KEY `company_type` (`company_type`);

--
-- Indices de la tabla `param_menu`
--
ALTER TABLE `param_menu`
  ADD PRIMARY KEY (`id_menu`),
  ADD KEY `menu_type` (`menu_type`);

--
-- Indices de la tabla `param_menu_access`
--
ALTER TABLE `param_menu_access`
  ADD PRIMARY KEY (`id_access`),
  ADD UNIQUE KEY `indice_principal` (`fk_id_menu`,`fk_id_link`,`fk_id_role`),
  ADD KEY `fk_id_menu` (`fk_id_menu`),
  ADD KEY `fk_id_role` (`fk_id_role`),
  ADD KEY `fk_id_link` (`fk_id_link`);

--
-- Indices de la tabla `param_menu_links`
--
ALTER TABLE `param_menu_links`
  ADD PRIMARY KEY (`id_link`),
  ADD KEY `fk_id_menu` (`fk_id_menu`),
  ADD KEY `link_type` (`link_type`);

--
-- Indices de la tabla `param_role`
--
ALTER TABLE `param_role`
  ADD PRIMARY KEY (`id_role`);

--
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `log_user` (`log_user`),
  ADD KEY `perfil` (`fk_id_user_role`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `param_company`
--
ALTER TABLE `param_company`
  MODIFY `id_company` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `param_menu`
--
ALTER TABLE `param_menu`
  MODIFY `id_menu` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `param_menu_access`
--
ALTER TABLE `param_menu_access`
  MODIFY `id_access` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `param_menu_links`
--
ALTER TABLE `param_menu_links`
  MODIFY `id_link` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `param_role`
--
ALTER TABLE `param_role`
  MODIFY `id_role` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(10) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `param_menu_access`
--
ALTER TABLE `param_menu_access`
  ADD CONSTRAINT `param_menu_access_ibfk_1` FOREIGN KEY (`fk_id_role`) REFERENCES `param_role` (`id_role`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `param_menu_access_ibfk_2` FOREIGN KEY (`fk_id_menu`) REFERENCES `param_menu` (`id_menu`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `param_menu_links`
--
ALTER TABLE `param_menu_links`
  ADD CONSTRAINT `param_menu_links_ibfk_1` FOREIGN KEY (`fk_id_menu`) REFERENCES `param_menu` (`id_menu`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
