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
  `hp` int(10) unsigned NOT NULL DEFAULT '0',
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
  KEY `ability1_idx` (`ability1`)
) ENGINE=InnoDB AUTO_INCREMENT=454 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pokemon`
--

LOCK TABLES `Pokemon` WRITE;
/*!40000 ALTER TABLE `Pokemon` DISABLE KEYS */;
INSERT INTO `Pokemon` VALUES (303,1,'bulbasaur',45,49,49,65,65,45,12,4,65,0,34),(304,2,'ivysaur',60,62,63,80,80,60,12,4,65,0,34),(305,3,'venusaur',80,82,83,100,100,80,12,4,65,0,34),(306,4,'charmander',39,52,43,60,50,65,10,10,66,0,94),(307,5,'charmeleon',58,64,58,80,65,80,10,10,66,0,94),(308,6,'charizard',78,84,78,109,85,100,10,3,66,0,94),(309,7,'squirtle',44,48,65,50,64,43,11,11,67,0,44),(310,8,'wartortle',59,63,80,65,80,58,11,11,67,0,44),(311,9,'blastoise',79,83,100,85,105,78,11,11,67,0,44),(312,10,'caterpie',45,30,35,20,20,45,7,7,19,0,50),(313,11,'metapod',50,20,55,25,25,30,7,7,61,0,0),(314,12,'butterfree',60,45,50,90,80,70,7,3,14,0,110),(315,13,'weedle',40,35,30,20,20,50,7,4,19,0,50),(316,14,'kakuna',45,25,50,25,25,35,7,4,61,0,0),(317,15,'beedrill',65,90,40,45,80,75,7,4,68,0,97),(318,16,'pidgey',40,45,40,35,35,56,1,3,51,77,145),(319,17,'pidgeotto',63,60,55,50,50,71,1,3,51,77,145),(320,18,'pidgeot',83,80,75,70,70,101,1,3,51,77,145),(321,19,'rattata',30,56,35,25,35,72,1,1,50,62,55),(322,20,'raticate',55,81,60,50,70,97,1,1,50,62,55),(323,21,'spearow',40,60,30,31,31,70,1,3,51,0,97),(324,22,'fearow',65,90,65,61,61,100,1,3,51,0,97),(325,23,'ekans',35,60,44,40,54,55,4,4,22,61,127),(326,24,'arbok',60,85,69,65,79,80,4,4,22,61,167),(327,25,'pikachu',35,55,40,50,50,90,13,13,9,0,31),(328,26,'raichu',60,90,55,90,80,110,13,13,9,0,31),(329,27,'sandshrew',50,75,85,20,30,40,5,5,8,0,146),(330,28,'sandslash',75,100,110,45,55,65,5,5,8,0,146),(331,29,'nidoran-f',55,47,52,40,40,41,4,4,38,79,55),(332,30,'nidorina',70,62,67,55,55,56,4,4,38,79,55),(333,31,'nidoqueen',90,92,87,75,85,76,4,5,38,79,125),(334,32,'nidoran-m',46,57,40,40,40,50,4,4,38,79,55),(335,33,'nidorino',61,72,57,55,55,65,4,4,38,79,55),(336,34,'nidoking',81,102,77,85,75,85,4,5,38,79,125),(337,35,'clefairy',70,45,48,60,65,35,18,18,56,98,132),(338,36,'clefable',95,70,73,95,90,60,18,18,56,98,132),(339,37,'vulpix',38,41,40,50,65,65,10,10,18,0,70),(340,38,'ninetales',73,76,75,81,100,100,10,10,18,0,70),(341,39,'jigglypuff',115,45,20,45,25,20,1,18,56,172,132),(342,40,'wigglytuff',140,70,45,85,50,45,1,18,56,172,119),(343,41,'zubat',40,45,35,30,40,55,4,3,39,0,151),(344,42,'golbat',75,80,70,65,75,90,4,3,39,0,151),(345,43,'oddish',45,50,55,75,65,30,12,4,34,0,50),(346,44,'gloom',60,65,70,85,75,40,12,4,34,0,1),(347,45,'vileplume',75,80,85,110,90,50,12,4,34,0,27),(348,46,'paras',35,70,55,45,55,25,7,12,27,87,6),(349,47,'parasect',60,95,80,60,80,30,7,12,27,87,6),(350,48,'venonat',60,55,50,40,55,45,7,4,14,110,50),(351,49,'venomoth',70,65,60,90,75,90,7,4,19,110,147),(352,50,'diglett',10,55,25,35,45,95,5,5,8,71,159),(353,51,'dugtrio',35,80,50,50,70,120,5,5,8,71,159),(354,52,'meowth',40,45,35,40,40,90,1,1,53,101,127),(355,53,'persian',65,70,60,65,65,115,1,1,7,101,127),(356,54,'psyduck',50,52,48,65,50,55,11,11,6,13,33),(357,55,'golduck',80,82,78,95,80,85,11,11,6,13,33),(358,56,'mankey',40,80,35,35,45,70,2,2,72,83,128),(359,57,'primeape',65,105,60,60,70,95,2,2,72,83,128),(360,58,'growlithe',55,70,45,70,50,60,10,10,22,18,154),(361,59,'arcanine',90,110,80,100,80,95,10,10,22,18,154),(362,60,'poliwag',40,50,40,40,40,90,11,11,11,6,33),(363,61,'poliwhirl',65,65,65,50,50,90,11,11,11,6,33),(364,62,'poliwrath',90,95,95,70,90,70,11,2,11,6,33),(365,63,'abra',25,20,15,105,55,90,14,14,28,39,98),(366,64,'kadabra',40,35,30,120,70,105,14,14,28,39,98),(367,65,'alakazam',55,50,45,135,95,120,14,14,28,39,98),(368,66,'machop',70,80,50,35,35,35,2,2,62,99,80),(369,67,'machoke',80,100,70,50,60,45,2,2,62,99,80),(370,68,'machamp',90,130,80,65,85,55,2,2,62,99,80),(371,69,'bellsprout',50,75,35,70,30,40,12,4,34,0,82),(372,70,'weepinbell',65,90,50,85,45,55,12,4,34,0,82),(373,71,'victreebel',80,105,65,100,70,70,12,4,34,0,82),(374,72,'tentacool',40,40,35,50,100,70,11,4,29,64,44),(375,73,'tentacruel',80,70,65,80,120,100,11,4,29,64,44),(376,74,'geodude',40,80,100,30,30,20,6,5,69,5,8),(377,75,'graveler',55,95,115,45,45,35,6,5,69,5,8),(378,76,'golem',80,120,130,55,65,45,6,5,69,5,8),(379,77,'ponyta',50,85,55,65,65,90,10,10,50,18,49),(380,78,'rapidash',65,100,70,80,80,105,10,10,50,18,49),(381,79,'slowpoke',90,65,65,40,40,15,11,14,12,20,144),(382,80,'slowbro',95,75,110,100,80,30,11,14,12,20,144),(383,81,'magnemite',25,35,70,95,55,45,13,9,42,5,148),(384,82,'magneton',50,60,95,120,70,70,13,9,42,5,148),(385,83,'farfetchd',52,65,55,58,62,60,1,3,51,39,128),(386,84,'doduo',35,85,45,35,35,75,1,3,50,48,77),(387,85,'dodrio',60,110,70,60,60,100,1,3,50,48,77),(388,86,'seel',65,45,55,45,70,45,11,11,47,93,115),(389,87,'dewgong',90,70,80,70,95,70,11,15,47,93,115),(390,88,'grimer',80,80,50,40,50,25,4,4,1,60,143),(391,89,'muk',105,105,75,65,100,50,4,4,1,60,143),(392,90,'shellder',30,65,100,45,25,40,11,11,75,92,142),(393,91,'cloyster',50,95,180,85,45,70,11,15,75,92,142),(394,92,'gastly',30,35,30,100,35,80,8,4,26,0,0),(395,93,'haunter',45,50,45,115,55,95,8,4,26,0,0),(396,94,'gengar',60,65,60,130,75,110,8,4,26,0,0),(397,95,'onix',35,45,160,30,45,70,6,5,69,5,133),(398,96,'drowzee',60,48,45,43,90,42,14,14,15,108,39),(399,97,'hypno',85,73,70,73,115,67,14,14,15,108,39),(400,98,'krabby',30,105,90,25,25,50,11,11,52,75,125),(401,99,'kingler',55,130,115,50,50,75,11,11,52,75,125),(402,100,'voltorb',40,30,50,55,55,100,13,13,43,9,106),(403,101,'electrode',60,50,70,80,80,140,13,13,43,9,106),(404,102,'exeggcute',60,40,80,60,45,40,12,14,34,0,139),(405,103,'exeggutor',95,95,85,125,65,55,12,14,34,0,139),(406,104,'cubone',50,50,95,40,50,35,5,5,69,31,4),(407,105,'marowak',60,80,110,50,80,45,5,5,69,31,4),(408,106,'hitmonlee',50,120,53,35,110,87,2,2,7,120,84),(409,107,'hitmonchan',50,105,79,35,110,76,2,2,51,89,39),(410,108,'lickitung',90,55,75,60,75,30,1,1,20,12,13),(411,109,'koffing',40,65,95,60,45,35,4,4,26,0,0),(412,110,'weezing',65,90,120,85,70,60,4,4,26,0,0),(413,111,'rhyhorn',80,85,95,30,30,25,5,6,31,69,120),(414,112,'rhydon',105,130,120,45,45,40,5,6,31,69,120),(415,113,'chansey',250,5,5,35,105,50,1,1,30,32,131),(416,114,'tangela',65,55,115,100,40,60,12,12,34,102,144),(417,115,'kangaskhan',105,95,80,40,80,90,1,1,48,113,39),(418,116,'horsea',30,40,70,70,25,60,11,11,33,97,6),(419,117,'seadra',55,65,95,95,45,85,11,11,38,97,6),(420,118,'goldeen',45,67,60,35,50,63,11,11,33,41,31),(421,119,'seaking',80,92,65,65,80,68,11,11,33,41,31),(422,120,'staryu',30,45,55,70,55,85,11,11,35,30,148),(423,121,'starmie',60,75,85,100,85,115,11,14,35,30,148),(424,122,'mr-mime',40,45,65,100,120,90,14,18,43,111,101),(425,123,'scyther',70,110,80,55,80,105,7,3,68,101,80),(426,124,'jynx',65,50,35,115,95,95,15,14,12,108,87),(427,125,'electabuzz',65,83,57,95,85,105,13,13,9,0,72),(428,126,'magmar',65,95,57,100,85,93,10,10,49,0,72),(429,127,'pinsir',65,125,100,55,70,85,7,7,52,104,153),(430,128,'tauros',75,100,95,40,70,110,1,1,22,83,125),(431,129,'magikarp',20,10,55,15,20,80,11,11,33,0,155),(432,130,'gyarados',95,125,79,60,100,81,11,3,22,0,153),(433,131,'lapras',130,85,80,85,95,60,11,15,11,75,93),(434,132,'ditto',48,48,48,48,48,48,1,1,7,0,150),(435,133,'eevee',55,55,50,45,65,55,1,1,50,91,107),(436,134,'vaporeon',130,65,60,110,95,65,11,11,11,0,93),(437,135,'jolteon',65,65,60,110,95,130,13,13,10,0,95),(438,136,'flareon',65,130,60,95,110,65,10,10,18,0,62),(439,137,'porygon',65,60,70,85,75,40,1,1,36,88,148),(440,138,'omanyte',35,40,100,90,55,35,6,11,33,75,133),(441,139,'omastar',70,60,125,115,70,55,6,11,33,75,133),(442,140,'kabuto',30,80,90,55,45,55,6,11,33,4,133),(443,141,'kabutops',60,115,105,65,70,80,6,11,33,4,133),(444,142,'aerodactyl',80,105,65,60,75,130,6,3,69,46,127),(445,143,'snorlax',160,110,65,65,110,30,1,1,17,47,82),(446,144,'articuno',90,85,100,95,125,85,15,3,46,0,81),(447,145,'zapdos',90,90,85,125,90,100,13,3,46,0,9),(448,146,'moltres',90,100,90,125,85,90,10,3,46,0,49),(449,147,'dratini',41,64,45,50,50,50,16,16,61,0,63),(450,148,'dragonair',61,84,65,70,70,70,16,16,61,0,63),(451,149,'dragonite',91,134,95,100,100,80,16,3,39,0,136),(452,150,'mewtwo',106,110,90,154,90,130,14,14,46,0,127),(453,151,'mew',100,100,100,100,100,100,14,14,28,0,0);
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

-- Dump completed on 2015-11-06 11:47:25
