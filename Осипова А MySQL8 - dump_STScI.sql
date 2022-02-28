-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: STScI_Catalog
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `catalogs`
--

DROP TABLE IF EXISTS `catalogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catalogs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `main_id` int unsigned NOT NULL COMMENT 'Ссылка на главный каталог',
  `release_id` int unsigned DEFAULT NULL COMMENT 'версия каталога',
  `name` varchar(100) NOT NULL COMMENT 'Имя каталога',
  `magnitude_type` varchar(100) DEFAULT NULL COMMENT 'Тип величины',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `catalogs_main_id_fk` (`main_id`),
  KEY `catalogs_release_id_fk` (`release_id`),
  CONSTRAINT `catalogs_main_id_fk` FOREIGN KEY (`main_id`) REFERENCES `main_catalog` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `catalogs_release_id_fk` FOREIGN KEY (`release_id`) REFERENCES `release_catalog` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogs`
--

LOCK TABLES `catalogs` WRITE;
/*!40000 ALTER TABLE `catalogs` DISABLE KEYS */;
INSERT INTO `catalogs` VALUES (1,1,1,'mean object','','2022-02-28 15:36:51','2022-02-28 15:36:51'),(2,1,1,'stacked object','','2022-02-28 15:36:51','2022-02-28 15:36:51'),(3,1,2,'mean object','','2022-02-28 15:36:51','2022-02-28 15:36:51'),(4,1,2,'stacked object','','2022-02-28 15:36:51','2022-02-28 15:36:51'),(5,1,2,'forced mean object','','2022-02-28 15:36:51','2022-02-28 15:36:51'),(6,1,2,'detections','','2022-02-28 15:36:51','2022-02-28 15:36:51'),(7,2,3,'summary','magaper2','2022-02-28 15:36:51','2022-02-28 15:36:51'),(8,2,3,'summary','magauto','2022-02-28 15:36:51','2022-02-28 15:36:51'),(9,2,3,'detailed','','2022-02-28 15:36:51','2022-02-28 15:36:51'),(10,2,4,'summary','magaper2','2022-02-28 15:36:51','2022-02-28 15:36:51'),(11,2,4,'summary','magauto','2022-02-28 15:36:51','2022-02-28 15:36:51'),(12,2,4,'detailed','','2022-02-28 15:36:51','2022-02-28 15:36:51'),(13,2,4,'hcv summary','','2022-02-28 15:36:51','2022-02-28 15:36:51'),(14,2,4,'hcv detailed','','2022-02-28 15:36:51','2022-02-28 15:36:51'),(15,3,NULL,'nexsci','','2022-02-28 15:36:51','2022-02-28 15:36:51'),(16,3,NULL,'exoplanets.org','','2022-02-28 15:36:51','2022-02-28 15:36:51'),(17,3,NULL,'toi','','2022-02-28 15:36:51','2022-02-28 15:36:51');
/*!40000 ALTER TABLE `catalogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `full_name_catalog`
--

DROP TABLE IF EXISTS `full_name_catalog`;
/*!50001 DROP VIEW IF EXISTS `full_name_catalog`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `full_name_catalog` (
  `id` tinyint NOT NULL,
  `main` tinyint NOT NULL,
  `releases` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `is there in my project?` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `hsc_v3hcvdetailed`
--

DROP TABLE IF EXISTS `hsc_v3hcvdetailed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hsc_v3hcvdetailed` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `match_id` bigint NOT NULL COMMENT 'Идентификатор для совпадения. Он соединяется с идентификатором соответствия, используемым в таблицах HSC',
  `filter_` varchar(100) DEFAULT NULL COMMENT 'Имя фильтра с префиксом имени инструмента',
  `mjd` float DEFAULT NULL COMMENT 'Измененная юлианская дата в середине наблюдения',
  `image_id` int unsigned NOT NULL COMMENT 'Идентификатор изображения',
  `corr_mag` float DEFAULT NULL COMMENT 'Величина, скорректированная с помощью HCV (такая же, как Mag, если коррекция невозможна)',
  `mag_err` float DEFAULT NULL COMMENT 'Погрешность величины',
  `d` float DEFAULT NULL COMMENT 'Смещение расстояния источника от позиции совпадения(милли аркстрем)',
  `catalog_id` int unsigned NOT NULL COMMENT 'Идентификатор каталога',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `v3hcvdetailed_catalog_id_fk` (`catalog_id`),
  KEY `hsc_v3hcvdetailed_image_id_fk` (`image_id`),
  KEY `hsc_v3hcvdetailed_match_id_filter_idx` (`match_id`,`filter_`),
  CONSTRAINT `hsc_v3hcvdetailed_image_id_fk` FOREIGN KEY (`image_id`) REFERENCES `image` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `v3hcvdetailed_catalog_id_fk` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hsc_v3hcvdetailed`
--

LOCK TABLES `hsc_v3hcvdetailed` WRITE;
/*!40000 ALTER TABLE `hsc_v3hcvdetailed` DISABLE KEYS */;
INSERT INTO `hsc_v3hcvdetailed` VALUES (1,69245948,'WFC3_F467M',56550.6,1,20.4526,0.0124,3.64172,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(2,69245948,'WFC3_F467M',56550.7,3,20.5003,0.0121,4.27947,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(3,69245948,'WFC3_F775W',56209.2,6,18.8315,0.0228,1.17703,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(4,69245948,'WFC3_F775W',56209.2,7,18.8271,0.0221,0.282391,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(5,17207942,'WFC3_F467M',56550.5,2,18.9577,0.0045,3.76262,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(6,17207942,'WFC3_F467M',56550.6,1,18.954,0.0045,4.52083,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(7,17207942,'WFC3_F467M',56550.7,3,18.9764,0.0049,5.02555,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(8,17207942,'WFC3_F775W',56209,5,17.7023,0.0129,2.21113,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(9,17207942,'WFC3_F775W',56209.2,6,17.7069,0.0128,0.559993,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(10,17207942,'WFC3_F775W',56209.3,8,17.6886,0.013,1.34029,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(11,18834572,'WFC3_F467M',56550.6,1,19.7371,0.0072,3.41141,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(12,18834572,'WFC3_F467M',56550.7,3,19.676,0.0075,4.71203,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(13,18834572,'WFC3_F775W',56209,5,18.3021,0.0171,1.66734,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(14,18834572,'WFC3_F775W',56209.2,6,18.2783,0.0168,1.41407,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(15,92485645,'WFC3_F467M',56550.6,1,16.9077,0.0016,3.106,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(16,92485645,'WFC3_F467M',56550.7,3,16.907,0.0016,3.57891,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(17,92485645,'WFC3_F467M',56551.3,4,16.9025,0.0021,0.997994,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(18,92485645,'WFC3_F775W',56209,5,15.7768,0.0052,1.85535,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(19,92485645,'WFC3_F775W',56209.2,6,15.7772,0.0052,1.52162,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(20,92485645,'WFC3_F775W',56209.2,7,15.7865,0.0052,0.348885,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(21,78413471,'WFC3_F467M',56311.3,8,19.0722,0.005,1.22428,14,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(22,78413471,'WFC3_F467M',56311.5,4,19.079,0.0047,1.04187,14,'2022-02-28 15:37:54','2022-02-28 15:37:54');
/*!40000 ALTER TABLE `hsc_v3hcvdetailed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hsc_v3hcvsummary`
--

DROP TABLE IF EXISTS `hsc_v3hcvsummary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hsc_v3hcvsummary` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `match_id` bigint NOT NULL COMMENT 'Идентификатор для совпадения. Он соединяется с идентификатором соответствия, используемым в таблицах HSC',
  `filter_` varchar(100) NOT NULL COMMENT 'Имя фильтра с префиксом имени инструмента',
  `group_id` bigint DEFAULT NULL COMMENT 'Идентификатор для группы изображений. Он соединяется с идентификатором группы, используемым в таблицах HSC, таких как Изображения',
  `ra` float DEFAULT '-999' COMMENT 'Прямое восхождение (градусы)',
  `dec_` float DEFAULT '-999' COMMENT 'Склонение (градусы)',
  `mean_mag` float DEFAULT NULL COMMENT 'Средняя величина, определяемая HSC',
  `mean_corr_mag` int DEFAULT NULL COMMENT 'Средняя величина, скорректированная с помощью HCV (такая же, как mean_mag, если коррекция невозможна)',
  `mad` float DEFAULT NULL COMMENT 'Среднее абсолютное отклонение величин',
  `catalog_id` int unsigned NOT NULL COMMENT 'Идентификатор каталога',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`match_id`,`filter_`),
  UNIQUE KEY `id` (`id`),
  KEY `v3hcvsummary_catalog_id_fk` (`catalog_id`),
  KEY `hsc_v3hcvsummary_ra_idx` (`ra`),
  KEY `hsc_v3hcvsummary_dec__idx` (`dec_`),
  CONSTRAINT `v3hcvsummary_catalog_id_fk` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `v3hcvsummary_match_id_fk` FOREIGN KEY (`match_id`, `filter_`) REFERENCES `hsc_v3hcvdetailed` (`match_id`, `filter_`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hsc_v3hcvsummary`
--

LOCK TABLES `hsc_v3hcvsummary` WRITE;
/*!40000 ALTER TABLE `hsc_v3hcvsummary` DISABLE KEYS */;
INSERT INTO `hsc_v3hcvsummary` VALUES (3,17207942,'WFC3_F467M',33675,245.896,-26.5361,18.9517,19,0.0149433,13,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(4,17207942,'WFC3_F775W',33675,245.896,-26.5361,17.6986,18,0.0102522,13,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(5,18834572,'WFC3_F467M',33675,245.885,-26.5368,19.6832,20,0.0113565,13,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(6,18834572,'WFC3_F775W',33675,245.885,-26.5368,18.289,18,0.0108322,13,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(1,69245948,'WFC3_F467M',33675,245.882,-26.5341,20.4469,20,0.0110232,13,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(2,69245948,'WFC3_F775W',33675,245.882,-26.5341,18.8462,19,0.0177226,13,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(7,92485645,'WFC3_F467M',33675,245.884,-26.535,16.9121,17,0.0143791,13,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(8,92485645,'WFC3_F775W',33675,245.884,-26.535,15.7924,16,0.00681028,13,'2022-02-28 15:37:54','2022-02-28 15:37:54');
/*!40000 ALTER TABLE `hsc_v3hcvsummary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `image_name` varchar(100) NOT NULL COMMENT 'Именя файла с фотографией',
  `link` varchar(500) DEFAULT NULL COMMENT 'Ссылка на фото',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `image_image_name_idx` (`image_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (1,'hst_12911_0i_wfc3_uvis_f467M','https://v-kosmose.com/wp-content/uploads/2014/04/NGC-6121.jpg','2022-02-28 15:37:24','2022-02-28 15:37:24'),(2,'hst_12911_0h_wfc3_uvis_f467M','https://v-kosmose.com/wp-content/uploads/2014/04/NGC-6121.jpg','2022-02-28 15:37:24','2022-02-28 15:37:24'),(3,'hst_12911_0j_wfc3_uvis_f467M','https://v-kosmose.com/wp-content/uploads/2014/04/NGC-6121.jpg','2022-02-28 15:37:24','2022-02-28 15:37:24'),(4,'hst_12911_0k_wfc3_uvis_f467M','https://v-kosmose.com/wp-content/uploads/2014/04/Messier-4.jpg','2022-02-28 15:37:24','2022-02-28 15:37:24'),(5,'hst_12911_0l_wfc3_uvis_f775W','','2022-02-28 15:37:24','2022-02-28 15:37:24'),(6,'hst_12911_0m_wfc3_uvis_f775W','https://ps1images.stsci.edu/cgi-bin/fitscut.cgi?red=/rings.v3.skycell/0770/034/rings.v3.skycell.0770.034.stk.y.unconv.fits&blue=/rings.v3.skycell/0770/034/rings.v3.skycell.0770.034.stk.g.unconv.fits&green=/rings.v3.skycell/0770/034/rings.v3.skycell.0770.034.stk.i.unconv.fits&x=245.897510&y=-26.525520&size=240&wcs=1&asinh=True&autoscale=99.750000','2022-02-28 15:37:24','2022-02-28 15:37:24'),(7,'hst_12911_0n_wfc3_uvis_f775W','https://ps1images.stsci.edu/cgi-bin/fitscut.cgi?red=/rings.v3.skycell/0770/034/rings.v3.skycell.0770.034.stk.g.unconv.fits&x=245.897510&y=-26.525520&size=240&wcs=1&asinh=True&autoscale=99.500000','2022-02-28 15:37:24','2022-02-28 15:37:24'),(8,'hst_12911_0o_wfc3_uvis_f775W','https://v-kosmose.com/wp-content/uploads/2014/04/Pulsar-B1620-26.jpg','2022-02-28 15:37:24','2022-02-28 15:37:24');
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_catalog`
--

DROP TABLE IF EXISTS `main_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_catalog` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(100) NOT NULL COMMENT 'Имя каталога',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_catalog`
--

LOCK TABLES `main_catalog` WRITE;
/*!40000 ALTER TABLE `main_catalog` DISABLE KEYS */;
INSERT INTO `main_catalog` VALUES (1,'Pan-STARRS','2022-02-28 15:36:38','2022-02-28 15:36:38'),(2,'Hubble Source Catalog','2022-02-28 15:36:38','2022-02-28 15:36:38'),(3,'Exoplanet Atmosphere Observability Table','2022-02-28 15:36:38','2022-02-28 15:36:38');
/*!40000 ALTER TABLE `main_catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexsci`
--

DROP TABLE IF EXISTS `nexsci`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nexsci` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `planet_name` varchar(100) NOT NULL COMMENT 'Имя Планеты',
  `Rp` float DEFAULT NULL COMMENT 'Радиус планеты (в радиусах Юпитера)',
  `Mp` float DEFAULT NULL COMMENT 'Масса планеты (в массах Юпитера)',
  `Tday` float DEFAULT NULL COMMENT 'Температура на освещенной стороне (Кельвин)',
  `Teq` float DEFAULT NULL COMMENT 'Равновесная тампература планеты (Кельвин)',
  `log_gp` float DEFAULT NULL COMMENT 'Поверхностная гравитация планеты',
  `period` float DEFAULT NULL COMMENT 'Орбитальный период (день)',
  `transit_duration` float DEFAULT NULL COMMENT 'Продолжительность прохождения планеты перед звездой хозяином (час)',
  `distance` float DEFAULT NULL COMMENT 'Расстояние от планеты до звезды хозяина (парсек)',
  `Teff` float DEFAULT NULL COMMENT 'Эффективная температура звезды (Кельвин)',
  `log_gs` float DEFAULT NULL COMMENT 'Поверхностная гравитация звезды',
  `transit_flag` tinyint(1) DEFAULT NULL COMMENT 'Транзитная планета = True',
  `catalog_id` int unsigned NOT NULL COMMENT 'Идентификатор каталога',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `nexsci_catalog_id_fk` (`catalog_id`),
  KEY `nexsci_planet_name_idx` (`planet_name`),
  KEY `nexsci_Rp_idx` (`Rp`),
  KEY `nexsci_Mp_idx` (`Mp`),
  CONSTRAINT `nexsci_catalog_id_fk` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexsci`
--

LOCK TABLES `nexsci` WRITE;
/*!40000 ALTER TABLE `nexsci` DISABLE KEYS */;
INSERT INTO `nexsci` VALUES (1,'OGLE-2018-BLG-1700L b',1.15,4.4,NULL,NULL,3.916,NULL,NULL,7600,NULL,NULL,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(2,'Kepler-1697 b',0.11,0.00668,526,442,3.121,33.4969,4.111,247.77,4682,4.54,1,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(3,'KMT-2018-BLG-1996L b',1.23,1.09,NULL,NULL,3.252,NULL,NULL,5910,NULL,NULL,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(4,'OGLE-2018-BLG-1428L b',1.25,0.77,NULL,NULL,3.087,NULL,NULL,6220,NULL,NULL,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(5,'2MASS J12073346-3932539 b',1.15,5,10,9,3.972,NULL,NULL,64.31,2825,5.03,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(6,'42 Dra b',1.16,3.88,1036,871,3.854,479.1,NULL,90.65,4200,1.71,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(7,'4 UMa b',1.13,7.1,1155,971,4.139,269.3,NULL,73.46,4415,1.8,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(8,'alf Ari b',1.2,1.8,889,747,3.491,380.8,NULL,20.21,4553,2.49,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(9,'CoRoT-10 b',0.97,2.75,796,670,3.86,13.2406,2.98,338.39,5075,4.65,1,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(10,'CoRoT-14 b',1.09,7.6,2317,1948,4.2,1.5121,1.662,1744.6,6035,4.35,1,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(11,'DH Tau b',2.7,11,7,6,3.573,NULL,NULL,134.85,4371,4,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(12,'gam 1 Leo b',1.12,8.78,1285,1081,4.239,428.5,NULL,39.89,4330,1.66,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(13,'GJ 667 C g',0.18,0.014,NULL,NULL,3.044,256.2,NULL,7.24,3350,4.69,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(14,'HD 106515 A b',1.11,9.61,183,154,4.286,3630,NULL,34.09,5362,4.41,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(15,'11 Com b',1.08,19.4,1044,878,4.615,326.03,NULL,93.18,4742,2.31,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(16,'11 UMi b',1.09,14.74,1066,896,4.488,516.22,NULL,125.32,4213,1.93,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(17,'2MASS J01225093-2439505 b',1,24.5,17,14,4.783,NULL,NULL,33.83,3530,4.86,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(18,'14 And b',1.15,4.8,1005,845,3.954,185.84,NULL,75.44,4813,2.63,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(19,'14 Her b',1.15,4.66,172,145,3.941,1773.4,NULL,17.93,5338,4.45,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(20,'2MASS J04414489+2301513 b',1.13,7.5,21,18,4.163,NULL,NULL,120.42,2936,5.01,0,15,'2022-02-28 15:37:54','2022-02-28 15:37:54');
/*!40000 ALTER TABLE `nexsci` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `obj_image_hubble`
--

DROP TABLE IF EXISTS `obj_image_hubble`;
/*!50001 DROP VIEW IF EXISTS `obj_image_hubble`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `obj_image_hubble` (
  `name_obj` tinyint NOT NULL,
  `ra` tinyint NOT NULL,
  `dec_` tinyint NOT NULL,
  `match_id` tinyint NOT NULL,
  `filter_` tinyint NOT NULL,
  `link` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `objects`
--

DROP TABLE IF EXISTS `objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objects` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор объекта',
  `name_messier` varchar(100) DEFAULT NULL COMMENT 'Имя объекта в каталоге Мессье',
  `name_ngc` varchar(100) DEFAULT NULL COMMENT 'Имя объекта в Новом общем каталоге',
  `right_ascension` float DEFAULT NULL COMMENT 'прямое восхождение (RA)',
  `declination` float DEFAULT NULL COMMENT 'склонение (Dec)',
  `max_m` float DEFAULT NULL COMMENT 'Видимая звездная величина. Максимальная яркость',
  `min_m` float DEFAULT NULL COMMENT 'Видимая звездная величина. Минимальная яркость',
  `d_pс` float DEFAULT NULL COMMENT 'Расстояние в парсеках',
  `d_ly` float DEFAULT NULL COMMENT 'Расстояние в световых годах',
  `description` varchar(255) DEFAULT NULL COMMENT 'описание',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `objects_name_messier_idx` (`name_messier`),
  KEY `objects_name_ngc_idx` (`name_ngc`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
INSERT INTO `objects` VALUES (1,'M4','NGC 6121',245.898,-26.5255,8.1,NULL,1888.7,6160,'It is a globular star cluster in the constellation Scorpio','2022-02-28 15:37:00','2022-02-28 15:37:00'),(2,'M31','NGC 224',10.6848,41.2691,4.3,NULL,740000,2400000,'The Andromeda Galaxy is a spiral galaxy in the constellation Andromeda','2022-02-28 15:37:00','2022-02-28 15:37:00'),(3,'M42','NGC 1976',83.8187,-5.38968,5,NULL,398.6,1300,'The Orion Nebula is an emission and reflection nebula, as well as a star formation region in the constellation Orion','2022-02-28 15:37:00','2022-02-28 15:37:00'),(4,'M1','NGC 1952',83.6331,22.0145,8.4,NULL,2000,6500,'The Crab Nebula is a supernova remnant and pulsar wind nebula in the constellation of Taurus','2022-02-28 15:37:00','2022-02-28 15:37:00'),(5,'δ Cep','',337.293,58.4152,4.07,7.5,273,891,'It is a double variable star in the constellation Cepheus','2022-02-28 15:37:00','2022-02-28 15:37:00'),(6,'M35','NGC 2168',92.2711,24.3386,5.3,NULL,860,2800,'It is a scattered star cluster in the constellation Gemini','2022-02-28 15:37:00','2022-02-28 15:37:00');
/*!40000 ALTER TABLE `objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ps_dr2detection`
--

DROP TABLE IF EXISTS `ps_dr2detection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_dr2detection` (
  `detect_id` bigint unsigned NOT NULL COMMENT 'Идентификатор обнаружения',
  `obj_id` bigint unsigned NOT NULL COMMENT 'Идентификатор объекта',
  `filter_id` tinyint DEFAULT NULL COMMENT 'Идентификатор фильтра',
  `obs_time` float DEFAULT '-999' COMMENT 'Измененная юлианская дата в середине наблюдения. Это международное атомное время, а не UTC',
  `ra` float DEFAULT '-999' COMMENT 'Прямое восхождение (градусы)',
  `dec_` float DEFAULT '-999' COMMENT 'Склонение (градусы)',
  `psf_major_fwhm` double DEFAULT '-999' COMMENT 'Большая ось PSF FWHM (арксеканс)',
  `psf_minor_fwhm` double DEFAULT '-999' COMMENT 'Малая ось PSF FWHM (арксеканс)',
  `catalog_id` int unsigned NOT NULL COMMENT 'Идентификатор каталога',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`detect_id`),
  KEY `dr2detection_catalog_id_fk` (`catalog_id`),
  KEY `ps_dr2detection_obj_id_idx` (`obj_id`),
  KEY `ps_dr2detection_ra_idx` (`ra`),
  KEY `ps_dr2detection_dec__idx` (`dec_`),
  CONSTRAINT `dr2detection_catalog_id_fk` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_dr2detection`
--

LOCK TABLES `ps_dr2detection` WRITE;
/*!40000 ALTER TABLE `ps_dr2detection` DISABLE KEYS */;
INSERT INTO `ps_dr2detection` VALUES (126234849660000489,76152459006939500,1,55363.3,245.901,-26.5341,1.7752399444580078,1.533619999885559,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160442597530001861,76152458823159609,2,55705.4,245.882,-26.534,1.3934600353240967,1.275480031967163,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160442597530002936,76152458953897453,2,55705.4,245.895,-26.5358,1.4179500341415405,1.283619999885559,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160442597530003154,76152458957087502,2,55705.4,245.896,-26.5358,1.4186099767684937,1.2836600542068481,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160442597530003982,76152458930989683,2,55705.4,245.893,-26.534,1.4170199632644653,1.2817599773406982,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160442597530003997,76152458930601274,2,55705.4,245.893,-26.541,1.3952800035476685,1.2786600589752197,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160444010530003102,76152458957087502,2,55705.4,245.896,-26.5358,1.3523800373077393,1.2172600030899048,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160444010530003155,76152458930989683,2,55705.4,245.893,-26.5339,1.350219964981079,1.2151299715042114,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160444010530003624,76152458953897453,2,55705.4,245.895,-26.5358,1.3522900342941284,1.2176200151443481,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160444010530003898,76152458930601274,2,55705.4,245.893,-26.5409,1.3343700170516968,1.2141000032424927,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160445586530000755,76152458955080528,3,55705.5,245.895,-26.5416,1.0718599557876587,0.92392498254776,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160445586530002186,76152458953897453,3,55705.5,245.895,-26.5358,1.0809600353240967,0.9267449975013733,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160445586530002943,76152458930989683,3,55705.5,245.893,-26.5339,1.0782699584960938,0.9240649938583374,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160445586530003707,76152458930601274,3,55705.5,245.893,-26.5409,1.0682799816131592,0.9215689897537231,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160447140530000773,76152458955080528,3,55705.5,245.895,-26.5416,0.9715290069580078,0.853413999080658,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160447140530001471,76152458951209846,3,55705.5,245.895,-26.5338,0.9795100092887878,0.855318009853363,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(160447140530004212,76152458930601274,3,55705.5,245.893,-26.541,0.9695519804954529,0.8521299958229065,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(161042292130000422,76152459006939500,1,55711.4,245.9,-26.5341,1.439370036125183,1.227220058441162,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(165826141530000796,76152458955080528,5,55759.3,245.895,-26.5416,0.9570350050926208,0.8110489845275879,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(165826141530001130,76152458951209846,5,55759.3,245.895,-26.5339,0.9702569842338562,0.8138139843940735,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(165827883530000785,76152458955080528,5,55759.3,245.895,-26.5416,0.9536839723587036,0.7878249883651733,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(166126121530000288,76152459006939500,4,55762.3,245.901,-26.5341,0.9314709901809692,0.848783016204834,6,'2022-02-28 15:37:54','2022-02-28 15:37:54'),(236935236510002458,76152458877255525,3,56470.4,245.888,-26.5374,1.4048199653625488,1.348960041999817,6,'2022-02-28 15:37:54','2022-02-28 15:37:54');
/*!40000 ALTER TABLE `ps_dr2detection` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_dr2detection` BEFORE INSERT ON `ps_dr2detection` FOR EACH ROW BEGIN
	IF dec_ < -30
	  THEN
      SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Покрытие неба к северу от склонения не должно быть меньше -30 градусов';
    ELSEIF ra > 270 
       THEN
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Прямое восхождение указано неверно';
    ELSEIF obj_id IS NULL OR catalog_id IS NULL
       THEN
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Не заданы имя объекта или имя каталога';
    END IF;                  
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ps_dr2forced_mean`
--

DROP TABLE IF EXISTS `ps_dr2forced_mean`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ps_dr2forced_mean` (
  `id` bigint unsigned NOT NULL COMMENT 'Идентификатор объекта',
  `obj_name` varchar(100) NOT NULL COMMENT 'Имя объекта',
  `n_detections` smallint DEFAULT '-999' COMMENT 'Количество обнаружений одной эпохи во всех фильтрах',
  `gn_total` smallint DEFAULT '-999' COMMENT 'Количество принудительных обнаружений одной эпохи в g-фильтре',
  `gf_psf_flux` double DEFAULT '-999' COMMENT 'Средний поток PSF от принудительных обнаружений фильтра g в одну эпоху',
  `gf_psf_flux_err` double DEFAULT '-999' COMMENT 'Ошибка в среднем потоке PSF из-за принудительных обнаружений фильтра g в одну эпоху',
  `gf_psf_flux_std` double DEFAULT '-999' COMMENT 'Стандартное отклонение потоков PSF от принудительных одноэтапных обнаружений g-фильтра',
  `catalog_id` int unsigned NOT NULL COMMENT 'Идентификатор каталога',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  KEY `dr2forced_catalog_id_fk` (`catalog_id`),
  KEY `dr2forced_mean_obj_name_idx` (`obj_name`),
  CONSTRAINT `dr2forced_catalog_id_fk` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `ps_dr2forced_mean_id_fk` FOREIGN KEY (`id`) REFERENCES `ps_dr2detection` (`obj_id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ps_dr2forced_mean`
--

LOCK TABLES `ps_dr2forced_mean` WRITE;
/*!40000 ALTER TABLE `ps_dr2forced_mean` DISABLE KEYS */;
INSERT INTO `ps_dr2forced_mean` VALUES (76152458823159609,'PSO J245.8822-26.5341',66,16,0.000815014005638659,0.000016702499124221504,246.7480010986328,5,'2022-02-28 15:37:47','2022-02-28 15:37:47'),(76152458877255525,'PSO J245.8876-26.5374',58,16,0.000510525016579777,0.0000026620800781529397,6.377260208129883,5,'2022-02-28 15:37:47','2022-02-28 15:37:47'),(76152458930601274,'PSO J245.8930-26.5410',34,16,0.00036421598633751273,0.0000042143501559621654,10.472599983215332,5,'2022-02-28 15:37:47','2022-02-28 15:37:47'),(76152458930989683,'PSO J245.8930-26.5339',47,16,0.00041156698716804385,0.000014191299669619184,153.42599487304688,5,'2022-02-28 15:37:47','2022-02-28 15:37:47'),(76152458951209846,'PSO J245.8950-26.5339',5,16,0.0007544870022684336,0.000023264299670699984,310.31298828125,5,'2022-02-28 15:37:47','2022-02-28 15:37:47'),(76152458953897453,'PSO J245.8953-26.5358',51,16,0.0004182739940006286,0.00000818799981061602,30.673799514770508,5,'2022-02-28 15:37:47','2022-02-28 15:37:47'),(76152458955080528,'PSO J245.8955-26.5416',21,16,0.0012557599693536758,0.000027087400667369366,309.2929992675781,5,'2022-02-28 15:37:47','2022-02-28 15:37:47'),(76152458957087502,'PSO J245.8956-26.5358',68,16,0.00042599899461492896,0.000018063399693346582,282.6990051269531,5,'2022-02-28 15:37:47','2022-02-28 15:37:47');
/*!40000 ALTER TABLE `ps_dr2forced_mean` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `release_catalog`
--

DROP TABLE IF EXISTS `release_catalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `release_catalog` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(100) NOT NULL COMMENT 'Имя Релиза',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `release_catalog`
--

LOCK TABLES `release_catalog` WRITE;
/*!40000 ALTER TABLE `release_catalog` DISABLE KEYS */;
INSERT INTO `release_catalog` VALUES (1,'PS1 DR1','2022-02-28 15:36:46','2022-02-28 15:36:46'),(2,'PS1 DR2','2022-02-28 15:36:46','2022-02-28 15:36:46'),(3,'V2','2022-02-28 15:36:46','2022-02-28 15:36:46'),(4,'V3','2022-02-28 15:36:46','2022-02-28 15:36:46');
/*!40000 ALTER TABLE `release_catalog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'STScI_Catalog'
--
/*!50003 DROP PROCEDURE IF EXISTS `get_image` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_image`(p_name_messier VARCHAR(100))
BEGIN
SET @var = CONCAT('(SELECT DISTINCT name_obj, link FROM obj_image_hubble WHERE name_obj IN ("',p_name_messier,'"))');
PREPARE zxc FROM @var;
EXECUTE zxc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `full_name_catalog`
--

/*!50001 DROP TABLE IF EXISTS `full_name_catalog`*/;
/*!50001 DROP VIEW IF EXISTS `full_name_catalog`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `full_name_catalog` AS select `c`.`id` AS `id`,`mc`.`name` AS `main`,`rc`.`name` AS `releases`,`c`.`name` AS `name`,(case when (`c`.`id` in (5,6,15,13,14)) then 'yes' else 'no' end) AS `is there in my project?` from ((`catalogs` `c` join `main_catalog` `mc` on((`c`.`main_id` = `mc`.`id`))) left join `release_catalog` `rc` on((`c`.`release_id` = `rc`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `obj_image_hubble`
--

/*!50001 DROP TABLE IF EXISTS `obj_image_hubble`*/;
/*!50001 DROP VIEW IF EXISTS `obj_image_hubble`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `obj_image_hubble` AS select distinct (select `o`.`name_messier` from `objects` `o` where (((`o`.`right_ascension` - 1) < `v3sum`.`ra`) and (`v3sum`.`ra` < (`o`.`right_ascension` + 1)) and ((`o`.`declination` - 1) < `v3sum`.`dec_`) and (`v3sum`.`dec_` < (`o`.`declination` + 1)))) AS `name_obj`,`v3sum`.`ra` AS `ra`,`v3sum`.`dec_` AS `dec_`,coalesce(`v3sum`.`match_id`,`v3det`.`match_id`) AS `match_id`,coalesce(`v3sum`.`filter_`,`v3det`.`filter_`) AS `filter_`,`i`.`link` AS `link` from ((`hsc_v3hcvdetailed` `v3det` left join `hsc_v3hcvsummary` `v3sum` on(((`v3sum`.`match_id` = `v3det`.`match_id`) and (`v3sum`.`filter_` = `v3det`.`filter_`)))) join `image` `i` on((`v3det`.`image_id` = `i`.`id`))) where (`i`.`link` <> '') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-28 17:44:04
