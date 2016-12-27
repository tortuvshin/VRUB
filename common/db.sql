-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 14, 2016 at 06:39 AM
-- Server version: 5.7.9
-- PHP Version: 5.6.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `taracode`
--

-- --------------------------------------------------------

--
-- Table structure for table `pm_activity`
--

DROP TABLE IF EXISTS `pm_activity`;
CREATE TABLE IF NOT EXISTS `pm_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `hotels` varchar(250) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `max_children` int(11) DEFAULT '1',
  `max_adults` int(11) DEFAULT '1',
  `max_people` int(11) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `subtitle` varchar(250) DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `descr` longtext,
  `duration` float DEFAULT '0',
  `duration_unit` varchar(50) DEFAULT NULL,
  `price` double DEFAULT '0',
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '0',
  `rank` int(11) DEFAULT '0',
  PRIMARY KEY (`id`,`lang`),
  KEY `activity_lang_fkey` (`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_activity`
--

INSERT INTO `pm_activity` (`id`, `lang`, `hotels`, `id_user`, `max_children`, `max_adults`, `max_people`, `title`, `subtitle`, `alias`, `descr`, `duration`, `duration_unit`, `price`, `lat`, `lng`, `home`, `checked`, `rank`) VALUES
(1, 1, '3', 1, 2, 3, 5, 'Demo', '', 'demo', '<p>Demo</p>\r\n', 10, 'hour(s)', 100, 100.1, 100.1, 1, 1, 1),
(1, 2, '3', 1, 2, 3, 5, '', '', '', '', 10, 'hour(s)', 100, 100.1, 100.1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pm_activity_file`
--

DROP TABLE IF EXISTS `pm_activity_file`;
CREATE TABLE IF NOT EXISTS `pm_activity_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '1',
  `rank` int(11) DEFAULT '0',
  `file` varchar(250) DEFAULT NULL,
  `label` varchar(250) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`lang`),
  KEY `activity_file_fkey` (`id_item`,`lang`),
  KEY `activity_file_lang_fkey` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pm_activity_session`
--

DROP TABLE IF EXISTS `pm_activity_session`;
CREATE TABLE IF NOT EXISTS `pm_activity_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_activity` int(11) NOT NULL,
  `days` varchar(20) DEFAULT NULL,
  `start_date` int(11) DEFAULT NULL,
  `end_date` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `price` double DEFAULT '0',
  `price_child` double DEFAULT '0',
  `discount` double DEFAULT '0',
  `vat_rate` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_session_fkey` (`id_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pm_activity_session_hour`
--

DROP TABLE IF EXISTS `pm_activity_session_hour`;
CREATE TABLE IF NOT EXISTS `pm_activity_session_hour` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_activity_session` int(11) NOT NULL,
  `start_h` int(11) DEFAULT NULL,
  `start_m` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_session_hour_fkey` (`id_activity_session`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pm_article`
--

