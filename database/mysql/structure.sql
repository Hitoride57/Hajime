-- --------------------------------------------------------
-- Hôte :                        127.0.0.1
-- Version du serveur:           10.1.34-MariaDB - Source distribution
-- SE du serveur:                Linux
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Listage de la structure de la table askc. Competition
CREATE TABLE IF NOT EXISTS `Competition` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `choosen_formula_id` int(10) unsigned NOT NULL,
  `date` date NOT NULL,
  `name` varchar(255) NOT NULL,
  `place` varchar(255) DEFAULT NULL,
  `owner` varchar(45) DEFAULT NULL,
  `type` varchar(10) NOT NULL,
  `locked` tinyint(3) unsigned DEFAULT '0',
  `locked_fighter_list` tinyint(3) unsigned DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `choosen_formula_id_idx` (`choosen_formula_id`),
  CONSTRAINT `choosen_formula_id` FOREIGN KEY (`choosen_formula_id`) REFERENCES `Formula` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table askc. CompetitionFormula
CREATE TABLE IF NOT EXISTS `CompetitionFormula` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `competition_id` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idCompetitionFormula_UNIQUE` (`id`),
  KEY `idCompetition_idx` (`competition_id`),
  CONSTRAINT `competition_formula_id_competition` FOREIGN KEY (`competition_id`) REFERENCES `Competition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table askc. Fighter
CREATE TABLE IF NOT EXISTS `Fighter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `competition_id` int(10) unsigned NOT NULL,
  `team_id` int(10) unsigned DEFAULT NULL,
  `license` varchar(16) NOT NULL,
  `name` varchar(255) NOT NULL,
  `grade` varchar(15) DEFAULT NULL,
  `club` varchar(255) DEFAULT NULL,
  `birthdate` date NOT NULL,
  `is_present` tinyint(3) unsigned DEFAULT '0',
  `is_favorite` tinyint(3) unsigned DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `license_UNIQUE` (`competition_id`,`license`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `Competition_id_idx` (`competition_id`),
  KEY `fk_CompetitionFighter_CompetitionTeam1_idx` (`team_id`),
  CONSTRAINT `competition_fighter_id_competition` FOREIGN KEY (`competition_id`) REFERENCES `Competition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CompetitionFighter_CompetitionTeam1` FOREIGN KEY (`team_id`) REFERENCES `Team` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table askc. Formula
CREATE TABLE IF NOT EXISTS `Formula` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `component_list` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table askc. Meta
CREATE TABLE IF NOT EXISTS `Meta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `metaable_id` int(10) unsigned NOT NULL,
  `metaable` varchar(45) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `meta_UNIQUE` (`metaable_id`,`metaable`,`key`,`value`),
  KEY `idMetaable_idx` (`metaable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table askc. Pool
CREATE TABLE IF NOT EXISTS `Pool` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `competition_formula_id` int(10) unsigned NOT NULL,
  `number` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `pool_number_unique` (`competition_formula_id`,`number`),
  CONSTRAINT `fk_Pool_CompetitionFormula` FOREIGN KEY (`competition_formula_id`) REFERENCES `CompetitionFormula` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table askc. PoolConfiguration
CREATE TABLE IF NOT EXISTS `PoolConfiguration` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `competition_formula_id` int(10) unsigned NOT NULL,
  `number_of_qualified_fighter` int(10) unsigned DEFAULT '1',
  `number_of_pool` int(10) unsigned DEFAULT '1',
  `number_of_entry_per_pool` int(10) unsigned DEFAULT '1',
  `dismiss_favorite` tinyint(3) unsigned DEFAULT '0',
  `lock` tinyint(3) unsigned DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `competition_formula_id_UNIQUE` (`competition_formula_id`),
  KEY `fk_Pool_CompetitionFormula_idx` (`competition_formula_id`),
  CONSTRAINT `fk_Pool_CompetitionFormula1` FOREIGN KEY (`competition_formula_id`) REFERENCES `CompetitionFormula` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table askc. PoolEntry
CREATE TABLE IF NOT EXISTS `PoolEntry` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pool_id` int(10) unsigned NOT NULL,
  `number` int(10) unsigned NOT NULL,
  `entriable_id` int(10) unsigned NOT NULL,
  `entriable` varchar(45) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `pool_entry_unique` (`pool_id`,`entriable_id`,`entriable`),
  UNIQUE KEY `pool_entry_number_unique` (`number`,`pool_id`),
  KEY `fk_PoolEntry_Pool1_idx` (`pool_id`),
  CONSTRAINT `fk_PoolEntry_Pool1` FOREIGN KEY (`pool_id`) REFERENCES `Pool` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table askc. Team
CREATE TABLE IF NOT EXISTS `Team` (
  `id` int(10) unsigned NOT NULL,
  `competition_id` int(10) unsigned NOT NULL,
  `name` varchar(150) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_CompetitionTeam_Competition1_idx` (`competition_id`),
  CONSTRAINT `fk_CompetitionTeam_Competition1` FOREIGN KEY (`competition_id`) REFERENCES `Competition` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table askc. TreeConfiguration
CREATE TABLE IF NOT EXISTS `TreeConfiguration` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `competition_formula_id` int(10) unsigned NOT NULL,
  `dismiss_favorite` tinyint(3) unsigned DEFAULT '0',
  `third_place` tinyint(3) unsigned DEFAULT '0',
  `lock` tinyint(3) unsigned DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `competition_formula_UNIQUE` (`competition_formula_id`),
  KEY `fk_Pool_CompetitionFormula1_idx` (`competition_formula_id`),
  CONSTRAINT `fk_Pool_CompetitionFormula10` FOREIGN KEY (`competition_formula_id`) REFERENCES `CompetitionFormula` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
