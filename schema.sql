-- MySQL dump 10.13  Distrib 5.6.24, for osx10.8 (x86_64)
--
-- Host: 127.0.0.1    Database: pokemon
-- ------------------------------------------------------
-- Server version	5.6.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Ability`
--

DROP TABLE IF EXISTS `Ability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ability` (
  `abilityId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `abilityName` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`abilityId`),
  UNIQUE KEY `ability_id_UNIQUE` (`abilityId`),
  UNIQUE KEY `abilityName_UNIQUE` (`abilityName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ability`
--

LOCK TABLES `Ability` WRITE;
/*!40000 ALTER TABLE `Ability` DISABLE KEYS */;
/*!40000 ALTER TABLE `Ability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Class`
--

DROP TABLE IF EXISTS `Class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Class` (
  `classId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `classDescription` varchar(255) NOT NULL,
  PRIMARY KEY (`classId`),
  UNIQUE KEY `classId_UNIQUE` (`classId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Class`
--

LOCK TABLES `Class` WRITE;
/*!40000 ALTER TABLE `Class` DISABLE KEYS */;
/*!40000 ALTER TABLE `Class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Evolution`
--

DROP TABLE IF EXISTS `Evolution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Evolution` (
  `evolutionId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `startPokemonId` int(11) unsigned NOT NULL,
  `endPokemonId` int(11) unsigned NOT NULL,
  `methodId` int(11) unsigned NOT NULL,
  `levelRequirement` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`evolutionId`),
  UNIQUE KEY `evolutionId_UNIQUE` (`evolutionId`),
  KEY `startPokemonId_idx` (`startPokemonId`),
  KEY `endPokemonId_idx` (`endPokemonId`),
  KEY `methodId_idx` (`methodId`),
  CONSTRAINT `endPokemonId` FOREIGN KEY (`endPokemonId`) REFERENCES `Pokemon` (`pokemonId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `methodId` FOREIGN KEY (`methodId`) REFERENCES `Method` (`methodId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `startPokemonId` FOREIGN KEY (`startPokemonId`) REFERENCES `Pokemon` (`pokemonId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Evolution`
--

LOCK TABLES `Evolution` WRITE;
/*!40000 ALTER TABLE `Evolution` DISABLE KEYS */;
/*!40000 ALTER TABLE `Evolution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Method`
--

DROP TABLE IF EXISTS `Method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Method` (
  `methodId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `methodDescription` varchar(255) NOT NULL,
  PRIMARY KEY (`methodId`),
  UNIQUE KEY `methodId_UNIQUE` (`methodId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Method`
--

LOCK TABLES `Method` WRITE;
/*!40000 ALTER TABLE `Method` DISABLE KEYS */;
/*!40000 ALTER TABLE `Method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MoveAcquisition`
--

DROP TABLE IF EXISTS `MoveAcquisition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MoveAcquisition` (
  `MoveAcquisitionId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pokemonId` int(11) unsigned NOT NULL,
  `moveId` int(11) NOT NULL,
  `methodId` int(11) unsigned NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`MoveAcquisitionId`),
  UNIQUE KEY `MoveAcquisitionId_UNIQUE` (`MoveAcquisitionId`),
  KEY `pokemonId_idx` (`pokemonId`),
  KEY `moveId_idx` (`moveId`),
  KEY `methodId_idx` (`methodId`),
  CONSTRAINT `methodId2` FOREIGN KEY (`methodId`) REFERENCES `Method` (`methodId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `moveId` FOREIGN KEY (`moveId`) REFERENCES `Moves` (`moveId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pokemonId` FOREIGN KEY (`pokemonId`) REFERENCES `Pokemon` (`pokemonId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MoveAcquisition`
--

LOCK TABLES `MoveAcquisition` WRITE;
/*!40000 ALTER TABLE `MoveAcquisition` DISABLE KEYS */;
/*!40000 ALTER TABLE `MoveAcquisition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Moves`
--

DROP TABLE IF EXISTS `Moves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Moves` (
  `moveId` int(11) NOT NULL AUTO_INCREMENT,
  `moveName` varchar(255) NOT NULL,
  `power` int(11) unsigned DEFAULT NULL,
  `pp` int(11) unsigned NOT NULL,
  `accuracy` int(11) unsigned NOT NULL,
  `classId` int(11) unsigned NOT NULL,
  `typeId` int(11) unsigned NOT NULL,
  `priority` int(11) NOT NULL,
  PRIMARY KEY (`moveId`),
  UNIQUE KEY `move_id_UNIQUE` (`moveId`),
  UNIQUE KEY `move_name_UNIQUE` (`moveName`),
  KEY `classId_idx` (`classId`),
  KEY `typeId_Moves_idx` (`typeId`),
  CONSTRAINT `classId` FOREIGN KEY (`classId`) REFERENCES `Class` (`classId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `typeId_Moves` FOREIGN KEY (`typeId`) REFERENCES `Type` (`typeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Moves`
--

LOCK TABLES `Moves` WRITE;
/*!40000 ALTER TABLE `Moves` DISABLE KEYS */;
/*!40000 ALTER TABLE `Moves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pokemon`
--

DROP TABLE IF EXISTS `Pokemon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pokemon` (
  `pokemonId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pokedexNumber` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `attack` int(11) unsigned NOT NULL DEFAULT '0',
  `defense` int(11) unsigned NOT NULL DEFAULT '0',
  `specialAttack` int(11) unsigned NOT NULL DEFAULT '0',
  `specialDefense` int(11) unsigned NOT NULL DEFAULT '0',
  `speed` int(11) unsigned NOT NULL DEFAULT '0',
  `type1` int(11) unsigned NOT NULL,
  `type2` int(11) unsigned NOT NULL,
  `ability1` int(11) unsigned NOT NULL,
  `ability2` int(11) unsigned DEFAULT NULL,
  `ability3` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`pokemonId`),
  UNIQUE KEY `id_UNIQUE` (`pokemonId`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `type1_idx` (`type1`),
  KEY `type2_idx` (`type2`),
  KEY `ability1_idx` (`ability1`),
  KEY `ability2_idx` (`ability2`),
  KEY `ability3_idx` (`ability3`),
  CONSTRAINT `ability1` FOREIGN KEY (`ability1`) REFERENCES `Ability` (`abilityId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ability2` FOREIGN KEY (`ability2`) REFERENCES `Ability` (`abilityId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ability3` FOREIGN KEY (`ability3`) REFERENCES `Ability` (`abilityId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `type1` FOREIGN KEY (`type1`) REFERENCES `Type` (`typeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `type2` FOREIGN KEY (`type2`) REFERENCES `Type` (`typeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pokemon`
--

LOCK TABLES `Pokemon` WRITE;
/*!40000 ALTER TABLE `Pokemon` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pokemon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Type`
--

DROP TABLE IF EXISTS `Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Type` (
  `typeId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `typeName` varchar(255) NOT NULL,
  PRIMARY KEY (`typeId`),
  UNIQUE KEY `typeId_UNIQUE` (`typeId`),
  UNIQUE KEY `typeName_UNIQUE` (`typeName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Type`
--

LOCK TABLES `Type` WRITE;
/*!40000 ALTER TABLE `Type` DISABLE KEYS */;
/*!40000 ALTER TABLE `Type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TypeStrength`
--

DROP TABLE IF EXISTS `TypeStrength`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TypeStrength` (
  `typeStrengthId` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `typeId` int(11) unsigned NOT NULL,
  `typeIdOfStrength` int(11) unsigned NOT NULL,
  PRIMARY KEY (`typeStrengthId`),
  UNIQUE KEY `typeStrengthId_UNIQUE` (`typeStrengthId`),
  KEY `type1_idx` (`typeId`),
  KEY `typeIdOfStrength_idx` (`typeIdOfStrength`),
  CONSTRAINT `typeId` FOREIGN KEY (`typeId`) REFERENCES `Type` (`typeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `typeIdOfStrength` FOREIGN KEY (`typeIdOfStrength`) REFERENCES `Type` (`typeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TypeStrength`
--

LOCK TABLES `TypeStrength` WRITE;
/*!40000 ALTER TABLE `TypeStrength` DISABLE KEYS */;
/*!40000 ALTER TABLE `TypeStrength` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TypeWeakness`
--

DROP TABLE IF EXISTS `TypeWeakness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TypeWeakness` (
  `typeWeaknessKey` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `typeId` int(11) unsigned NOT NULL,
  `typeIdOfWeakness` int(11) unsigned NOT NULL,
  PRIMARY KEY (`typeWeaknessKey`),
  UNIQUE KEY `typeWeaknessKey_UNIQUE` (`typeWeaknessKey`),
  KEY `typeId_idx` (`typeId`),
  KEY `typeIdOfWeakness_idx` (`typeIdOfWeakness`),
  CONSTRAINT `typeIdOfWeakness` FOREIGN KEY (`typeIdOfWeakness`) REFERENCES `Type` (`typeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `typeId_typeWeakness` FOREIGN KEY (`typeIdOfWeakness`) REFERENCES `Type` (`typeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TypeWeakness`
--

LOCK TABLES `TypeWeakness` WRITE;
/*!40000 ALTER TABLE `TypeWeakness` DISABLE KEYS */;
/*!40000 ALTER TABLE `TypeWeakness` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-03 17:30:38