DROP TABLE IF EXISTS `pm_article`;
CREATE TABLE IF NOT EXISTS `pm_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `title` varchar(250) DEFAULT NULL,
  `subtitle` varchar(250) DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `text` longtext,
  `url` varchar(250) DEFAULT NULL,
  `tags` varchar(250) DEFAULT NULL,
  `id_page` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '0',
  `rank` int(11) DEFAULT '0',
  `add_date` int(11) DEFAULT NULL,
  `edit_date` int(11) DEFAULT NULL,
  `publish_date` int(11) DEFAULT NULL,
  `unpublish_date` int(11) DEFAULT NULL,
  `comment` int(11) DEFAULT '0',
  `rating` int(11) DEFAULT '0',
  PRIMARY KEY (`id`,`lang`),
  KEY `article_lang_fkey` (`lang`),
  KEY `article_page_fkey` (`id_page`,`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_article`
--

INSERT INTO `pm_article` (`id`, `lang`, `title`, `subtitle`, `alias`, `text`, `url`, `tags`, `id_page`, `id_user`, `home`, `checked`, `rank`, `add_date`, `edit_date`, `publish_date`, `unpublish_date`, `comment`, `rating`) VALUES
(1, 1, 'Манай зочид буудал', '', 'plongee', '<p>Манай зочид буудал нь 3 одны зэрэглэлтэй ба энгийн болон хагас люкс, люкс 180 өрөөнд 330 хүн хүлээн авах хүчин чадалтай. Хотын төвд хэрнээ дуу чимээнээс алс, өндөрлөг хэсэгт мод бутаар хүрээлүүлэн, намуухан орчинд байрлах манай буудлаас Улаанбаатар хот болон үзэсгэлэнт Богд уул, хүрээлэн буй орчин сэтгэл татам харагддаг нь бидний нэг давуу тал юм. Буудлаас та ихэнх шаардлагатай газар руугаа зорчиход тун тохиромжтой: Тухайлбал замын ачаалал бага үед Чингис Хаан Олон Улсын нисэх буудал машинаар ердөө л 20 минут, Төмөр замын буудал аравхан  минут л явах бөгөөд хотын төв хэсэг Сүхбаатарын талбай, бизнес, худалдааны төвүүд, театр, музей, галларейнүүд ердөө л 20минут алхах зайд байрлалтай.</p>\r\n', '', '', 5, 1, 1, 1, 1, 1478177832, 1478291164, NULL, NULL, 1, 0),
(1, 2, 'Dive into unknown waters!', '', 'scuba-diving', '<p>Lorem ipsum dolor sit amet consectetur adipiscing elit. Nullam molestie, nunc eu consequat varius, nisi metus iaculis nulla, nec ornare odio leo quis eros. Donec gravida eget velit eget pulvinar. Phasellus eget est quis est faucibus condimentum. Morbi tellus turpis, posuere vel tincidunt non, varius ac ante. Suspendisse in sem neque. Donec et faucibus justo. Nulla vitae nisl lacus. Fusce tincidunt quam nec vestibulum vestibulum. Vivamus vulputate, nunc non ullamcorper mattis, nunc orci imperdiet nulla, at laoreet ipsum nisl non leo. Aenean dapibus aliquet sem, ut lacinia magna mattis in.</p>\r\n\r\n<p>Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempor arcu eu sapien ullamcorper sodales. Aenean eu massa in ante commodo scelerisque vitae sed sapien. Aenean eu dictum arcu. Mauris ultricies dolor eu molestie egestas.<br />\r\nProin feugiat, nunc at pellentesque fringilla, ex purus efficitur dolor, ac pretium odio lacus id leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse eu ipsum viverra dolor tempus vehicula eu eu risus. Praesent rutrum dapibus odio, nec accumsan justo fermentum in. Ut quis neque a ante facilisis bibendum.</p>\r\n', '', '', 5, 1, 1, 1, 1, 1478177832, 1478291164, NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `pm_article_file`
--

DROP TABLE IF EXISTS `pm_article_file`;
CREATE TABLE IF NOT EXISTS `pm_article_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '1',
  `rank` int(11) DEFAULT '0',
  `file` varchar(250) DEFAULT NULL,
  `label` varchar(250) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`lang`),
  KEY `article_file_fkey` (`id_item`,`lang`),
  KEY `article_file_lang_fkey` (`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_article_file`
--

INSERT INTO `pm_article_file` (`id`, `lang`, `id_item`, `home`, `checked`, `rank`, `file`, `label`, `type`) VALUES
(6, 1, 1, NULL, 1, 5, '4.jpg', NULL, 'image'),
(6, 2, 1, NULL, 1, 5, '4.jpg', NULL, 'image');

-- --------------------------------------------------------

--
-- Table structure for table `pm_booking`
--

DROP TABLE IF EXISTS `pm_booking`;
CREATE TABLE IF NOT EXISTS `pm_booking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_room` int(11) NOT NULL,
  `room` varchar(100) DEFAULT NULL,
  `add_date` int(11) DEFAULT NULL,
  `edit_date` int(11) DEFAULT NULL,
  `from_date` int(11) DEFAULT NULL,
  `to_date` int(11) DEFAULT NULL,
  `nights` int(11) DEFAULT '1',
  `adults` int(11) DEFAULT '1',
  `children` int(11) DEFAULT '1',
  `amount` float DEFAULT NULL,
  `tourist_tax` float DEFAULT NULL,
  `total` float DEFAULT NULL,
  `down_payment` float DEFAULT NULL,
  `extra_services` text,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `comments` text,
  `status` int(11) DEFAULT '1',
  `trans` varchar(50) DEFAULT NULL,
  `payment_date` int(11) DEFAULT NULL,
  `payment_method` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_booking`
--

INSERT INTO `pm_booking` (`id`, `id_room`, `room`, `add_date`, `edit_date`, `from_date`, `to_date`, `nights`, `adults`, `children`, `amount`, `tourist_tax`, `total`, `down_payment`, `extra_services`, `firstname`, `lastname`, `email`, `phone`, `comments`, `status`, `trans`, `payment_date`, `payment_method`) VALUES
(1, 2, 'Төрөө', 1478705897, 1478705897, 1478707200, 1478707200, 1, 1, 0, 1, 1, 1, 0, '', 'Mfjfj', 'Mfmaskf', 'mfkasm@mka.mk', '90909999', '', 1, '', 1478829600, ''),
(2, 2, 'dnjasndajsd', 1478859396, 1478859396, 1477929600, 1479830400, 1, 1, 0, 1, 1, 1, 0, '', 'Mfjfj', 'Mfmaskf', 'mfkasm@mka.mk', '90909999', '', 1, '', NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `pm_booking_activity`
--

DROP TABLE IF EXISTS `pm_booking_activity`;
CREATE TABLE IF NOT EXISTS `pm_booking_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_booking` int(11) NOT NULL,
  `id_activity` int(11) NOT NULL,
  `title` varchar(250) DEFAULT NULL,
  `children` int(11) DEFAULT '0',
  `adults` int(11) DEFAULT '0',
  `duration` varchar(50) DEFAULT NULL,
  `amount` double DEFAULT '0',
  `date` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_activity_fkey` (`id_booking`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pm_comment`
--

DROP TABLE IF EXISTS `pm_comment`;
CREATE TABLE IF NOT EXISTS `pm_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_type` varchar(30) DEFAULT NULL,
  `id_item` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `checked` int(11) DEFAULT '0',
  `add_date` int(11) DEFAULT NULL,
  `edit_date` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `msg` longtext,
  `ip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pm_country`
--

DROP TABLE IF EXISTS `pm_country`;
CREATE TABLE IF NOT EXISTS `pm_country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `code` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pm_currency`
--

DROP TABLE IF EXISTS `pm_currency`;
CREATE TABLE IF NOT EXISTS `pm_currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(5) DEFAULT NULL,
  `sign` varchar(5) DEFAULT NULL,
  `main` int(11) DEFAULT '0',
  `rank` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_currency`
--

INSERT INTO `pm_currency` (`id`, `code`, `sign`, `main`, `rank`) VALUES
(1, 'MNT', '₮', 1, 1),
(2, 'USD', '$', 0, 2),
(3, 'EUR', '€', 0, 3),
(4, 'GBP', '£', 0, 4),
(5, 'JPY', '¥', 0, 5),
(6, 'KRW', '₩', 0, 6),
(7, 'CNY', '¥', 0, 7),
(8, 'RUB', '₽', 0, 8),
(9, 'AUD', 'A$', 0, 9),
(10, 'CAD', 'C$', 0, 10);

-- --------------------------------------------------------

--
-- Table structure for table `pm_destination`
--

DROP TABLE IF EXISTS `pm_destination`;
CREATE TABLE IF NOT EXISTS `pm_destination` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `checked` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_destination`
--

INSERT INTO `pm_destination` (`id`, `name`, `checked`) VALUES
(1, 'Ulaanbaatar', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pm_facility`
--

DROP TABLE IF EXISTS `pm_facility`;
CREATE TABLE IF NOT EXISTS `pm_facility` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `name` varchar(250) DEFAULT NULL,
  `rank` int(11) DEFAULT '0',
  PRIMARY KEY (`id`,`lang`),
  KEY `facility_lang_fkey` (`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_facility`
--

INSERT INTO `pm_facility` (`id`, `lang`, `name`, `rank`) VALUES
(1, 1, 'Агаар цэвэршүүлэгч', 1),
(1, 2, 'Air conditioning', 1),
(2, 1, 'Хүүхдийн ор', 2),
(2, 2, 'Baby cot', 2),
(3, 1, 'Тагт', 3),
(3, 2, 'Balcony', 3),
(4, 1, 'Шорлогийн тавиур', 4),
(4, 2, 'Barbecue', 4),
(5, 1, 'Угаалгын өрөө', 5),
(5, 2, 'Bathroom', 5),
(6, 1, 'Кофе чанагч', 6),
(6, 2, 'Coffeemaker', 6),
(7, 1, 'Цахилгаан пилетка', 7),
(7, 2, 'Cooktop', 7),
(8, 1, 'Ширээ', 8),
(8, 2, 'Desk', 8),
(9, 1, 'Аяга таваг угаагч', 9),
(9, 2, 'Dishwasher', 9),
(10, 1, 'Сэнс', 10),
(10, 2, 'Fan', 10),
(11, 1, 'Үнэгүй зогсоол', 11),
(11, 2, 'Free parking', 11),
(12, 1, 'Хөргөгч', 12),
(12, 2, 'Fridge', 12),
(13, 1, 'Үсний сэнс', 13),
(13, 2, 'Hairdryer', 13),
(14, 1, 'Интернэт', 14),
(14, 2, 'Internet', 14),
(15, 1, 'Индүү', 15),
(15, 2, 'Iron', 15),
(16, 1, 'Бичил долгионы зуух', 16),
(16, 2, 'Microwave', 16),
(17, 1, 'Мини-бар', 17),
(17, 2, 'Mini-bar', 17),
(18, 1, 'Тамхи-татахыг хориглоно', 18),
(18, 2, 'Non-smoking', 18),
(19, 1, 'Төлбөртэй зогсоол', 19),
(19, 2, 'Paid parking', 19),
(20, 1, 'Гэрийн тэжээвэр амьтан зөвшөөрнө', 20),
(20, 2, 'Pets allowed', 20),
(21, 1, 'Гэрийн тэжээвэр амьтан зөвшөөрөхгүй', 21),
(21, 2, 'Pets not allowed', 21),
(22, 1, 'Радио', 22),
(22, 2, 'Radio', 22),
(23, 1, 'Сэйф', 23),
(23, 2, 'Safe', 23),
(24, 1, 'Кабелын ТВ', 24),
(24, 2, 'Satellite chanels', 24),
(25, 1, 'Шүршүүрийн өрөө', 25),
(25, 2, 'Shower-room', 25),
(26, 1, 'Жижиг амралтын өрөө', 26),
(26, 2, 'Small lounge', 26),
(27, 1, 'Суурин утас', 27),
(27, 2, 'Telephone', 27),
(28, 1, 'Зурагт', 28),
(28, 2, 'Television', 28),
(29, 1, 'Гадаа суух байгууламж', 29),
(29, 2, 'Terrasse', 29),
(30, 1, 'Угаалгын машин', 30),
(30, 2, 'Washing machine', 30),
(31, 1, 'Тэргэнцэртэй орж болох', 31),
(31, 2, 'Wheelchair accessible', 31),
(32, 1, 'Wi-Fi', 31),
(32, 2, 'WiFi', 31),
(33, 1, 'Hi-fi систем', 32),
(33, 2, 'Hi-fi system', 32),
(34, 1, 'DVD тоглуулагч', 33),
(34, 2, 'DVD player', 33),
(35, 1, 'Лифт', 34),
(35, 2, 'Elevator', 34),
(36, 1, 'Амралтын өрөө', 35),
(36, 2, 'Lounge', 35),
(37, 1, 'Ресторан', 36),
(37, 2, 'Restaurant', 36),
(38, 1, 'Өрөөний үйлчилгээ', 37),
(38, 2, 'Room service', 37),
(39, 1, 'Хувцасны өлгүүр', 38),
(39, 2, 'Cloakroom', 38);

-- --------------------------------------------------------

--
-- Table structure for table `pm_facility_file`
--

DROP TABLE IF EXISTS `pm_facility_file`;
CREATE TABLE IF NOT EXISTS `pm_facility_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '1',
  `rank` int(11) DEFAULT '0',
  `file` varchar(250) DEFAULT NULL,
  `label` varchar(250) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`lang`),
  KEY `facility_file_fkey` (`id_item`,`lang`),
  KEY `facility_file_lang_fkey` (`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_facility_file`
--

INSERT INTO `pm_facility_file` (`id`, `lang`, `id_item`, `home`, `checked`, `rank`, `file`, `label`, `type`) VALUES
(1, 1, 31, 0, 1, 1, 'wheelchair.png', '', 'image'),
(1, 2, 31, 0, 1, 1, 'wheelchair.png', '', 'image'),
(2, 1, 20, 0, 1, 2, 'pet-allowed.png', '', 'image'),
(2, 2, 20, 0, 1, 2, 'pet-allowed.png', '', 'image'),
(3, 1, 21, 0, 1, 3, 'pet-not-allowed.png', '', 'image'),
(3, 2, 21, 0, 1, 3, 'pet-not-allowed.png', '', 'image'),
(4, 1, 3, 0, 1, 4, 'balcony.png', '', 'image'),
(4, 2, 3, 0, 1, 4, 'balcony.png', '', 'image'),
(5, 1, 4, 0, 1, 5, 'barbecue.png', '', 'image'),
(5, 2, 4, 0, 1, 5, 'barbecue.png', '', 'image'),
(6, 1, 8, 0, 1, 6, 'desk.png', '', 'image'),
(6, 2, 8, 0, 1, 6, 'desk.png', '', 'image'),
(7, 1, 6, 0, 1, 7, 'coffee.png', '', 'image'),
(7, 2, 6, 0, 1, 7, 'coffee.png', '', 'image'),
(8, 1, 24, 0, 1, 8, 'satellite.png', '', 'image'),
(8, 2, 24, 0, 1, 8, 'satellite.png', '', 'image'),
(9, 1, 1, 0, 1, 9, 'air-conditioning.png', '', 'image'),
(9, 2, 1, 0, 1, 9, 'air-conditioning.png', '', 'image'),
(10, 1, 23, 0, 1, 10, 'safe.png', '', 'image'),
(10, 2, 23, 0, 1, 10, 'safe.png', '', 'image'),
(11, 1, 26, 0, 1, 11, 'lounge.png', '', 'image'),
(11, 2, 26, 0, 1, 11, 'lounge.png', '', 'image'),
(12, 1, 15, 0, 1, 12, 'iron.png', '', 'image'),
(12, 2, 15, 0, 1, 12, 'iron.png', '', 'image'),
(13, 1, 14, 0, 1, 13, 'adsl.png', '', 'image'),
(13, 2, 14, 0, 1, 13, 'adsl.png', '', 'image'),
(14, 1, 9, 0, 1, 14, 'dishwasher.png', '', 'image'),
(14, 2, 9, 0, 1, 14, 'dishwasher.png', '', 'image'),
(15, 1, 2, 0, 1, 15, 'baby-cot.png', '', 'image'),
(15, 2, 2, 0, 1, 15, 'baby-cot.png', '', 'image'),
(16, 1, 30, 0, 1, 16, 'washing-machine.png', '', 'image'),
(16, 2, 30, 0, 1, 16, 'washing-machine.png', '', 'image'),
(17, 1, 16, 0, 1, 17, 'microwaves.png', '', 'image'),
(17, 2, 16, 0, 1, 17, 'microwaves.png', '', 'image'),
(18, 1, 17, 0, 1, 18, 'mini-bar.png', '', 'image'),
(18, 2, 17, 0, 1, 18, 'mini-bar.png', '', 'image'),
(19, 1, 18, 0, 1, 19, 'non-smoking.png', '', 'image'),
(19, 2, 18, 0, 1, 19, 'non-smoking.png', '', 'image'),
(20, 1, 11, 0, 1, 20, 'free-parking.png', '', 'image'),
(20, 2, 11, 0, 1, 20, 'free-parking.png', '', 'image'),
(21, 1, 19, 0, 1, 21, 'paid-parking.png', '', 'image'),
(21, 2, 19, 0, 1, 21, 'paid-parking.png', '', 'image'),
(22, 1, 7, 0, 1, 22, 'cooktop.png', '', 'image'),
(22, 2, 7, 0, 1, 22, 'cooktop.png', '', 'image'),
(23, 1, 22, 0, 1, 23, 'radio.png', '', 'image'),
(23, 2, 22, 0, 1, 23, 'radio.png', '', 'image'),
(24, 1, 12, 0, 1, 24, 'fridge.png', '', 'image'),
(24, 2, 12, 0, 1, 24, 'fridge.png', '', 'image'),
(25, 1, 25, 0, 1, 25, 'shower.png', '', 'image'),
(25, 2, 25, 0, 1, 25, 'shower.png', '', 'image'),
(26, 1, 5, 0, 1, 26, 'bath.png', '', 'image'),
(26, 2, 5, 0, 1, 26, 'bath.png', '', 'image'),
(27, 1, 13, 0, 1, 27, 'hairdryer.png', '', 'image'),
(27, 2, 13, 0, 1, 27, 'hairdryer.png', '', 'image'),
(28, 1, 27, 0, 1, 28, 'phone.png', '', 'image'),
(28, 2, 27, 0, 1, 28, 'phone.png', '', 'image'),
(29, 1, 28, 0, 1, 29, 'tv.png', '', 'image'),
(29, 2, 28, 0, 1, 29, 'tv.png', '', 'image'),
(30, 1, 29, 0, 1, 30, 'terrasse.png', '', 'image'),
(30, 2, 29, 0, 1, 30, 'terrasse.png', '', 'image'),
(31, 1, 10, 0, 1, 31, 'fan.png', '', 'image'),
(31, 2, 10, 0, 1, 31, 'fan.png', '', 'image'),
(32, 1, 32, 0, 1, 32, 'wifi.png', '', 'image'),
(32, 2, 32, 0, 1, 32, 'wifi.png', '', 'image'),
(33, 1, 33, 0, 1, 33, 'hifi.png', '', 'image'),
(33, 2, 33, 0, 1, 33, 'hifi.png', '', 'image'),
(34, 1, 34, 0, 1, 34, 'dvd.png', '', 'image'),
(34, 2, 34, 0, 1, 34, 'dvd.png', '', 'image'),
(35, 1, 33, 0, 1, 33, 'elevator.png', '', 'image'),
(35, 2, 33, 0, 1, 33, 'elevator.png', '', 'image'),
(36, 1, 33, 0, 1, 33, 'lounge.png', '', 'image'),
(36, 2, 33, 0, 1, 33, 'lounge.png', '', 'image'),
(37, 1, 33, 0, 1, 33, 'restaurant.png', '', 'image'),
(37, 2, 33, 0, 1, 33, 'restaurant.png', '', 'image'),
(38, 1, 33, 0, 1, 33, 'room-service.png', '', 'image'),
(38, 2, 33, 0, 1, 33, 'room-service.png', '', 'image'),
(39, 1, 33, 0, 1, 33, 'cloakroom.png', '', 'image'),
(39, 2, 33, 0, 1, 33, 'cloakroom.png', '', 'image');

-- --------------------------------------------------------

--
-- Table structure for table `pm_hotel`
--

DROP TABLE IF EXISTS `pm_hotel`;
CREATE TABLE IF NOT EXISTS `pm_hotel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `subtitle` varchar(250) DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `web` varchar(250) DEFAULT NULL,
  `descr` longtext,
  `facilities` varchar(250) DEFAULT NULL,
  `id_destination` int(11) DEFAULT NULL,
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '0',
  `rank` int(11) DEFAULT '0',
  PRIMARY KEY (`id`,`lang`),
  KEY `hotel_lang_fkey` (`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_hotel`
--

INSERT INTO `pm_hotel` (`id`, `lang`, `id_user`, `title`, `subtitle`, `alias`, `address`, `lat`, `lng`, `email`, `phone`, `web`, `descr`, `facilities`, `id_destination`, `home`, `checked`, `rank`) VALUES
(1, 1, 1, 'Зочид буудал', 'Зочид буудал', 'taracode-hotel', 'Ulaanbaatar, Mongolia', 4.455734, 73.718185, 'contact@taracode.mn', '+976 99999999', '', '<p>Манай зочид буудал нь 3 одны зэрэглэлтэй ба энгийн болон хагас люкс, люкс 180 өрөөнд 330 хүн хүлээн авах хүчин чадалтай. Хотын төвд хэрнээ дуу чимээнээс алс, өндөрлөг хэсэгт мод бутаар хүрээлүүлэн, намуухан орчинд байрлах манай буудлаас Улаанбаатар хот болон үзэсгэлэнт Богд уул, хүрээлэн буй орчин сэтгэл татам харагддаг нь бидний нэг давуу тал юм. Буудлаас та ихэнх шаардлагатай газар руугаа зорчиход тун тохиромжтой: Тухайлбал замын ачаалал бага үед Чингис Хаан Олон Улсын нисэх буудал машинаар ердөө л 20 минут, Төмөр замын буудал аравхан  минут л явах бөгөөд хотын төв хэсэг Сүхбаатарын талбай, бизнес, худалдааны төвүүд, театр, музей, галларейнүүд ердөө л 20минут алхах зайд байрлалтай.</p>\r\n\r\n<p>Манайх Европ, Монгол, Хятад, Япон ресторанууддаа нэгдүгээр зэргийн тогоочийн хийсэн амт чанартай зоогоор зочиддоо үйлчилдэг. Мөн манайд ачаалал ихтэй ажилладаг хүний алжаал ядаргааг тун сайн тайлах Япон хэв маягийн саун, массаж, гоо сайхны салон болон Караоке баар ажиллаж байна.</p>\r\n', '32,1,20,26,17,37,27,5,25,11,38', 1, 1, 1, 1),
(1, 2, 1, 'Royal Hotel', 'Luxury hotel overlooking the sea', 'royal-hotel', 'Ulaanbaatar, Mongolia', 4.455734, 73.718185, 'contact@taracode.mn', '+976 99999999', '', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean aliquet felis massa, sed condimentum ligula feugiat et. Etiam facilisis euismod dignissim. Vivamus facilisis lorem ut purus pellentesque, nec sollicitudin lorem suscipit. Fusce sed enim ultricies, venenatis nunc ut, pharetra nunc. Quisque sollicitudin egestas varius. Nulla aliquet magna sapien, id malesuada felis lobortis id. Vivamus vulputate sed enim sit amet eleifend. Vivamus sit amet felis id urna vulputate maximus. Nullam fringilla sed turpis non volutpat. Cras ultrices diam velit, ac volutpat odio semper at. Sed pulvinar turpis imperdiet sapien hendrerit pulvinar.</p>\r\n', '32,1,20,26,17,37,27,5,25,11,38', 1, 1, 1, 1),
(2, 1, 1, 'Амралтын газар', 'Амралтын газар', 'tourist-camp', 'Ulaanbaatar, Mongolia', 98, 98, 'contact@taracode.mn', '+976 88888888', '', '', '', 1, 1, 1, 2),
(2, 2, 1, '', '', '', 'Ulaanbaatar, Mongolia', 98, 98, 'contact@taracode.mn', '+976 88888888', '', '', '', 1, 1, 1, 2),
(3, 1, 1, 'Мод захиалах', 'Мод захиалах', 'wood-sale', 'Ulaanbaatar, Mongolia', 98, 98, '', '', '', '', '', 1, 1, 1, 3),
(3, 2, 1, '', '', '', 'Ulaanbaatar, Mongolia', 98, 98, '', '', '', '', '', 1, 1, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `pm_hotel_file`
--

DROP TABLE IF EXISTS `pm_hotel_file`;
CREATE TABLE IF NOT EXISTS `pm_hotel_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '1',
  `rank` int(11) DEFAULT '0',
  `file` varchar(250) DEFAULT NULL,
  `label` varchar(250) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`lang`),
  KEY `hotel_file_fkey` (`id_item`,`lang`),
  KEY `hotel_file_lang_fkey` (`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_hotel_file`
--

INSERT INTO `pm_hotel_file` (`id`, `lang`, `id_item`, `home`, `checked`, `rank`, `file`, `label`, `type`) VALUES
(1, 1, 1, 0, 1, 1, '5555048217-1389b680d6-o.jpg', '', 'image'),
(1, 2, 1, 0, 1, 1, '5555048217-1389b680d6-o.jpg', '', 'image'),
(2, 1, 2, NULL, 1, 2, '6.jpg', '', 'image'),
(2, 2, 2, NULL, 1, 2, '6.jpg', '', 'image'),
(3, 1, 3, NULL, 1, 3, '9.jpg', '', 'image'),
(3, 2, 3, NULL, 1, 3, '9.jpg', '', 'image');

-- --------------------------------------------------------

--
-- Table structure for table `pm_lang`
--

DROP TABLE IF EXISTS `pm_lang`;
CREATE TABLE IF NOT EXISTS `pm_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) DEFAULT NULL,
  `locale` varchar(20) DEFAULT NULL,
  `main` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '0',
  `rank` int(11) DEFAULT '0',
  `tag` varchar(20) DEFAULT NULL,
  `rtl` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_lang`
--

INSERT INTO `pm_lang` (`id`, `title`, `locale`, `main`, `checked`, `rank`, `tag`, `rtl`) VALUES
(1, 'Монгол', 'mn_MN', 1, 1, 2, 'mn', 0),
(2, 'English', 'en_GB', 0, 1, 1, 'en', 0);

-- --------------------------------------------------------

--
-- Table structure for table `pm_lang_file`
--

DROP TABLE IF EXISTS `pm_lang_file`;
CREATE TABLE IF NOT EXISTS `pm_lang_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_item` int(11) NOT NULL,
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '1',
  `rank` int(11) DEFAULT '0',
  `file` varchar(250) DEFAULT NULL,
  `label` varchar(250) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lang_file_fkey` (`id_item`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_lang_file`
--

INSERT INTO `pm_lang_file` (`id`, `id_item`, `home`, `checked`, `rank`, `file`, `label`, `type`) VALUES
(1, 1, 0, 1, 2, 'mn.png', '', 'image'),
(2, 2, 0, 1, 1, 'gb.png', '', 'image');

-- --------------------------------------------------------

--
-- Table structure for table `pm_location`
--

DROP TABLE IF EXISTS `pm_location`;
CREATE TABLE IF NOT EXISTS `pm_location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lng` double DEFAULT NULL,
  `checked` int(11) DEFAULT '0',
  `pages` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_location`
--

INSERT INTO `pm_location` (`id`, `name`, `address`, `lat`, `lng`, `checked`, `pages`) VALUES
(1, 'Tagtaa solution', 'Ulaanbaatar, Mongolia', 47.9216221, 106.9201769, 1, '2');

-- --------------------------------------------------------

--
-- Table structure for table `pm_media`
--

DROP TABLE IF EXISTS `pm_media`;
CREATE TABLE IF NOT EXISTS `pm_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pm_media_file`
--

DROP TABLE IF EXISTS `pm_media_file`;
CREATE TABLE IF NOT EXISTS `pm_media_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_item` int(11) NOT NULL,
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '1',
  `rank` int(11) DEFAULT '0',
  `file` varchar(250) DEFAULT NULL,
  `label` varchar(250) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_file_fkey` (`id_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pm_message`
--

DROP TABLE IF EXISTS `pm_message`;
CREATE TABLE IF NOT EXISTS `pm_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_date` int(11) DEFAULT NULL,
  `edit_date` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` longtext,
  `phone` varchar(100) DEFAULT NULL,
  `subject` varchar(250) DEFAULT NULL,
  `msg` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pm_page`
--

DROP TABLE IF EXISTS `pm_page`;
CREATE TABLE IF NOT EXISTS `pm_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `subtitle` varchar(250) DEFAULT NULL,
  `title_tag` varchar(250) DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `descr` longtext,
  `robots` varchar(20) DEFAULT NULL,
  `keywords` varchar(250) DEFAULT NULL,
  `intro` longtext,
  `text` longtext,
  `text2` longtext,
  `id_parent` int(11) DEFAULT NULL,
  `page_model` varchar(50) DEFAULT NULL,
  `article_model` varchar(50) DEFAULT NULL,
  `main` int(11) DEFAULT '1',
  `footer` int(11) DEFAULT '0',
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '0',
  `rank` int(11) DEFAULT '0',
  `add_date` int(11) DEFAULT NULL,
  `edit_date` int(11) DEFAULT NULL,
  `comment` int(11) DEFAULT '0',
  `rating` int(11) DEFAULT '0',
  `system` int(11) DEFAULT '0',
  PRIMARY KEY (`id`,`lang`),
  KEY `page_lang_fkey` (`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_page`
--

INSERT INTO `pm_page` (`id`, `lang`, `name`, `title`, `subtitle`, `title_tag`, `alias`, `descr`, `robots`, `keywords`, `intro`, `text`, `text2`, `id_parent`, `page_model`, `article_model`, `main`, `footer`, `home`, `checked`, `rank`, `add_date`, `edit_date`, `comment`, `rating`, `system`) VALUES
(1, 1, 'Нүүр', 'Нүүр', 'Нүүр', 'Нүүр', '', '', 'index,follow', '', '', '<blockquote class="text-center">\r\n<p>Хамгийн сайн үйлчилгээг зөвхөн манайх</p>\r\n</blockquote>\r\n', '', NULL, 'home', 'home', 1, 0, 1, 1, 1, 1478177832, 1478495468, 0, 0, 0),
(1, 2, 'Home', 'Lorem ipsum dolor sit amet', '', 'Lorem ipsum dolor sit amet', '', '', 'index,follow', '', '', '<blockquote class="text-center">\r\n<p>A man travels the world over in search of what he needs and returns home to find it.</p>\r\n</blockquote>\r\n\r\n<p class="text-muted" style="text-align: center;">- George A. Moore -</p>\r\n', '', NULL, 'home', 'home', 1, 0, 1, 1, 1, 1478177832, 1478495468, 0, 0, 0),
(2, 1, 'Холбоо барих', 'Холбоо барих', '', 'Холбоо барих', 'contact', '', 'index,follow', '', '', '', '', NULL, 'contact', '', 1, 1, 0, 1, 11, 1478177832, 1478177832, 0, 0, 0),
(2, 2, 'Contact', 'Contact', '', 'Contact', 'contact', '', 'index,follow', '', '', '', '', NULL, 'contact', '', 1, 1, 0, 1, 11, 1478177832, 1478177832, 0, 0, 0),
(3, 1, 'Үйлчилгээний нөхцөл', 'Үйлчилгээний нөхцөл', '', 'Үйлчилгээний нөхцөл', 'legal-notices', '', 'index,follow', '', '', '', '', NULL, 'page', '', 0, 1, 0, 1, 12, 1478177832, 1478289732, 0, 0, 0),
(3, 2, 'Legal notices', 'Legal notices', '', 'Legal notices', 'legal-notices', '', 'index,follow', '', '', '', '', NULL, 'page', '', 0, 1, 0, 1, 12, 1478177832, 1478289732, 0, 0, 0),
(4, 1, 'Сайтын бүтэц', 'Сайтын бүтэц', '', 'Сайтын бүтэц', 'site-map', '', 'index,follow', '', '', '', '', NULL, 'sitemap', '', 0, 1, 0, 1, 13, 1478177832, 1478289710, 0, 0, 0),
(4, 2, 'Sitemap', 'Sitemap', '', 'Sitemap', 'sitemap', '', 'index,follow', '', '', '', '', NULL, 'sitemap', '', 0, 1, 0, 1, 13, 1478177832, 1478289710, 0, 0, 0),
(5, 1, 'Бидний тухай', 'Бидний тухай', '', 'Бидний тухай', 'about-us', '', 'index,follow', '', '', '<p>Манай зочид буудал нь 3 одны зэрэглэлтэй ба энгийн болон хагас люкс, люкс 180 өрөөнд 330 хүн хүлээн авах хүчин чадалтай. Хотын төвд хэрнээ дуу чимээнээс алс, өндөрлөг хэсэгт мод бутаар хүрээлүүлэн, намуухан орчинд байрлах манай буудлаас Улаанбаатар хот болон үзэсгэлэнт Богд уул, хүрээлэн буй орчин сэтгэл татам харагддаг нь бидний нэг давуу тал юм. Буудлаас та ихэнх шаардлагатай газар руугаа зорчиход тун тохиромжтой: Тухайлбал замын ачаалал бага үед Чингис Хаан Олон Улсын нисэх буудал машинаар ердөө л 20 минут, Төмөр замын буудал аравхан  минут л явах бөгөөд хотын төв хэсэг Сүхбаатарын талбай, бизнес, худалдааны төвүүд, театр, музей, галларейнүүд ердөө л 20минут алхах зайд байрлалтай.Манайх Европ, Монгол, Хятад, Япон ресторанууддаа нэгдүгээр зэргийн тогоочийн хийсэн амт чанартай зоогоор зочиддоо үйлчилдэг. Мөн манайд ачаалал ихтэй ажилладаг хүний алжаал ядаргааг тун сайн тайлах Япон хэв маягийн саун, массаж, гоо сайхны салон болон Караоке баар ажиллаж байна.</p>\r\n', '<p>Манай буудлын ихэнх албан хаагчид англи, япон, орос болон бусад гадаад хэлээр зочидтойгоо харилцах чадвартай. Бидний үйл ажиллагаа, үйлчилгээний чанарыг үнэлж Цэцэг зочид буудлыг Монгол Улсын Засгийн Газраас хамгийн сайн үйл ажиллагаатай аж ахуйн нэгжүүдийн нэгээр тодруулан шалгаруулж байсан.</p>\r\n', NULL, 'page', 'article', 1, 0, 0, 1, 2, 1478177832, 1478289576, 0, 0, 0),
(5, 2, 'About us', 'About us', '', 'About us', 'about-us', '', 'index,follow', '', '', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque fringilla vel est at rhoncus. Cras porttitor ligula vel magna vehicula accumsan. Mauris eget elit et sem commodo interdum. Aenean dolor sem, tincidunt ac neque tempus, hendrerit blandit lacus. Vivamus placerat nulla in mi tristique, fringilla fermentum nisl vehicula. Nullam quis eros non magna tincidunt interdum ac eu eros. Morbi malesuada pulvinar ultrices. Etiam bibendum efficitur risus, sit amet venenatis urna ullamcorper non. Proin fermentum malesuada tortor, vitae mattis sem scelerisque in. Curabitur rutrum leo at mi efficitur suscipit. Vivamus tristique lorem eros, sit amet malesuada augue sodales sed.</p>\r\n', '<p>Etiam bibendum efficitur risus, sit amet venenatis urna ullamcorper non. Proin fermentum malesuada tortor, vitae mattis sem scelerisque in. Curabitur rutrum leo at mi efficitur.</p>\r\n', NULL, 'page', 'article', 1, 0, 0, 1, 2, 1478177832, 1478289576, 0, 0, 0),
(6, 1, 'Хайх', 'Хайх', '', 'Хайх', 'search', '', 'noindex,nofollow', '', '', '', '', NULL, 'search', '', 0, 0, 0, 1, 14, 1478177832, 1478289687, 0, 0, 1),
(6, 2, 'Search', 'Search', '', 'Search', 'search', '', 'noindex,nofollow', '', '', '', '', NULL, 'search', '', 0, 0, 0, 1, 14, 1478177832, 1478289687, 0, 0, 1),
(7, 1, 'Амралтын газар', 'Амралтын газар', '', 'Амралтын газар', 'hotels-tourist-camp', '', 'index,follow', '', '', '', '', NULL, 'hotel', 'hotel', 1, 0, 0, 1, 5, 1478177832, 1479053017, 1, 0, 0),
(7, 2, 'Tourist camp', 'Tourist camp', '', 'Tourist camp', 'hotels-tourist-camp', '', 'index,follow', '', '', '', '', NULL, 'hotel', 'hotel', 1, 0, 0, 1, 5, 1478177832, 1479053017, 1, 0, 0),
(8, 1, '404', 'Алдаа 404 : Хуудас олдонгүй !', '', '404 хуудас олдонгүй', '404', '', 'noindex,nofollow', '', '', '<p>''Серверт таны хандсан URL хаяг алга байна.<br />\r\nЭнэ хуудас анхнаасаа байгаагүй, хаяг нь солигдсон эсвэл түр зуур хандах боломжгүй байна.</p>\r\n\r\n<p>Доорх зааврыг дагана уу :</p>\r\n\r\n<ul>\r\n  <li>Таны интернэт хөтөчийн хандах хэсэгт буй URL хаяг зөв бичигдсэн эсэхийг шалгана уу.</li>\r\n  <li>Хэрвээ та энэ хуудасруу сайтын холбоос линкээр дамжиж орсон эсвэл энэ алдаа нь серверийн алдаатай үйлдэл гэж үзэж байвал сайтын администраторт хандаж мэдэгдэнэ үү.</li>\r\n</ul>\r\n', '', NULL, '404', '', 0, 0, 0, 1, 15, 1478177832, 1478289667, 0, 0, 1),
(8, 2, '404', '404 Error: Page not found!', '', '404 Not Found', '404', '', 'noindex,nofollow', '', '', '<p>The wanted URL was not found on this server.<br />\r\nThe page you wish to display does not exist, or is temporarily unavailable.</p>\r\n\r\n<p>Thank you for trying the following actions :</p>\r\n\r\n<ul>\r\n  <li>Be sure the URL in the address bar of your browser is correctly spelt and formated.</li>\r\n  <li>If you reached this page by clicking a link or if you think that it is about an error of the server, contact the administrator to alert him.</li>\r\n</ul>\r\n', '', NULL, '404', '', 0, 0, 0, 1, 15, 1478177832, 1478289667, 0, 0, 1),
(9, 1, 'Зочид буудал', 'Зочид буудал', '', 'Зочид буудал', 'hotels', '', 'index,follow', '', '', '', '', NULL, 'hotels', 'hotel', 1, 0, 0, 1, 3, 1478177832, 1478291968, 0, 0, 1),
(9, 2, 'Hotel', 'Hotel', '', 'Hotel', 'hotels-taracode-hotel', '', 'index,follow', '', '', '', '', NULL, 'hotels', 'hotel', 1, 0, 0, 1, 3, 1478177832, 1478291968, 0, 0, 1),
(10, 1, 'Захиалга', 'Захиалга', '', 'Захиалга', 'booking', '', 'noindex,nofollow', '', '', '', '', NULL, 'booking', '', 1, 0, 0, 1, 6, 1478177832, 1478289871, 0, 0, 1),
(10, 2, 'Booking', 'Booking', '', 'Booking', 'booking', '', 'noindex,nofollow', '', '', '', '', NULL, 'booking', '', 1, 0, 0, 1, 6, 1478177832, 1478289871, 0, 0, 1),
(11, 1, 'Танилцуулга', 'Танилцуулга', '', 'Танилцуулга', 'booking-details', '', 'noindex,nofollow', '', '', '', '', 10, 'details', '', 0, 0, 0, 1, 8, 1478177832, 1478289907, 0, 0, 1),
(11, 2, 'Details', 'Booking details', '', 'Booking details', 'booking-details', '', 'noindex,nofollow', '', '', '', '', 10, 'details', '', 0, 0, 0, 1, 8, 1478177832, 1478289907, 0, 0, 1),
(12, 1, 'Төлбөр тооцоо', 'Төлбөр тооцоо', '', 'Төлбөр тооцоо', 'payment', '', 'noindex,nofollow', '', '', '', '', 13, 'payment', '', 0, 0, 0, 1, 10, 1478177832, 1478289769, 0, 0, 1),
(12, 2, 'Payment', 'Payment', '', 'Payment', 'payment', '', 'noindex,nofollow', '', '', '', '', 13, 'payment', '', 0, 0, 0, 1, 10, 1478177832, 1478289769, 0, 0, 1),
(13, 1, 'Дүн', 'Захиалгын нийт дүн', '', 'Захиалгын нийт дүн', 'booking-summary', '', 'noindex,nofollow', '', '', '', '', 11, 'summary', '', 0, 0, 0, 1, 9, 1478177832, 1478289794, 0, 0, 1),
(13, 2, 'Summary', 'Booking summary', '', 'Booking summary', 'booking-summary', '', 'noindex,nofollow', '', '', '', '', 11, 'summary', '', 0, 0, 0, 1, 9, 1478177832, 1478289794, 0, 0, 1),
(14, 1, 'Бүртгэл', 'Бүртгэл', '', 'Бүртгэл', 'account', '', 'noindex,nofollow', '', '', '', '', NULL, 'account', '', 0, 0, 0, 1, 16, 1478177832, 1478289633, 0, 0, 1),
(14, 2, 'Account', 'Account', '', 'Account', 'account', '', 'noindex,nofollow', '', '', '', '', NULL, 'account', '', 0, 0, 0, 1, 16, 1478177832, 1478289633, 0, 0, 1),
(15, 1, 'Үйл ажиллагаа', 'Үйл ажиллагаа', '', 'Үйл ажиллагаа', 'booking-activities', '', 'noindex,nofollow', '', '', '', '', 10, 'booking-activities', '', 1, 0, 0, 1, 7, 1478177832, 1478289888, 0, 0, 1),
(15, 2, 'Activities', 'Activities', '', 'Activities', 'booking-activities', '', 'noindex,nofollow', '', '', '', '', 10, 'booking-activities', '', 1, 0, 0, 1, 7, 1478177832, 1478289888, 0, 0, 1),
(16, 1, 'Үйл ажиллагаа', 'Үйл ажиллагаа', '', 'Үйл ажиллагаа', 'activities', '', 'noindex,nofollow', '', '', '', '', NULL, 'activities', 'activity', 0, 0, 0, 1, 4, 1478177832, 1479062878, 0, 0, 1),
(16, 2, 'Activities', 'Activities', '', 'Activities', 'activities', '', 'noindex,nofollow', '', '', '', '', NULL, 'activities', 'activity', 0, 0, 0, 1, 4, 1478177832, 1479062878, 0, 0, 1),
(17, 1, 'Мод зарах', 'Мод зарах', 'Мод зарах', 'Мод зарах', 'sale', '', 'index,follow', NULL, 'Мод зарах', '', '', NULL, 'wood', 'wood', 1, 0, 0, 1, 17, 1478489653, 1479062892, 0, NULL, NULL),
(17, 2, 'Sale', 'Sale', 'Sale', 'Sale', 'sale', '', 'index,follow', NULL, '', '', '', NULL, 'wood', 'wood', 1, 0, 0, 1, 17, 1478489653, 1479062892, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pm_page_file`
--

DROP TABLE IF EXISTS `pm_page_file`;
CREATE TABLE IF NOT EXISTS `pm_page_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '1',
  `rank` int(11) DEFAULT '0',
  `file` varchar(250) DEFAULT NULL,
  `label` varchar(250) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`lang`),
  KEY `page_file_fkey` (`id_item`,`lang`),
  KEY `page_file_lang_fkey` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pm_rate`
--

DROP TABLE IF EXISTS `pm_rate`;
CREATE TABLE IF NOT EXISTS `pm_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_room` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `start_date` int(11) DEFAULT NULL,
  `end_date` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `price` double DEFAULT '0',
  `child_price` double DEFAULT '0',
  `discount` double DEFAULT '0',
  `people` int(11) DEFAULT NULL,
  `price_sup` double DEFAULT NULL,
  `fixed_sup` double DEFAULT NULL,
  `min_stay` int(11) DEFAULT NULL,
  `vat_rate` double DEFAULT NULL,
  `day_start` int(11) DEFAULT NULL,
  `day_end` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rate_room_fkey` (`id_room`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pm_room`
--

DROP TABLE IF EXISTS `pm_room`;
CREATE TABLE IF NOT EXISTS `pm_room` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `id_hotel` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `max_children` int(11) DEFAULT '1',
  `max_adults` int(11) DEFAULT '1',
  `max_people` int(11) DEFAULT NULL,
  `min_people` int(11) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `subtitle` varchar(250) DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `descr` longtext,
  `facilities` text,
  `stock` int(11) DEFAULT '1',
  `price` double DEFAULT '0',
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '0',
  `rank` int(11) DEFAULT '0',
  `start_lock` int(11) DEFAULT NULL,
  `end_lock` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`lang`),
  KEY `room_lang_fkey` (`lang`),
  KEY `room_hotel_fkey` (`id_hotel`,`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_room`
--

INSERT INTO `pm_room` (`id`, `lang`, `id_hotel`, `id_user`, `max_children`, `max_adults`, `max_people`, `min_people`, `title`, `subtitle`, `alias`, `descr`, `facilities`, `stock`, `price`, `home`, `checked`, `rank`, `start_lock`, `end_lock`) VALUES
(1, 1, 1, 1, 1, 2, 2, 1, 'Хоёр хүний өрөө', 'Хоёр хүний өрөө', 'chambre-double-deluxe', '<p>Буудлаас та ихэнх шаардлагатай газар руугаа зорчиход тун тохиромжтой: Тухайлбал замын ачаалал бага үед Чингис Хаан Олон Улсын нисэх буудал машинаар ердөө л 20 минут, Төмөр замын буудал аравхан  минут л явах бөгөөд хотын төв хэсэг Сүхбаатарын талбай, бизнес, худалдааны төвүүд, театр, музей, галларейнүүд ердөө л 20минут алхах зайд байрлалтай.</p>\r\n', '32,1,29,21,28,24,17,27,23,18,5,25,11,13', 1, 150000, 0, 1, 1, 1288540800, 1606665600),
(1, 2, 1, 1, 1, 2, 2, 1, 'Deluxe Double Bedroom', 'Breakfast included', 'deluxe-double-bedroom', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ut eleifend diam. Etiam molestie quam at nunc tempus, ac porttitor ante rutrum. Donec ipsum orci, molestie sit amet nibh a, accumsan varius nisl. Suspendisse blandit efficitur interdum. Nulla auctor tortor eu volutpat imperdiet. Nam at tempus sapien, sit amet porttitor neque. Nam lacinia ex libero, vel egestas ante vehicula nec.</p>\r\n\r\n<p>Sed sed dignissim est. Donec egestas nisl eu congue rhoncus. Nulla finibus malesuada mauris, et pellentesque diam scelerisque non. Duis auctor dapibus augue sed malesuada. Nam placerat at libero quis aliquam. Phasellus quam orci, dapibus sit amet finibus a, convallis volutpat arcu. Nullam condimentum quam id urna scelerisque varius. Duis a metus metus.</p>\r\n', '32,1,29,21,28,24,17,27,23,18,5,25,11,13', 1, 150000, 0, 1, 1, 1288540800, 1606665600),
(2, 1, 1, 1, 1, 1, 1, 1, 'Нэг хүний люкс өрөө', 'Нэг хүний люкс өрөө', 'one-lux', '', '33,32,1', 1, 100000, 1, 1, 2, 1478620800, 1483113600),
(2, 2, 1, 1, 1, 1, 1, 1, '', '', '', '', '33,32,1', 1, 100000, 1, 1, 2, 1478620800, 1483113600);

-- --------------------------------------------------------

--
-- Table structure for table `pm_room_file`
--

DROP TABLE IF EXISTS `pm_room_file`;
CREATE TABLE IF NOT EXISTS `pm_room_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '1',
  `rank` int(11) DEFAULT '0',
  `file` varchar(250) DEFAULT NULL,
  `label` varchar(250) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`lang`),
  KEY `room_file_fkey` (`id_item`,`lang`),
  KEY `room_file_lang_fkey` (`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_room_file`
--

INSERT INTO `pm_room_file` (`id`, `lang`, `id_item`, `home`, `checked`, `rank`, `file`, `label`, `type`) VALUES
(1, 1, 1, 0, 1, 1, 'deluxe-double-room.jpg', '', 'image'),
(1, 2, 1, 0, 1, 1, 'deluxe-double-room.jpg', '', 'image'),
(2, 1, 2, NULL, 1, 2, '4.jpg', '', 'image'),
(2, 2, 2, NULL, 1, 2, '4.jpg', '', 'image');

-- --------------------------------------------------------

--
-- Table structure for table `pm_service`
--

DROP TABLE IF EXISTS `pm_service`;
CREATE TABLE IF NOT EXISTS `pm_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `descr` text,
  `long_descr` text,
  `type` varchar(50) DEFAULT NULL,
  `rooms` varchar(250) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `vat_rate` double DEFAULT NULL,
  `checked` int(11) DEFAULT '0',
  `rank` int(11) DEFAULT '0',
  PRIMARY KEY (`id`,`lang`),
  KEY `service_lang_fkey` (`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_service`
--

INSERT INTO `pm_service` (`id`, `lang`, `id_user`, `title`, `descr`, `long_descr`, `type`, `rooms`, `price`, `vat_rate`, `checked`, `rank`) VALUES
(1, 1, 1, 'Ариун цэврийн хэрэгсэл (багц)', '1 гар нүүрийн алчуур, 1 том алчуур, 1 угаалгын өрөөний дэвсгэр', '', 'qty-night', '4,1,3,2', 7, 10, 1, 1),
(1, 2, 1, 'Rent of towel (kit)', '1 hand towel, 1 bath towel, 1 bath mat', '', 'qty-night', '4,1,3,2', 7, 10, 1, 1),
(2, 1, 1, 'Цэвэрлэгээ', '', '', 'package', '1,3,2', 50, 10, 1, 2),
(2, 2, 1, 'Housework', '', '', 'package', '1,3,2', 50, 10, 1, 2),
(3, 1, 1, 'Халаалт', '', '', 'night', '1,3,2', 8, 10, 1, 3),
(3, 2, 1, 'Heating', '', '', 'night', '1,3,2', 8, 10, 1, 3),
(4, 1, 1, 'Тэжээвэр амьтан', 'Төрөл үүлдрийн талаар дор бичнэ үү', '', 'qty-night', '4,1,3,2', 5, 10, 1, 4),
(4, 2, 1, 'Pet', 'Specify the breed below', '', 'qty-night', '4,1,3,2', 5, 10, 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `pm_slide`
--

DROP TABLE IF EXISTS `pm_slide`;
CREATE TABLE IF NOT EXISTS `pm_slide` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `legend` text,
  `url` varchar(250) DEFAULT NULL,
  `id_page` int(11) DEFAULT NULL,
  `checked` int(11) DEFAULT '0',
  `rank` int(11) DEFAULT '0',
  PRIMARY KEY (`id`,`lang`),
  KEY `slide_lang_fkey` (`lang`),
  KEY `slide_page_fkey` (`id_page`,`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_slide`
--

INSERT INTO `pm_slide` (`id`, `lang`, `legend`, `url`, `id_page`, `checked`, `rank`) VALUES
(4, 1, '', '', 1, 1, 1),
(4, 2, '', '', 1, 1, 1),
(6, 1, '', '', 1, 1, 2),
(6, 2, '', '', 1, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `pm_slide_file`
--

DROP TABLE IF EXISTS `pm_slide_file`;
CREATE TABLE IF NOT EXISTS `pm_slide_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `id_item` int(11) NOT NULL,
  `home` int(11) DEFAULT '0',
  `checked` int(11) DEFAULT '1',
  `rank` int(11) DEFAULT '0',
  `file` varchar(250) DEFAULT NULL,
  `label` varchar(250) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`lang`),
  KEY `slide_file_fkey` (`id_item`,`lang`),
  KEY `slide_file_lang_fkey` (`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_slide_file`
--

INSERT INTO `pm_slide_file` (`id`, `lang`, `id_item`, `home`, `checked`, `rank`, `file`, `label`, `type`) VALUES
(9, 1, 6, NULL, 1, 2, '4.jpg', '', 'image'),
(9, 2, 6, NULL, 1, 2, '4.jpg', '', 'image'),
(10, 1, 4, NULL, 1, 3, 'content-nuur.jpg', NULL, 'image'),
(10, 2, 4, NULL, 1, 3, 'content-nuur.jpg', NULL, 'image');

-- --------------------------------------------------------

--
-- Table structure for table `pm_tag`
--

DROP TABLE IF EXISTS `pm_tag`;
CREATE TABLE IF NOT EXISTS `pm_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `value` varchar(250) DEFAULT NULL,
  `pages` varchar(250) DEFAULT NULL,
  `checked` int(11) DEFAULT '0',
  `rank` int(11) DEFAULT '0',
  PRIMARY KEY (`id`,`lang`),
  KEY `tag_lang_fkey` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `pm_text`
--

DROP TABLE IF EXISTS `pm_text`;
CREATE TABLE IF NOT EXISTS `pm_text` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`id`,`lang`),
  KEY `text_lang_fkey` (`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_text`
--

INSERT INTO `pm_text` (`id`, `lang`, `name`, `value`) VALUES
(1, 1, 'CREATION', 'Үүсгэх'),
(1, 2, 'CREATION', 'Creation'),
(2, 1, 'MESSAGE', 'Зурвас'),
(2, 2, 'MESSAGE', 'Message'),
(3, 1, 'EMAIL', 'И-мэйл'),
(3, 2, 'EMAIL', 'E-mail'),
(4, 1, 'PHONE', 'Утас.'),
(4, 2, 'PHONE', 'Phone'),
(5, 1, 'FAX', 'Факс'),
(5, 2, 'FAX', 'Fax'),
(6, 1, 'COMPANY', 'Байгууллага'),
(6, 2, 'COMPANY', 'Company'),
(7, 1, 'COPY_CODE', 'Код хуулах'),
(7, 2, 'COPY_CODE', 'Copy the code'),
(8, 1, 'SUBJECT', 'Сэдэв'),
(8, 2, 'SUBJECT', 'Subject'),
(9, 1, 'REQUIRED_FIELD', 'Талбаруудыг бөглөнө үү'),
(9, 2, 'REQUIRED_FIELD', 'Required field'),
(10, 1, 'INVALID_CAPTCHA_CODE', 'Хамгаалалтын код буруу байна'),
(10, 2, 'INVALID_CAPTCHA_CODE', 'Invalid security code'),
(11, 1, 'INVALID_EMAIL', 'И-мэйл хаяг буруу байна'),
(11, 2, 'INVALID_EMAIL', 'Invalid email address'),
(12, 1, 'FIRSTNAME', 'Нэр'),
(12, 2, 'FIRSTNAME', 'Firstname'),
(13, 1, 'LASTNAME', 'Овог'),
(13, 2, 'LASTNAME', 'Lastname'),
(14, 1, 'ADDRESS', 'Хаяг'),
(14, 2, 'ADDRESS', 'Address'),
(15, 1, 'POSTCODE', 'Шуудангийн дугаар'),
(15, 2, 'POSTCODE', 'Post code'),
(16, 1, 'CITY', 'Хот'),
(16, 2, 'CITY', 'City'),
(17, 1, 'MOBILE', 'Утасны дугаар'),
(17, 2, 'MOBILE', 'Mobile'),
(18, 1, 'ADD', 'Нэмэх'),
(18, 2, 'ADD', 'Add'),
(19, 1, 'EDIT', 'Засах'),
(19, 2, 'EDIT', 'Edit'),
(20, 1, 'INVALID_INPUT', 'Буруу утга'),
(20, 2, 'INVALID_INPUT', 'Invalid input'),
(21, 1, 'MAIL_DELIVERY_FAILURE', 'Зурвасыг илгээх үед алдаа гарлаа.'),
(21, 2, 'MAIL_DELIVERY_FAILURE', 'A failure occurred during the delivery of this message.'),
(22, 1, 'MAIL_DELIVERY_SUCCESS', 'Санал хүсэлтээ бидэнрүү илгээсэнд баярлалаа.\nБид тантай тун удахгүй холбогдох болно.'),
(22, 2, 'MAIL_DELIVERY_SUCCESS', 'Thank you for your interest, your message has been sent.\nWe will contact you as soon as possible.'),
(23, 1, 'SEND', 'Илгээх'),
(23, 2, 'SEND', 'Send'),
(24, 1, 'FORM_ERRORS', 'Дараах формууд алдаатай байна.'),
(24, 2, 'FORM_ERRORS', 'The following form contains some errors.'),
(25, 1, 'FROM_DATE', 'Хэзээ'),
(25, 2, 'FROM_DATE', 'From'),
(26, 1, 'TO_DATE', 'хүртэл'),
(26, 2, 'TO_DATE', 'till'),
(27, 1, 'FROM', 'Хэнээс'),
(27, 2, 'FROM', 'From'),
(28, 1, 'TO', 'Хэнд'),
(28, 2, 'TO', 'to'),
(29, 1, 'BOOK', 'Захиалга'),
(29, 2, 'BOOK', 'Book'),
(30, 1, 'READMORE', 'Дэлгэрэнгүй'),
(30, 2, 'READMORE', 'Read more'),
(31, 1, 'BACK', 'Буцах'),
(31, 2, 'BACK', 'Back'),
(32, 1, 'DISCOVER', 'Нээх'),
(32, 2, 'DISCOVER', 'Discover'),
(33, 1, 'ALL', 'Бүгд'),
(33, 2, 'ALL', 'All'),
(34, 1, 'ALL_RIGHTS_RESERVED', 'Бүх эрх хуулиар хамгаалагдсан'),
(34, 2, 'ALL_RIGHTS_RESERVED', 'All rights reserved'),
(35, 1, 'FORGOTTEN_PASSWORD', 'Нууц үгээ мартсан уу ?'),
(35, 2, 'FORGOTTEN_PASSWORD', 'Forgotten password?'),
(36, 1, 'LOG_IN', 'Нэвтрэх'),
(36, 2, 'LOG_IN', 'Log in'),
(37, 1, 'SIGN_UP', 'Бүртгүүлэх'),
(37, 2, 'SIGN_UP', 'Sign up'),
(38, 1, 'LOG_OUT', 'Гарах'),
(38, 2, 'LOG_OUT', 'Log out'),
(39, 1, 'SEARCH', 'Хайх'),
(39, 2, 'SEARCH', 'Search'),
(40, 1, 'RESET_PASS_SUCCESS', 'Таны и-мэйл хаягруу шинэ нууц үгийг илгээлээ.'),
(40, 2, 'RESET_PASS_SUCCESS', 'Your new password was sent to you on your e-mail.'),
(41, 1, 'PASS_TOO_SHORT', 'Нууц үг хамгийн багадаа 6 тэмдэгт байна'),
(41, 2, 'PASS_TOO_SHORT', 'The password must contain 6 characters at least'),
(42, 1, 'PASS_DONT_MATCH', 'Нууц үг таарахгүй байна'),
(42, 2, 'PASS_DONT_MATCH', 'The passwords don''t match'),
(43, 1, 'ACCOUNT_EXISTS', 'Энэхүү и-мэйл хаяг бүртгэлтэй байна'),
(43, 2, 'ACCOUNT_EXISTS', 'An account already exists with this e-mail'),
(44, 1, 'ACCOUNT_CREATED', 'Таны мэдээллийг амжилттай бүртгэлээ. Та и-мэйл хаягаа шалгана уу'),
(44, 2, 'ACCOUNT_CREATED', 'Your account has been created. You will receive an email to confirm your account.'),
(45, 1, 'INCORRECT_LOGIN', 'Нэвтрэх мэдээлэл буруу байна.'),
(45, 2, 'INCORRECT_LOGIN', 'Incorrect login information.'),
(46, 1, 'I_SIGN_UP', 'Бүртгүүлэх'),
(46, 2, 'I_SIGN_UP', 'I sign up'),
(47, 1, 'ALREADY_HAVE_ACCOUNT', 'Та бүртгэлтэй юу'),
(47, 2, 'ALREADY_HAVE_ACCOUNT', 'I already have an account'),
(48, 1, 'MY_ACCOUNT', 'Миний мэдээлэл'),
(48, 2, 'MY_ACCOUNT', 'My account'),
(49, 1, 'COMMENTS', 'Сэтгэгдэлүүд'),
(49, 2, 'COMMENTS', 'Comments'),
(50, 1, 'LET_US_KNOW', 'Санал бодлоо хуваалцах'),
(50, 2, 'LET_US_KNOW', 'Let us know what you think'),
(51, 1, 'COMMENT_SUCCESS', 'Бидэнтэй холбогдсонд баярлалаа. Таны хүсэлтийг хүлээн авлаа.'),
(51, 2, 'COMMENT_SUCCESS', 'Thank you for your interest, your comment will be checked.'),
(52, 1, 'NO_SEARCH_RESULT', 'Хайлт илэрцгүй. Хайх утгаа дахин нягтална уу (> 3 тэмдэгтээс багагүй) эсвэл өөр үгээр хайна уу.'),
(52, 2, 'NO_SEARCH_RESULT', 'No result. Check the spelling terms of search (> 3 characters) or try other words.'),
(53, 1, 'SEARCH_EXCEEDED', 'Хайлтын тоо гүйцсэн.'),
(53, 2, 'SEARCH_EXCEEDED', 'Number of researches exceeded.'),
(54, 1, 'SECONDS', 'секунд'),
(54, 2, 'SECONDS', 'seconds'),
(55, 1, 'FOR_A_TOTAL_OF', 'нийт'),
(55, 2, 'FOR_A_TOTAL_OF', 'for a total of'),
(56, 1, 'COMMENT', 'Сэтгэгдэл'),
(56, 2, 'COMMENT', 'Comment'),
(57, 1, 'VIEW', 'Харах'),
(57, 2, 'VIEW', 'View'),
(58, 1, 'RECENT_ARTICLES', 'Сүүлийн нийтлэлүүд'),
(58, 2, 'RECENT_ARTICLES', 'Recent articles'),
(59, 1, 'RSS_FEED', 'RSS'),
(59, 2, 'RSS_FEED', 'RSS feed'),
(60, 1, 'COUNTRY', 'Улс'),
(60, 2, 'COUNTRY', 'Country'),
(61, 1, 'ROOM', 'Өрөө'),
(61, 2, 'ROOM', 'Room'),
(62, 1, 'INCL_VAT', 'НӨАТ орсон'),
(62, 2, 'INCL_VAT', 'incl. VAT'),
(63, 1, 'NIGHTS', 'Хоног'),
(63, 2, 'NIGHTS', 'night(s)'),
(64, 1, 'ADULTS', 'Том хүн'),
(64, 2, 'ADULTS', 'Adults'),
(65, 1, 'CHILDREN', 'Хүүхэд'),
(65, 2, 'CHILDREN', 'Children'),
(66, 1, 'PERSONS', 'хүн(ий)'),
(66, 2, 'PERSONS', 'person(s)'),
(67, 1, 'CONTACT_DETAILS', 'Холбоо барих'),
(67, 2, 'CONTACT_DETAILS', 'Contact details'),
(68, 1, 'NO_AVAILABILITY', 'Боломжгүй'),
(68, 2, 'NO_AVAILABILITY', 'No availability'),
(69, 1, 'AVAILABILITIES', 'Боломжтой'),
(69, 2, 'AVAILABILITIES', 'Availabilities'),
(70, 1, 'CHECK', 'Шалгах'),
(70, 2, 'CHECK', 'Check'),
(71, 1, 'BOOKING_DETAILS', 'Захиалгын дэлгэрэнгүй'),
(71, 2, 'BOOKING_DETAILS', 'Booking details'),
(72, 1, 'SPECIAL_REQUESTS', 'Тусгай хүсэлт'),
(72, 2, 'SPECIAL_REQUESTS', 'Special requests'),
(73, 1, 'PREVIOUS_STEP', 'Өмнөх алхам'),
(73, 2, 'PREVIOUS_STEP', 'Previous step'),
(74, 1, 'CONFIRM_BOOKING', 'Захиалга баталгаажуулах'),
(74, 2, 'CONFIRM_BOOKING', 'Confirm the booking'),
(75, 1, 'ALSO_DISCOVER', 'Төстэй'),
(75, 2, 'ALSO_DISCOVER', 'Also discover'),
(76, 1, 'CHECK_PEOPLE', 'Сонгосон өрөөнийхөө хүний тоог нягтална уу.'),
(76, 2, 'CHECK_PEOPLE', 'Please verify the number of people for the chosen accommodation'),
(77, 1, 'BOOKING', 'Захиалга'),
(77, 2, 'BOOKING', 'Booking'),
(78, 1, 'NIGHT', 'Хоног'),
(78, 2, 'NIGHT', 'night'),
(79, 1, 'WEEK', 'долоо хоног'),
(79, 2, 'WEEK', 'week'),
(80, 1, 'EXTRA_SERVICES', 'Нэмэлт үйлчилгээ'),
(80, 2, 'EXTRA_SERVICES', 'Extra services'),
(81, 1, 'BOOKING_TERMS', ''),
(81, 2, 'BOOKING_TERMS', ''),
(82, 1, 'NEXT_STEP', 'Дараагийн алхам'),
(82, 2, 'NEXT_STEP', 'Next step'),
(83, 1, 'TOURIST_TAX', 'Жуулчны татвар'),
(83, 2, 'TOURIST_TAX', 'Tourist tax'),
(84, 1, 'CHECK_IN', 'Ирэх'),
(84, 2, 'CHECK_IN', 'Check in'),
(85, 1, 'CHECK_OUT', 'Гарах'),
(85, 2, 'CHECK_OUT', 'Check out'),
(86, 1, 'TOTAL', 'Нийт'),
(86, 2, 'TOTAL', 'Total'),
(87, 1, 'CAPACITY', 'Багтаамж'),
(87, 2, 'CAPACITY', 'Capacity'),
(88, 1, 'FACILITIES', 'Өрөөний эд зүйлс'),
(88, 2, 'FACILITIES', 'Facilities'),
(89, 1, 'PRICE', 'Үнэ'),
(89, 2, 'PRICE', 'Price'),
(90, 1, 'MORE_DETAILS', 'Дэлгэрэнгүй мэдээлэл'),
(90, 2, 'MORE_DETAILS', 'More details'),
(91, 1, 'FROM_PRICE', 'Эхлэх үнэ'),
(91, 2, 'FROM_PRICE', 'From'),
(92, 1, 'AMOUNT', 'Мөнгөн дүн'),
(92, 2, 'AMOUNT', 'Amount'),
(93, 1, 'PAY', 'Тооцоо шалгах'),
(93, 2, 'PAY', 'Check out'),
(94, 1, 'PAYMENT_PAYPAL_NOTICE', '"Тооцоо шалгах" товчлуур дээр дарснаар та, PayPal-ийн аюулгүй холбоос хуудасруу шилжих болно'),
(94, 2, 'PAYMENT_PAYPAL_NOTICE', 'Click on "Check Out" below, you will be redirected towards the secure site of PayPal'),
(95, 1, 'PAYMENT_CANCEL_NOTICE', 'Тооцоо цуцлагдлаа.<br>Манайхаар зочилсонд баярлалаа.'),
(95, 2, 'PAYMENT_CANCEL_NOTICE', 'The payment has been cancelled.<br>Thank you for your visit and see you soon.'),
(96, 1, 'PAYMENT_SUCCESS_NOTICE', 'Таны гүйлгээ амжилттай хийгдлээ.<br>Манайхаар үйлчлүүлсэнд баярлалаа !'),
(96, 2, 'PAYMENT_SUCCESS_NOTICE', 'Your payment has been successfully processed.<br>Thank you for your visit and see you soon!'),
(97, 1, 'BILLING_ADDRESS', 'Тооцооны хаяг'),
(97, 2, 'BILLING_ADDRESS', 'Billing address'),
(98, 1, 'DOWN_PAYMENT', 'Урьдчилгаа төлбөр'),
(98, 2, 'DOWN_PAYMENT', 'Down payment'),
(99, 1, 'PAYMENT_CHECK_NOTICE', 'Нийт үнийн дүн {amount}-г бидэнрүү илгээсэнд баярлалаа.<br>Таны захиалгыг хүлээн авсны дараа баталгаажуулах болно.<br>Манайхаар үйлчлүүлсэнд баярлалаа !'),
(99, 2, 'PAYMENT_CHECK_NOTICE', 'Thank you for sending a check of {amount} to "Panda Multi Resorts, Neeloafaru Magu, Maldives".<br>Your reservation will be confirmed upon receipt of the payment.<br>Thank you for your visit and see you soon!'),
(100, 1, 'PAYMENT_ARRIVAL_NOTICE', 'Нийт үнийн дүн {amount}-г хүлээн авлаа.<br>Манайхаар үйлчлүүлсэнд баярлалаа!'),
(100, 2, 'PAYMENT_ARRIVAL_NOTICE', 'Thank you for paying the balance of {amount} for your booking on your arrival.<br>Thank you for your visit and see you soon!'),
(101, 1, 'MAX_PEOPLE', 'Нийт хүний тоо'),
(101, 2, 'MAX_PEOPLE', 'Max people'),
(102, 1, 'VAT_AMOUNT', 'НӨАТ дүн'),
(102, 2, 'VAT_AMOUNT', 'VAT amount'),
(103, 1, 'MIN_NIGHTS', 'Доод тал нь (шөнө)'),
(103, 2, 'MIN_NIGHTS', 'Min nights'),
(104, 1, 'ROOMS', 'Өрөөнүүд'),
(104, 2, 'ROOMS', 'Rooms'),
(105, 1, 'RATINGS', 'Үнэлгээ'),
(105, 2, 'RATINGS', 'Rating(s)'),
(106, 1, 'MIN_PEOPLE', 'Х.бага хүний тоо'),
(106, 2, 'MIN_PEOPLE', 'Min people'),
(107, 1, 'HOTEL', 'Зочид Буудал'),
(107, 2, 'HOTEL', 'Hotel'),
(108, 1, 'MAKE_A_REQUEST', 'Хүсэлт гаргах'),
(108, 2, 'MAKE_A_REQUEST', 'Make a request'),
(109, 1, 'FULLNAME', 'Бүтэн нэр'),
(109, 2, 'FULLNAME', 'Full Name'),
(110, 1, 'PASSWORD', 'Нууц үг'),
(110, 2, 'PASSWORD', 'Password'),
(111, 1, 'LOG_IN_WITH_FACEBOOK', 'Facebook-ээр нэвтрэх'),
(111, 2, 'LOG_IN_WITH_FACEBOOK', 'Log in with Facebook'),
(112, 1, 'OR', 'Эсвэл'),
(112, 2, 'OR', 'Or'),
(113, 1, 'NEW_PASSWORD', 'Шинэ нууц үг'),
(113, 2, 'NEW_PASSWORD', 'New password'),
(114, 1, 'NEW_PASSWORD_NOTICE', 'Өөрийнхөө бүртгэлийн и-мэйл хаягаа оруулна уу. Таны и-мэйл хаягруу шинэ нууц үгийг илгээх болно.'),
(114, 2, 'NEW_PASSWORD_NOTICE', 'Please enter your e-mail address corresponding to your account. A new password will be sent to you by e-mail.'),
(115, 1, 'USERNAME', 'Хэрэглэгчийн нэр'),
(115, 2, 'USERNAME', 'Username'),
(116, 1, 'PASSWORD_CONFIRM', 'Нууц үгээ баталгаажуулна уу'),
(116, 2, 'PASSWORD_CONFIRM', 'Confirm password'),
(117, 1, 'USERNAME_EXISTS', 'Ийм нэртэй хэрэглэгчийн бүртгэл аль хэдийн үүссэн байна'),
(117, 2, 'USERNAME_EXISTS', 'An account already exists with this username'),
(118, 1, 'ACCOUNT_EDIT_SUCCESS', 'Таны бүртгэлийн мэдээлэл өөрчлөгдлөө.'),
(118, 2, 'ACCOUNT_EDIT_SUCCESS', 'Your account information have been changed.'),
(119, 1, 'ACCOUNT_EDIT_FAILURE', 'Таны бүртгэлийн мэдээллийг өөрчлөх үед алдаа гарлаа.'),
(119, 2, 'ACCOUNT_EDIT_FAILURE', 'An error occured during the modification of the account information.'),
(120, 1, 'ACCOUNT_CREATE_FAILURE', 'Бүртгэл үүсгэж чадсангүй.'),
(120, 2, 'ACCOUNT_CREATE_FAILURE', 'Failed to create account.'),
(121, 1, 'PAYMENT_CHECK', 'Дансаар'),
(121, 2, 'PAYMENT_CHECK', 'By check'),
(122, 1, 'PAYMENT_ARRIVAL', 'Биеэр'),
(122, 2, 'PAYMENT_ARRIVAL', 'On arrival'),
(123, 1, 'CHOOSE_PAYMENT', 'Төлбөрийн хэлбэрээ сонгоно уу'),
(123, 2, 'CHOOSE_PAYMENT', 'Choose a method of payment'),
(124, 1, 'PAYMENT_CREDIT_CARDS', 'Кредит карт'),
(124, 2, 'PAYMENT_CREDIT_CARDS', 'Credit cards'),
(125, 1, 'MAX_ADULTS', 'Том хүний тоо'),
(125, 2, 'MAX_ADULTS', 'Max adults'),
(126, 1, 'MAX_CHILDREN', 'Хүүхдийн тоо'),
(126, 2, 'MAX_CHILDREN', 'Max children'),
(127, 1, 'PAYMENT_CARDS_NOTICE', '"Төлбөр төлөх" товчлуур дээр дарснаар та, 2Checkout.com-ийн аюулгүй холбоос сайтруу шилжих болно'),
(127, 2, 'PAYMENT_CARDS_NOTICE', 'Click on "Check Out" below, you will be redirected towards the secure site of 2Checkout.com'),
(128, 1, 'COOKIES_NOTICE', 'Cookie нь хэрэглэгчийн сэтгэл ханамжийг дээшлүүлэх үүднээс ашигдагдаж байна. Та манай сайтыг ашигласнаар, cookie хэрэглээг зөвшөөрч байгаа болно.'),
(128, 2, 'COOKIES_NOTICE', 'Cookies help us provide better user experience. By using our website, you agree to the use of cookies.'),
(129, 1, 'DURATION', 'Үргэлжлэх хугацаа'),
(129, 2, 'DURATION', 'Duration'),
(130, 1, 'PERSON', 'Хүн'),
(130, 2, 'PERSON', 'Person'),
(131, 1, 'CHOOSE_A_DATE', 'Өдрөө сонгоно уу'),
(131, 2, 'CHOOSE_A_DATE', 'Choose a date'),
(132, 1, 'TIMESLOT', 'Цагийн хооронд'),
(132, 2, 'TIMESLOT', 'Time slot'),
(133, 1, 'ACTIVITIES', 'Үйл ажиллагаанууд'),
(133, 2, 'ACTIVITIES', 'Activities'),
(134, 1, 'DESTINATION', 'Чиглэл'),
(134, 2, 'DESTINATION', 'Destination'),
(135, 1, 'NO_HOTEL_FOUND', 'Зочид буудал олдсонгүй'),
(135, 2, 'NO_HOTEL_FOUND', 'No hotel found'),
(136, 1, 'FOR', 'for'),
(136, 2, 'FOR', 'for'),
(137, 1, 'FIND_ACTIVITIES_AND_TOURS', 'Бидний аялал, үйл ажиллагаатай танилцах'),
(137, 2, 'FIND_ACTIVITIES_AND_TOURS', 'Find out our activities and tours');

-- --------------------------------------------------------

--
-- Table structure for table `pm_user`
--

DROP TABLE IF EXISTS `pm_user`;
CREATE TABLE IF NOT EXISTS `pm_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `login` varchar(50) DEFAULT NULL,
  `pass` varchar(100) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `add_date` int(11) DEFAULT NULL,
  `edit_date` int(11) DEFAULT NULL,
  `checked` int(11) DEFAULT '0',
  `fb_id` varchar(50) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `token` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_user`
--

INSERT INTO pm_user (id, name, email, login, pass, type, add_date, edit_date, checked, fb_id, address, postcode, city, company, country, mobile, phone, token) VALUES
(1, 'Administrator', 'USER_EMAIL', 'USER_LOGIN', 'USER_PASS', 'administrator', INSTALL_DATE, INSTALL_DATE, 1, '', '', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `pm_widget`
--

DROP TABLE IF EXISTS `pm_widget`;
CREATE TABLE IF NOT EXISTS `pm_widget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` int(11) NOT NULL,
  `title` varchar(250) DEFAULT NULL,
  `showtitle` int(11) DEFAULT NULL,
  `pos` varchar(20) DEFAULT NULL,
  `allpages` int(11) DEFAULT NULL,
  `pages` varchar(250) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `content` longtext,
  `class` varchar(200) DEFAULT NULL,
  `checked` int(11) DEFAULT '0',
  `rank` int(11) DEFAULT '0',
  PRIMARY KEY (`id`,`lang`),
  KEY `widget_lang_fkey` (`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_widget`
--

INSERT INTO `pm_widget` (`id`, `lang`, `title`, `showtitle`, `pos`, `allpages`, `pages`, `type`, `content`, `class`, `checked`, `rank`) VALUES
(1, 1, 'Бидний тухай', 1, 'footer', 1, '', '', '<p style="text-align: justify;">Манай зочид буудал нь 3 одны зэрэглэлтэй ба энгийн болон хагас люкс, люкс 180 өрөөнд 330 хүн хүлээн авах хүчин чадалтай. Хотын төвд хэрнээ дуу чимээнээс алс, өндөрлөг хэсэгт мод бутаар хүрээлүүлэн, намуухан орчинд байрлах манай буудлаас Улаанбаатар хот болон үзэсгэлэнт Богд уул, хүрээлэн буй орчин сэтгэл татам харагддаг нь бидний нэг давуу тал юм. </p>\r\n', '', 1, 1),
(1, 2, 'About us', 1, 'footer', 1, '', '', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum eget auctor ipsum. Mauris pharetra neque a mauris commodo, at aliquam leo malesuada. Maecenas eget elit eu ligula rhoncus dapibus at non erat. In sed velit eget eros gravida consectetur varius imperdiet lectus.</p>\r\n', '', 1, 1);

--
-- Constraints for dumped tables
--

DROP TABLE IF EXISTS `pm_tree`;
CREATE TABLE IF NOT EXISTS `pm_tree` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(25) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` int(5) NOT NULL,
  `status` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

INSERT INTO `pm_tree` (`code`, `name`, `age`, `status`, `owner`, `description`) VALUES
            ('Layer2', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy112', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy115', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy116', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy117', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy118', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy119', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy121', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy217', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy218', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy219', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy220', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy221', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy222', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy223', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy241', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy224', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy225', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy226', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy227', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy228', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy229', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy230', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy231', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy232', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy233', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy234', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy235', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy236', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy237', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy238', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy239', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy240', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy148', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy149', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy150', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy143', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy144', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy145', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy146', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy147', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy141', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy129', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy130', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy131', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy133', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy135', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy136', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy142', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy137', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy138', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy139', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy134', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy132', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy151', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy152', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy153', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy154', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy155', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy156', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy157', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy158', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy159', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy160', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy161', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy162', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy163', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy164', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy165', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy166', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy167', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy168', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy169', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy170', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy171', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy172', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy173', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy174', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy175', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy176', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy180', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy181', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy182', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy183', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy184', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy185', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy186', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy187', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy188', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy189', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy190', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy191', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy192', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy193', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy194', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy195', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy196', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy197', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy198', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy199', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy200', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy201', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy202', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy203', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy204', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy205', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy206', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy207', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy208', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy209', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy210', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy211', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy212', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy213', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy216', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy214', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy215', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy177', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy178', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy179', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy123', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy125', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy126', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy127', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy124', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy128', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy122', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_4', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_5', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_7', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_7', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_9', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_9', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_10', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_4', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_5', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_6', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_7', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_8', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_9', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_16', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_16', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_17', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_19', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_19', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy120_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_20', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_20', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_22', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_22', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_24', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_24', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_25', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_25', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_26', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_26', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_27', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_27', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_29', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_29', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_30', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_30', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_31', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_31', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy113_32', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy114_32', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy108', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy110', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy109', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy111', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy110_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy109_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy111_0', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy110_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy109_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy111_1', 'Нарс', '3', 'Зарагдаагүй', '', ''),   
            ('Layer2copy104_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_0', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_1', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_2', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_3', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_7', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_7', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_8', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_9', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_9', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_9', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_6', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_7', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_16', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_16', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_10', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_11', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_19', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_19', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_12', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_20', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_20', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_13', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_22', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_22', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_14', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_15', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_24', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_24', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_25', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_25', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_16', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_26', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_26', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_27', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_27', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_18', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_29', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_29', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_19', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_30', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_30', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_31', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_31', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_20', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_32', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_32', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_21', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_33', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_33', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_34', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_34', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_22', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_35', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_35', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_23', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_36', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_36', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_37', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_37', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_24', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_38', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_38', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_25', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_39', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_39', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_40', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_40', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_26', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_41', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_41', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_27', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_42', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_42', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_43', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_43', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_28', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_44', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_44', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_29', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_45', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_45', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_46', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_46', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_30', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_47', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_47', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_31', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_48', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_48', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_49', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_49', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_32', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_50', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_50', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_33', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_51', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_51', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_52', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_52', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_34', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_53', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_53', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_35', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_54', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_54', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_55', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_55', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_36', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_56', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_56', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_37', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_57', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_57', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_58', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_58', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_38', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_59', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_59', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_39', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_60', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_60', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_61', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_61', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_40', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_62', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_62', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_41', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_63', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_63', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_64', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_64', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_42', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_65', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_65', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_43', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_66', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_66', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_67', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_67', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_44', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_68', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_68', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_45', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_69', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_69', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_70', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_70', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_46', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_71', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_71', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_47', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_72', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_72', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_73', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_73', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_48', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_74', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_74', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_49', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_75', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_75', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_50', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_76', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_76', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_77', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_77', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_51', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_78', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_78', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_79', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_79', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_52', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_80', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_80', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_81', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_81', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_53', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_82', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_82', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_83', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_83', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_54', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_84', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_84', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_85', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_85', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_55', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_86', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_86', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_87', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_87', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_56', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_88', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_88', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_89', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_89', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_57', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_90', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_90', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_91', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_91', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_58', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_92', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_92', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_93', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_93', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_59', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_94', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_94', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_95', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_95', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_60', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_96', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_96', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_97', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_97', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_61', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_98', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_98', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_99', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_99', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_62', 'Нарс', '3', 'Зарагдаагүй', '', ''),  
            ('Layer2copy104_100', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_100', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_101', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_101', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_63', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_102', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_102', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_103', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_103', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_64', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_104', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_104', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_105', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_105', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_65', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_106', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_106', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_107', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_107', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_66', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_108', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_108', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_109', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_109', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_67', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_110', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_110', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_111', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_111', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_68', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_112', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_112', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_113', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_113', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_69', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_114', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_114', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_115', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_115', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_70', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_116', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_116', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy140', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_117', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_117', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_71', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_118', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_118', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy140_0', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_119', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_119', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_72', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_120', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_120', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_121', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_121', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_73', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_122', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_122', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy140_1', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_123', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_123', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_74', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_124', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_124', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy140_2', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_125', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_125', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_75', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_126', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_126', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy140_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_127', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_127', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_76', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_128', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_128', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy140_4', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_129', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_129', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_77', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_130', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_130', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy140_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_131', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_131', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_78', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_132', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_132', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy140_6', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_133', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_133', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_79', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_134', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_134', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_135', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_135', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_136', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_136', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_80', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_137', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_137', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_81', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_138', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_138', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_139', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_139', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_82', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_140', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_140', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_83', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_141', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_141', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_142', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_142', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_84', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_143', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_143', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_85', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_144', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_144', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_145', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_145', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_86', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_146', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_146', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_87', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_147', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_147', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_148', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_148', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_88', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy104_149', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy106_149', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy105_89', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy107', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy3', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy6', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy7', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy9', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy12', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy13', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy16', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy19', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy20', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy22', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy24', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy25', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy26', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy27', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy29', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy30', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy31', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy32', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy33', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy34', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy35', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy36', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy37', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy38', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy39', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy40', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy41', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy42', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy43', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy44', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy45', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy46', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy47', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy48', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy49', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy50', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy51', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy52', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy53', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy54', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy55', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy56', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy57', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy58', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy59', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy60', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy61', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy62', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy63', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy64', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy65', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy66', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy67', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy68', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy69', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy70', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy71', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy72', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy73', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy74', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy75', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy76', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy77', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy78', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy79', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy80', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy81', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy82', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy83', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy84', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy85', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy86', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy87', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy88', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy89', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy90', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103', 'Нарс', '3', 'Зарагдаагүй', '', ''),     
            ('Layer2copy91_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_0', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_0', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_0', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_0', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_0', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_2', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_2', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_2', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_2', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_3', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_3', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_3', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_3', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_1', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_1', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_4', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_4', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_4', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_4', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_2', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_2', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_5', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_5', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_5', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_5', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_3', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_3', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_7', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_7', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_7', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_7', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_7', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_7', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_8', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_8', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_6', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_6', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_4', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_4', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_9', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_9', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_9', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_9', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_9', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_9', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_7', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_7', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_7', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_7', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_7', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_5', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_5', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_10', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_10', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_8', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_8', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_6', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_6', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_11', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_11', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_9', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_9', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_9', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_9', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_9', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_7', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_7', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_12', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_12', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_10', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_10', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_8', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_8', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_13', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_13', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_11', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_9', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_14', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_14', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_12', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_12', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_10', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_15', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_15', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_13', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_13', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_11', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_16', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_16', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_16', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_16', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_16', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_16', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_14', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_14', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_12', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_17', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_17', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_15', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_15', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_13', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_9', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_18', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_18', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_16', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_16', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_16', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_16', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_16', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_14', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_10', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_19', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_19', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_19', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_19', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_19', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_19', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_17', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_17', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_15', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_11', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_20', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_20', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_20', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_20', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_20', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_20', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_18', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_18', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_16', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_12', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_21', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_21', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_19', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_19', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_19', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_19', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_19', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_17', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_13', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_22', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_22', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_22', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_22', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_22', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_22', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_20', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_20', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_20', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_20', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_20', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_18', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_14', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_23', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_23', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_21', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_21', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_19', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_15', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_24', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_24', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_24', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_24', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_24', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_24', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_22', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_22', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_22', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_22', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_22', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_20', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_16', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_25', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_25', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_25', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_25', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_25', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_25', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_23', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_23', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_21', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_17', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_26', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_26', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_26', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_26', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_26', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_26', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_24', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_24', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_24', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_24', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_24', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_22', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_18', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_27', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_27', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_27', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_27', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_27', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_27', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_25', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_25', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_25', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_25', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_25', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_23', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_19', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_28', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_28', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_26', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_26', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_26', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_26', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_26', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_24', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_20', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_29', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_29', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_29', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_29', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_29', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_29', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_27', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_27', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_27', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_27', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_27', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_25', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy103_21', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_30', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_30', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_30', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_30', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_30', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_30', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy98_28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy99_28', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy100_28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy101_28', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy102_26', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_31', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_31', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_31', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_31', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_31', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_31', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_29', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_32', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_32', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_32', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_32', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_32', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_32', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_30', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_33', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_33', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_33', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_33', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_33', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_33', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_31', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_34', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_34', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_34', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_34', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_34', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_34', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_32', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_35', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_35', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_35', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_35', 'Нарс', '3', 'Зарагдаагүй', '', ''),   
            ('Layer2copy95_35', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_35', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_33', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_36', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_36', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_36', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_36', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_36', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_36', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_34', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_37', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_37', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_37', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_37', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_37', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_37', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_35', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_38', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_38', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_38', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_38', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_38', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_38', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_36', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_39', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_39', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_39', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_39', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_39', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_39', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_37', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_40', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_40', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_40', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_40', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_40', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_40', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_38', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_41', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_41', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_41', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_41', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_41', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_41', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_39', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_42', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_42', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_42', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_42', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_42', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_42', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_40', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_43', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_43', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_43', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_43', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_43', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_43', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_41', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_44', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_44', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_44', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_44', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_44', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_44', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_42', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_45', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_45', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_45', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_45', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_45', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_45', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_43', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_46', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_46', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_46', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_46', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_46', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_46', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_44', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_47', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_47', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_47', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_47', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_47', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_47', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_45', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_48', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_48', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_48', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_48', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_48', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_46', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_48', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_49', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_49', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_49', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_49', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_49', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_47', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_49', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_50', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_50', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_50', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_50', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_50', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_48', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_50', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_51', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_51', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_51', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_51', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_51', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_49', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_51', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_52', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_52', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_52', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_52', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_52', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_50', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_52', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_53', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_53', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_53', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_53', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_53', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_51', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_53', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_54', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_54', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_54', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_54', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_54', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_52', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_54', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_55', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_55', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_55', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_55', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_55', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_53', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_55', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_56', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_56', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_56', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_56', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_56', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_54', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_56', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_57', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_57', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_57', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_57', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_57', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_55', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_57', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_58', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_58', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_58', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_59', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_59', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_58', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_58', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_58', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_56', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_59', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_60', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_60', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_59', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_59', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_59', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_57', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_60', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_61', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_61', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_60', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_60', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_60', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_61', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_62', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy93_62', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_61', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy95_61', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_61', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_58', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_62', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_63', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_63', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_62', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_62', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_62', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_59', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_63', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_64', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_64', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy94_63', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_63', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy96_63', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy97_60', 'Нарс', '3', 'Зарагдсан', '', ''),
            ('Layer2copy91_64', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy92_65', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_65', 'Нарс', '3', 'Зарагдсан', '', ''),
            ('Layer2copy94_64', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy95_64', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_64', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_65', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_66', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_66', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_65', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy95_65', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy96_65', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy97_61', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy91_66', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy92_67', 'Голт бор', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy93_67', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy94_66', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy95_66', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy96_66', 'Нарс', '3', 'Зарагдсан', '', ''),
            ('Layer2copy91_67', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy92_68', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy93_68', 'Нарс', '3', 'Зарагдсан', '', ''),
            ('Layer2copy94_67', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy95_67', 'Голт бор', '3', 'Зарагдсан', '', ''),
            ('Layer2copy400', 'Нарс', '3', 'Зарагдсан', '', ''),    
            ('Layer2copy401', 'Нарс', '3', 'Зарагдсан', '', ''),    
            ('Layer2copy402', 'Нарс', '3', 'Зарагдаагүй', '', ''),    
            ('Layer2copy403', 'Нарс', '3', 'Зарагдаагүй', '', ''),    
            ('Layer2copy404', 'Нарс', '3', 'Зарагдаагүй', '', ''),    
            ('Layer2copy405', 'Нарс', '3', 'Зарагдаагүй', '', ''),    
            ('Layer2copy406', 'Нарс', '3', 'Зарагдаагүй', '', ''),    
            ('Layer2copy408', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy409', 'Нарс', '3', 'Зарагдаагүй', '', ''),
            ('Layer2copy410', 'Нарс', '3', 'Зарагдаагүй', '', '');
     
-- --------------------------------------------------------

--
-- Table structure for table `pm_tree`
--

DROP TABLE IF EXISTS `pm_tree_booking`;
CREATE TABLE IF NOT EXISTS `pm_tree_booking` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(25) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` int(5) NOT NULL,
  `status` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1377 DEFAULT CHARSET=utf8;

--
-- Constraints for table `pm_activity`
--
ALTER TABLE `pm_activity`
  ADD CONSTRAINT `activity_lang_fkey` FOREIGN KEY (`lang`) REFERENCES `pm_lang` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pm_activity_file`
--
ALTER TABLE `pm_activity_file`
  ADD CONSTRAINT `activity_file_fkey` FOREIGN KEY (`id_item`,`lang`) REFERENCES `pm_activity` (`id`, `lang`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `activity_file_lang_fkey` FOREIGN KEY (`lang`) REFERENCES `pm_lang` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pm_activity_session`
--
ALTER TABLE `pm_activity_session`
  ADD CONSTRAINT `activity_session_fkey` FOREIGN KEY (`id_activity`) REFERENCES `pm_activity` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pm_activity_session_hour`
--
ALTER TABLE `pm_activity_session_hour`
  ADD CONSTRAINT `activity_session_hour_fkey` FOREIGN KEY (`id_activity_session`) REFERENCES `pm_activity_session` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pm_article`
--
ALTER TABLE `pm_article`
  ADD CONSTRAINT `article_lang_fkey` FOREIGN KEY (`lang`) REFERENCES `pm_lang` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `article_page_fkey` FOREIGN KEY (`id_page`,`lang`) REFERENCES `pm_page` (`id`, `lang`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pm_article_file`
--
ALTER TABLE `pm_article_file`
  ADD CONSTRAINT `article_file_fkey` FOREIGN KEY (`id_item`,`lang`) REFERENCES `pm_article` (`id`, `lang`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `article_file_lang_fkey` FOREIGN KEY (`lang`) REFERENCES `pm_lang` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pm_booking_activity`
--
ALTER TABLE `pm_booking_activity`
  ADD CONSTRAINT `booking_activity_fkey` FOREIGN KEY (`id_booking`) REFERENCES `pm_booking` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pm_facility`
--
ALTER TABLE `pm_facility`
  ADD CONSTRAINT `facility_lang_fkey` FOREIGN KEY (`lang`) REFERENCES `pm_lang` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pm_facility_file`
--
ALTER TABLE `pm_facility_file`
  ADD CONSTRAINT `facility_file_fkey` FOREIGN KEY (`id_item`,`lang`) REFERENCES `pm_facility` (`id`, `lang`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `facility_file_lang_fkey` FOREIGN KEY (`lang`) REFERENCES `pm_lang` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pm_hotel`
--
ALTER TABLE `pm_hotel`
  ADD CONSTRAINT `hotel_lang_fkey` FOREIGN KEY (`lang`) REFERENCES `pm_lang` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pm_hotel_file`
--
ALTER TABLE `pm_hotel_file`
  ADD CONSTRAINT `hotel_file_fkey` FOREIGN KEY (`id_item`,`lang`) REFERENCES `pm_hotel` (`id`, `lang`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `hotel_file_lang_fkey` FOREIGN KEY (`lang`) REFERENCES `pm_lang` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pm_lang_file`
--
ALTER TABLE `pm_lang_file`
  ADD CONSTRAINT `lang_file_fkey` FOREIGN KEY (`id_item`) REFERENCES `pm_lang` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pm_media_file`
--
ALTER TABLE `pm_media_file`
  ADD CONSTRAINT `media_file_fkey` FOREIGN KEY (`id_item`) REFERENCES `pm_media` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
