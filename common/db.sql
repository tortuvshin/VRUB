-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 02, 2017 at 10:27 AM
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
(1, 1, 'Манай зочид буудал', '', 'plongee', '<p>Манай зочид буудал нь 4 одны зэрэглэлтэй ба энгийн болон люкс  24 өрөөнд 30 хүн хүлээн авах хүчин чадалтай. Хотын төвд хэрнээ дуу чимээнээс алс, өндөрлөг хэсэгт мод бутаар хүрээлүүлэн оршино. Буудлаас та ихэнх шаардлагатай газар руугаа зорчиход тун тохиромжтой: Тухайлбал замын ачаалал бага үед Чингис Хаан Олон Улсын нисэх буудал машинаар ердөө л 20 минут, Төмөр замын буудал аравхан  минут л явах бөгөөд хотын төв хэсэг Сүхбаатарын талбай, бизнес, худалдааны төвүүд, театр, музей, галларейнүүд ердөө л 30 минут алхах зайд байрлалтай.</p>\r\n', '', '', 5, 1, 1, 1, 1, 1478177832, 1483345213, NULL, NULL, 1, 0),
(1, 2, 'Dive into unknown waters!', '', 'scuba-diving', '<p>Lorem ipsum dolor sit amet consectetur adipiscing elit. Nullam molestie, nunc eu consequat varius, nisi metus iaculis nulla, nec ornare odio leo quis eros. Donec gravida eget velit eget pulvinar. Phasellus eget est quis est faucibus condimentum. Morbi tellus turpis, posuere vel tincidunt non, varius ac ante. Suspendisse in sem neque. Donec et faucibus justo. Nulla vitae nisl lacus. Fusce tincidunt quam nec vestibulum vestibulum. Vivamus vulputate, nunc non ullamcorper mattis, nunc orci imperdiet nulla, at laoreet ipsum nisl non leo. Aenean dapibus aliquet sem, ut lacinia magna mattis in.</p>\r\n\r\n<p>Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempor arcu eu sapien ullamcorper sodales. Aenean eu massa in ante commodo scelerisque vitae sed sapien. Aenean eu dictum arcu. Mauris ultricies dolor eu molestie egestas.<br />\r\nProin feugiat, nunc at pellentesque fringilla, ex purus efficitur dolor, ac pretium odio lacus id leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse eu ipsum viverra dolor tempus vehicula eu eu risus. Praesent rutrum dapibus odio, nec accumsan justo fermentum in. Ut quis neque a ante facilisis bibendum.</p>\r\n', '', '', 5, 1, 1, 1, 1, 1478177832, 1483345213, NULL, NULL, 1, 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_article_file`
--

INSERT INTO `pm_article_file` (`id`, `lang`, `id_item`, `home`, `checked`, `rank`, `file`, `label`, `type`) VALUES
(7, 1, 1, NULL, 1, 1, 'pers-1.jpg', '', 'image'),
(7, 2, 1, NULL, 1, 1, 'pers-1.jpg', '', 'image');

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
(1, 1, 1, 'Зочид буудал', '', 'taracode-hotel', 'Ulaanbaatar, Mongolia', 4.455734, 73.718185, 'contact@taracode.mn', '+976 99999999', '', '<p>24 өрөө              24 цагаар ажиллана<br />\r\nСпа                    24 цагаар ажиллана<br />\r\nРесторан            7-24<br />\r\nКофе шоп           7-24<br />\r\nХурлын заал       8-20<br />\r\nСувенир шоп       7-24<br />\r\n1 өрөө 100$ өглөөний цайтай<br />\r\nТара код зочид буудал болон Тара код кэмп нь өрнө дорны буддын шашин сонирхогчидод зориулж буддизмын бясалгал, нямба болон буддын сургааль, ном судруудыг хөтлөн явуулах үндсэн үйл ажиллагаа явуулна.</p>\r\n', '32,1,20,26,17,37,27,5,25,11,38', 1, 1, 1, 1),
(1, 2, 1, 'Royal Hotel', 'Luxury hotel overlooking the sea', 'royal-hotel', 'Ulaanbaatar, Mongolia', 4.455734, 73.718185, 'contact@taracode.mn', '+976 99999999', '', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean aliquet felis massa, sed condimentum ligula feugiat et. Etiam facilisis euismod dignissim. Vivamus facilisis lorem ut purus pellentesque, nec sollicitudin lorem suscipit. Fusce sed enim ultricies, venenatis nunc ut, pharetra nunc. Quisque sollicitudin egestas varius. Nulla aliquet magna sapien, id malesuada felis lobortis id. Vivamus vulputate sed enim sit amet eleifend. Vivamus sit amet felis id urna vulputate maximus. Nullam fringilla sed turpis non volutpat. Cras ultrices diam velit, ac volutpat odio semper at. Sed pulvinar turpis imperdiet sapien hendrerit pulvinar.</p>\r\n', '32,1,20,26,17,37,27,5,25,11,38', 1, 1, 1, 1),
(2, 1, 1, 'Амралтын газар', '', 'tourist-camp', ' Булган аймаг, Дашинчилэн сумын төв, Таракод амралтын газар', 98, 98, 'info@taracode.mn', '+976 99108569', 'www.taracode.mn', '<p>24 өрөө              24 цагаар ажиллана<br />\r\nСпа                      24 цагаар ажиллана<br />\r\nРесторан           7-24<br />\r\nКофе шоп          7-24<br />\r\nХурлын заал     8-20<br />\r\nСувенир шоп    7-24<br />\r\n1 өрөө 100$ өглөөний цайтай<br />\r\nТара код зочид буудал болон Тара код кэмп нь өрнө дорны буддын шашин сонирхогчидод зориулж буддизмын бясалгал, нямба болон буддын сургааль, ном судруудыг хөтлөн явуулах үндсэн үйл ажиллагаа явуулна.<br />\r\nТара код цэцэрлэгт хүрээлэн 1296 модоор бүтнэ<br />\r\n500 жилийн настай <br />\r\nЛого дүрсний дагуу бүтээсэн<br />\r\nГолоор нь хүн явах гудамжтай байна.<br />\r\nЖирэмсэн эмэгтэй голоор явж гарахад элдэв зовлонгүй амар мэнд төрдөг домогтой дарь-эхийн түлхүүр юм. <br />\r\n1294 модыг бүгдийг нь эзэнтэй болгож 1 модонд 100$ оор 500 жил гэрээ хийж өглөгийн эзний нэрийг 500 жилийн турш модны дэргэдэх пайз дээр байршуулна.<br />\r\nЦэцэрлэгт хүрээлэнгээ түшиглэсэн<br />\r\n21дарь-эхийг билэгдсэн 21 гэр бүхий тара код кэмп байна.<br />\r\nГэр өдрийн 100$ байна.<br />\r\nСаун душ<br />\r\nРесторан<br />\r\nЗочид буудал болон кэмп -д зохион байгуулагдах үйл ажиллагааны маршрут, хугацаа болон үнэ тухай бүртээ зарлагдаж байх болно.</p>\r\n', '', 1, 1, 1, 2),
(2, 2, 1, '', '', '', ' Булган аймаг, Дашинчилэн сумын төв, Таракод амралтын газар', 98, 98, 'info@taracode.mn', '+976 99108569', 'www.taracode.mn', '', '', 1, 1, 1, 2),
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_hotel_file`
--

INSERT INTO `pm_hotel_file` (`id`, `lang`, `id_item`, `home`, `checked`, `rank`, `file`, `label`, `type`) VALUES
(2, 1, 2, NULL, 1, 2, '6.jpg', '', 'image'),
(2, 2, 2, NULL, 1, 2, '6.jpg', '', 'image'),
(3, 1, 3, NULL, 1, 3, '9.jpg', '', 'image'),
(3, 2, 3, NULL, 1, 3, '9.jpg', '', 'image'),
(4, 1, 1, NULL, 1, 4, 'pers-1.jpg', '', 'image'),
(4, 2, 1, NULL, 1, 4, 'pers-1.jpg', '', 'image');

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
(1, 1, 'Нүүр', 'Нүүр', '', 'Нүүр', '', '', 'index,follow', '', '', '<blockquote class="text-center">\r\n<p>Таны амар амаглангын тулд бид ажиллана</p>\r\n</blockquote>\r\n', '', NULL, 'home', 'home', 1, 0, 1, 1, 1, 1478177832, 1483344996, 0, 0, 0),
(1, 2, 'Home', 'Lorem ipsum dolor sit amet', '', 'Lorem ipsum dolor sit amet', '', '', 'index,follow', '', '', '<blockquote class="text-center">\r\n<p>A man travels the world over in search of what he needs and returns home to find it.</p>\r\n</blockquote>\r\n\r\n<p class="text-muted" style="text-align: center;">- George A. Moore -</p>\r\n', '', NULL, 'home', 'home', 1, 0, 1, 1, 1, 1478177832, 1483344996, 0, 0, 0),
(2, 1, 'Холбоо барих', 'Холбоо барих', '', 'Холбоо барих', 'contact', '', 'index,follow', '', '', '', '', NULL, 'contact', '', 1, 1, 0, 1, 11, 1478177832, 1478177832, 0, 0, 0),
(2, 2, 'Contact', 'Contact', '', 'Contact', 'contact', '', 'index,follow', '', '', '', '', NULL, 'contact', '', 1, 1, 0, 1, 11, 1478177832, 1478177832, 0, 0, 0),
(3, 1, 'Үйлчилгээний нөхцөл', 'Үйлчилгээний нөхцөл', '', 'Үйлчилгээний нөхцөл', 'legal-notices', '', 'index,follow', '', '', '', '', NULL, 'page', '', 0, 1, 0, 1, 12, 1478177832, 1478289732, 0, 0, 0),
(3, 2, 'Legal notices', 'Legal notices', '', 'Legal notices', 'legal-notices', '', 'index,follow', '', '', '', '', NULL, 'page', '', 0, 1, 0, 1, 12, 1478177832, 1478289732, 0, 0, 0),
(4, 1, 'Сайтын бүтэц', 'Сайтын бүтэц', '', 'Сайтын бүтэц', 'site-map', '', 'index,follow', '', '', '', '', NULL, 'sitemap', '', 0, 1, 0, 1, 13, 1478177832, 1478289710, 0, 0, 0),
(4, 2, 'Sitemap', 'Sitemap', '', 'Sitemap', 'sitemap', '', 'index,follow', '', '', '', '', NULL, 'sitemap', '', 0, 1, 0, 1, 13, 1478177832, 1478289710, 0, 0, 0),
(5, 1, 'Бидний тухай', 'Бидний тухай', '', 'Бидний тухай', 'about-us', '', 'index,follow', '', '', '<p><strong>Tara Code hotel</strong></p>\r\n\r\n<p>24 өрөө              24 цагаар ажиллана<br />\r\nСпа                      24 цагаар ажиллана<br />\r\nРесторан           7-24<br />\r\nКофе шоп          7-24<br />\r\nХурлын заал     8-20<br />\r\nСувенир шоп    7-24<br />\r\n1 өрөө 100$ өглөөний цайтай<br />\r\nТара код зочид буудал болон Тара код кэмп нь өрнө дорны буддын шашин сонирхогчидод зориулж буддизмын бясалгал, нямба болон буддын сургааль, ном судруудыг хөтлөн явуулах үндсэн үйл ажиллагаа явуулна.<br />\r\nХаяг: БГ дүүрэг, 7 хороо, БАА-2, <br />\r\nУтас: 99108569<br />\r\nТара код цэцэрлэгт хүрээлэн 1296 модоор бүтнэ<br />\r\n500 жилийн настай <br />\r\nЛого дүрсний дагуу бүтээсэн<br />\r\nГолоор нь хүн явах гудамжтай байна.<br />\r\nЖирэмсэн эмэгтэй голоор явж гарахад элдэв зовлонгүй амар мэнд төрдөг домогтой дарь-эхийн түлхүүр юм. <br />\r\n1294 модыг бүгдийг нь эзэнтэй болгож 1 модонд 100$ оор 500 жил гэрээ хийж өглөгийн эзний нэрийг 500 жилийн турш модны дэргэдэх пайз дээр байршуулна.<br />\r\nЦэцэрлэгт хүрээлэнгээ түшиглэсэн<br />\r\n21дарь-эхийг билэгдсэн 21 гэр бүхий тара код кэмп байна.<br />\r\nГэр өдрийн 100$ байна.<br />\r\nСаун душ<br />\r\nРесторан<br />\r\nЗочид буудал болон кэмп -д зохион байгуулагдах үйл ажиллагааны маршрут, хугацаа болон үнэ тухай бүртээ зарлагдаж байх болно.</p>\r\n\r\n<p> </p>\r\n', '<p>Манай буудлын ихэнх албан хаагчид англи, япон, орос болон бусад гадаад хэлээр зочидтойгоо харилцах чадвартай. Бидний үйл ажиллагаа, үйлчилгээний чанарыг үнэлж Цэцэг зочид буудлыг Монгол Улсын Засгийн Газраас хамгийн сайн үйл ажиллагаатай аж ахуйн нэгжүүдийн нэгээр тодруулан шалгаруулж байсан.</p>\r\n', NULL, 'page', 'article', 1, 0, 0, 1, 2, 1478177832, 1483351249, 0, 0, 0),
(5, 2, 'About us', 'About us', '', 'About us', 'about-us', '', 'index,follow', '', '', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque fringilla vel est at rhoncus. Cras porttitor ligula vel magna vehicula accumsan. Mauris eget elit et sem commodo interdum. Aenean dolor sem, tincidunt ac neque tempus, hendrerit blandit lacus. Vivamus placerat nulla in mi tristique, fringilla fermentum nisl vehicula. Nullam quis eros non magna tincidunt interdum ac eu eros. Morbi malesuada pulvinar ultrices. Etiam bibendum efficitur risus, sit amet venenatis urna ullamcorper non. Proin fermentum malesuada tortor, vitae mattis sem scelerisque in. Curabitur rutrum leo at mi efficitur suscipit. Vivamus tristique lorem eros, sit amet malesuada augue sodales sed.</p>\r\n', '<p>Etiam bibendum efficitur risus, sit amet venenatis urna ullamcorper non. Proin fermentum malesuada tortor, vitae mattis sem scelerisque in. Curabitur rutrum leo at mi efficitur.</p>\r\n', NULL, 'page', 'article', 1, 0, 0, 1, 2, 1478177832, 1483351249, 0, 0, 0),
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_slide`
--

INSERT INTO `pm_slide` (`id`, `lang`, `legend`, `url`, `id_page`, `checked`, `rank`) VALUES
(7, 1, '', '', 1, 1, 1),
(7, 2, '', '', 1, 1, 1),
(8, 1, '', '', 1, 1, 2),
(8, 2, '', '', 1, 1, 2),
(9, 1, '', '', 1, 0, 3),
(9, 2, '', '', 1, 0, 3);

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_slide_file`
--

INSERT INTO `pm_slide_file` (`id`, `lang`, `id_item`, `home`, `checked`, `rank`, `file`, `label`, `type`) VALUES
(11, 1, 7, NULL, 1, 1, '6.jpg', NULL, 'image'),
(11, 2, 7, NULL, 1, 1, '6.jpg', NULL, 'image'),
(12, 1, 8, NULL, 1, 2, '1d9c68d99a03765d9d141b1e1cbd1a90.jpg', NULL, 'image'),
(12, 2, 8, NULL, 1, 2, '1d9c68d99a03765d9d141b1e1cbd1a90.jpg', NULL, 'image'),
(13, 1, 9, NULL, 1, 3, 'mongolia-portrait-ii-v1.jpg', NULL, 'image'),
(13, 2, 9, NULL, 1, 3, 'mongolia-portrait-ii-v1.jpg', NULL, 'image');

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
-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 09, 2017 at 07:20 AM
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
-- Table structure for table `pm_tree`
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
) ENGINE=MyISAM AUTO_INCREMENT=1377 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pm_tree`
--

INSERT INTO `pm_tree` (`id`, `code`, `name`, `age`, `status`, `owner`, `description`) VALUES
(6, 'Layer2', 'Нарс', 3, 'зарагдаагүй', '', ''),
(7, 'Layer2copy112', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(8, 'Layer2copy115', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(9, 'Layer2copy116', 'Нарс', 3, 'зарагдаагүй', '', ''),
(10, 'Layer2copy117', 'Нарс', 3, 'зарагдаагүй', '', ''),
(11, 'Layer2copy118', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(12, 'Layer2copy119', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(13, 'Layer2copy121', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(14, 'Layer2copy217', 'Нарс', 3, 'зарагдаагүй', '', ''),
(15, 'Layer2copy218', 'Нарс', 3, 'зарагдаагүй', '', ''),
(16, 'Layer2copy219', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(17, 'Layer2copy220', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(18, 'Layer2copy221', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(19, 'Layer2copy222', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(20, 'Layer2copy223', 'Нарс', 3, 'зарагдаагүй', '', ''),
(21, 'Layer2copy241', 'Нарс', 3, 'зарагдаагүй', '', ''),
(22, 'Layer2copy224', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(23, 'Layer2copy225', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(24, 'Layer2copy226', 'Нарс', 3, 'зарагдаагүй', '', ''),
(25, 'Layer2copy227', 'Нарс', 3, 'зарагдаагүй', '', ''),
(26, 'Layer2copy228', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(27, 'Layer2copy229', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(28, 'Layer2copy230', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(29, 'Layer2copy231', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(30, 'Layer2copy232', 'Нарс', 3, 'зарагдаагүй', '', ''),
(31, 'Layer2copy233', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(32, 'Layer2copy234', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(33, 'Layer2copy235', 'Нарс', 3, 'зарагдаагүй', '', ''),
(34, 'Layer2copy236', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(35, 'Layer2copy237', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(36, 'Layer2copy238', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(37, 'Layer2copy239', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(38, 'Layer2copy240', 'Нарс', 3, 'зарагдаагүй', '', ''),
(39, 'Layer2copy148', 'Нарс', 3, 'зарагдаагүй', '', ''),
(40, 'Layer2copy149', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(41, 'Layer2copy150', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(42, 'Layer2copy143', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(43, 'Layer2copy144', 'Нарс', 3, 'зарагдаагүй', '', ''),
(44, 'Layer2copy145', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(45, 'Layer2copy146', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(46, 'Layer2copy147', 'Нарс', 3, 'зарагдаагүй', '', ''),
(47, 'Layer2copy141', 'Нарс', 3, 'зарагдаагүй', '', ''),
(48, 'Layer2copy129', 'Нарс', 3, 'зарагдаагүй', '', ''),
(49, 'Layer2copy130', 'Нарс', 3, 'зарагдаагүй', '', ''),
(50, 'Layer2copy131', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(51, 'Layer2copy133', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(52, 'Layer2copy135', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(53, 'Layer2copy136', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(54, 'Layer2copy142', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(55, 'Layer2copy137', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(56, 'Layer2copy138', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(57, 'Layer2copy139', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(58, 'Layer2copy134', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(59, 'Layer2copy132', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(60, 'Layer2copy151', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(61, 'Layer2copy152', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(62, 'Layer2copy153', 'Нарс', 3, 'зарагдаагүй', '', ''),
(63, 'Layer2copy154', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(64, 'Layer2copy155', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(65, 'Layer2copy156', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(66, 'Layer2copy157', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(67, 'Layer2copy158', 'Нарс', 3, 'зарагдаагүй', '', ''),
(68, 'Layer2copy159', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(69, 'Layer2copy160', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(70, 'Layer2copy161', 'Нарс', 3, 'зарагдаагүй', '', ''),
(71, 'Layer2copy162', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(72, 'Layer2copy163', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(73, 'Layer2copy164', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(74, 'Layer2copy165', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(75, 'Layer2copy166', 'Нарс', 3, 'зарагдаагүй', '', ''),
(76, 'Layer2copy167', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(77, 'Layer2copy168', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(78, 'Layer2copy169', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(79, 'Layer2copy170', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(80, 'Layer2copy171', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(81, 'Layer2copy172', 'Нарс', 3, 'зарагдаагүй', '', ''),
(82, 'Layer2copy173', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(83, 'Layer2copy174', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(84, 'Layer2copy175', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(85, 'Layer2copy176', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(86, 'Layer2copy180', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(87, 'Layer2copy181', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(88, 'Layer2copy182', 'Нарс', 3, 'зарагдаагүй', '', ''),
(89, 'Layer2copy183', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(90, 'Layer2copy184', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(91, 'Layer2copy185', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(92, 'Layer2copy186', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(93, 'Layer2copy187', 'Нарс', 3, 'зарагдаагүй', '', ''),
(94, 'Layer2copy188', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(95, 'Layer2copy189', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(96, 'Layer2copy190', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(97, 'Layer2copy191', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(98, 'Layer2copy192', 'Нарс', 3, 'зарагдаагүй', '', ''),
(99, 'Layer2copy193', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(100, 'Layer2copy194', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(101, 'Layer2copy195', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(102, 'Layer2copy196', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(103, 'Layer2copy197', 'Нарс', 3, 'зарагдаагүй', '', ''),
(104, 'Layer2copy198', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(105, 'Layer2copy199', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(106, 'Layer2copy200', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(107, 'Layer2copy201', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(108, 'Layer2copy202', 'Нарс', 3, 'зарагдаагүй', '', ''),
(109, 'Layer2copy203', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(110, 'Layer2copy204', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(111, 'Layer2copy205', 'Нарс', 3, 'зарагдаагүй', '', ''),
(112, 'Layer2copy206', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(113, 'Layer2copy207', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(114, 'Layer2copy208', 'Нарс', 3, 'зарагдаагүй', '', ''),
(115, 'Layer2copy209', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(116, 'Layer2copy210', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(117, 'Layer2copy211', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(118, 'Layer2copy212', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(119, 'Layer2copy213', 'Нарс', 3, 'зарагдаагүй', '', ''),
(120, 'Layer2copy216', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(121, 'Layer2copy214', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(122, 'Layer2copy215', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(123, 'Layer2copy177', 'Нарс', 3, 'зарагдаагүй', '', ''),
(124, 'Layer2copy178', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(125, 'Layer2copy179', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(126, 'Layer2copy123', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(127, 'Layer2copy125', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(128, 'Layer2copy126', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(129, 'Layer2copy127', 'Нарс', 3, 'зарагдаагүй', '', ''),
(130, 'Layer2copy124', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(131, 'Layer2copy128', 'Нарс', 3, 'зарагдаагүй', '', ''),
(132, 'Layer2copy122', 'Нарс', 3, 'зарагдаагүй', '', ''),
(133, 'Layer2copy113', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(134, 'Layer2copy114', 'Нарс', 3, 'зарагдаагүй', '', ''),
(135, 'Layer2copy120', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(136, 'Layer2copy113_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(137, 'Layer2copy114_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(138, 'Layer2copy113_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(139, 'Layer2copy114_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(140, 'Layer2copy113_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(141, 'Layer2copy114_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(142, 'Layer2copy113_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(143, 'Layer2copy114_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(144, 'Layer2copy113_4', 'Нарс', 3, 'зарагдаагүй', '', ''),
(145, 'Layer2copy114_4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(146, 'Layer2copy120_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(147, 'Layer2copy113_5', 'Нарс', 3, 'зарагдаагүй', '', ''),
(148, 'Layer2copy114_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(149, 'Layer2copy113_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(150, 'Layer2copy114_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(151, 'Layer2copy120_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(152, 'Layer2copy113_7', 'Нарс', 3, 'зарагдаагүй', '', ''),
(153, 'Layer2copy114_7', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(154, 'Layer2copy113_8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(155, 'Layer2copy114_8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(156, 'Layer2copy120_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(157, 'Layer2copy113_9', 'Нарс', 3, 'зарагдаагүй', '', ''),
(158, 'Layer2copy114_9', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(159, 'Layer2copy120_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(160, 'Layer2copy113_10', 'Нарс', 3, 'зарагдаагүй', '', ''),
(161, 'Layer2copy114_10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(162, 'Layer2copy120_4', 'Нарс', 3, 'зарагдаагүй', '', ''),
(163, 'Layer2copy113_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(164, 'Layer2copy114_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(165, 'Layer2copy120_5', 'Нарс', 3, 'зарагдаагүй', '', ''),
(166, 'Layer2copy113_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(167, 'Layer2copy114_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(168, 'Layer2copy120_6', 'Нарс', 3, 'зарагдаагүй', '', ''),
(169, 'Layer2copy113_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(170, 'Layer2copy114_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(171, 'Layer2copy120_7', 'Нарс', 3, 'зарагдаагүй', '', ''),
(172, 'Layer2copy113_14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(173, 'Layer2copy114_14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(174, 'Layer2copy120_8', 'Нарс', 3, 'зарагдаагүй', '', ''),
(175, 'Layer2copy113_15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(176, 'Layer2copy114_15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(177, 'Layer2copy120_9', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(178, 'Layer2copy113_16', 'Нарс', 3, 'зарагдаагүй', '', ''),
(179, 'Layer2copy114_16', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(180, 'Layer2copy120_10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(181, 'Layer2copy113_17', 'Нарс', 3, 'зарагдаагүй', '', ''),
(182, 'Layer2copy114_17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(183, 'Layer2copy120_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(184, 'Layer2copy113_18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(185, 'Layer2copy114_18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(186, 'Layer2copy120_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(187, 'Layer2copy113_19', 'Нарс', 3, 'зарагдаагүй', '', ''),
(188, 'Layer2copy114_19', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(189, 'Layer2copy120_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(190, 'Layer2copy113_20', 'Нарс', 3, 'зарагдаагүй', '', ''),
(191, 'Layer2copy114_20', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(192, 'Layer2copy113_21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(193, 'Layer2copy114_21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(194, 'Layer2copy113_22', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(195, 'Layer2copy114_22', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(196, 'Layer2copy113_23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(197, 'Layer2copy114_23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(198, 'Layer2copy113_24', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(199, 'Layer2copy114_24', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(200, 'Layer2copy113_25', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(201, 'Layer2copy114_25', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(202, 'Layer2copy113_26', 'Нарс', 3, 'зарагдаагүй', '', ''),
(203, 'Layer2copy114_26', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(204, 'Layer2copy113_27', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(205, 'Layer2copy114_27', 'Нарс', 3, 'зарагдаагүй', '', ''),
(206, 'Layer2copy113_28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(207, 'Layer2copy114_28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(208, 'Layer2copy113_29', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(209, 'Layer2copy114_29', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(210, 'Layer2copy113_30', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(211, 'Layer2copy114_30', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(212, 'Layer2copy113_31', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(213, 'Layer2copy114_31', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(214, 'Layer2copy113_32', 'Нарс', 3, 'зарагдаагүй', '', ''),
(215, 'Layer2copy114_32', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(216, 'Layer2copy108', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(217, 'Layer2copy110', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(218, 'Layer2copy109', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(219, 'Layer2copy111', 'Нарс', 3, 'зарагдаагүй', '', ''),
(220, 'Layer2copy104', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(221, 'Layer2copy106', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(222, 'Layer2copy105', 'Нарс', 3, 'зарагдаагүй', '', ''),
(223, 'Layer2copy110_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(224, 'Layer2copy109_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(225, 'Layer2copy111_0', 'Нарс', 3, 'зарагдаагүй', '', ''),
(226, 'Layer2copy110_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(227, 'Layer2copy109_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(228, 'Layer2copy111_1', 'Нарс', 3, 'зарагдаагүй', '', ''),
(229, 'Layer2copy104_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(230, 'Layer2copy106_0', 'Голт бор', 3, 'зарагдаагүй', 'Голт бор', ''),
(231, 'Layer2copy104_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(232, 'Layer2copy106_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(233, 'Layer2copy105_0', 'Нарс', 3, 'зарагдаагүй', '', ''),
(234, 'Layer2copy104_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(235, 'Layer2copy106_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(236, 'Layer2copy105_1', 'Нарс', 3, 'зарагдаагүй', '', ''),
(237, 'Layer2copy104_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(238, 'Layer2copy106_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(239, 'Layer2copy104_4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(240, 'Layer2copy106_4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(241, 'Layer2copy105_2', 'Нарс', 3, 'зарагдаагүй', '', ''),
(242, 'Layer2copy104_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(243, 'Layer2copy106_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(244, 'Layer2copy105_3', 'Нарс', 3, 'зарагдаагүй', '', ''),
(245, 'Layer2copy104_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(246, 'Layer2copy106_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(247, 'Layer2copy104_7', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(248, 'Layer2copy106_7', 'Нарс', 3, 'зарагдаагүй', '', ''),
(249, 'Layer2copy105_4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(250, 'Layer2copy104_8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(251, 'Layer2copy106_8', 'Нарс', 3, 'зарагдаагүй', '', ''),
(252, 'Layer2copy105_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(253, 'Layer2copy104_9', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(254, 'Layer2copy106_9', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(255, 'Layer2copy105_9', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(256, 'Layer2copy105_6', 'Нарс', 3, 'зарагдаагүй', '', ''),
(257, 'Layer2copy104_10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(258, 'Layer2copy106_10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(259, 'Layer2copy104_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(260, 'Layer2copy106_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(261, 'Layer2copy105_7', 'Нарс', 3, 'зарагдаагүй', '', ''),
(262, 'Layer2copy104_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(263, 'Layer2copy106_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(264, 'Layer2copy104_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(265, 'Layer2copy106_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(266, 'Layer2copy105_8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(267, 'Layer2copy104_14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(268, 'Layer2copy106_14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(269, 'Layer2copy104_15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(270, 'Layer2copy106_15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(271, 'Layer2copy104_16', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(272, 'Layer2copy106_16', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(273, 'Layer2copy105_10', 'Нарс', 3, 'зарагдаагүй', '', ''),
(274, 'Layer2copy104_17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(275, 'Layer2copy106_17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(276, 'Layer2copy105_11', 'Нарс', 3, 'зарагдаагүй', '', ''),
(277, 'Layer2copy104_18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(278, 'Layer2copy106_18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(279, 'Layer2copy104_19', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(280, 'Layer2copy106_19', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(281, 'Layer2copy105_12', 'Нарс', 3, 'зарагдаагүй', '', ''),
(282, 'Layer2copy104_20', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(283, 'Layer2copy106_20', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(284, 'Layer2copy105_13', 'Нарс', 3, 'зарагдаагүй', '', ''),
(285, 'Layer2copy104_21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(286, 'Layer2copy106_21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(287, 'Layer2copy104_22', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(288, 'Layer2copy106_22', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(289, 'Layer2copy105_14', 'Нарс', 3, 'зарагдаагүй', '', ''),
(290, 'Layer2copy104_23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(291, 'Layer2copy106_23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(292, 'Layer2copy105_15', 'Нарс', 3, 'зарагдаагүй', '', ''),
(293, 'Layer2copy104_24', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(294, 'Layer2copy106_24', 'Нарс', 3, 'зарагдаагүй', '', ''),
(295, 'Layer2copy104_25', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(296, 'Layer2copy106_25', 'Нарс', 3, 'зарагдаагүй', '', ''),
(297, 'Layer2copy105_16', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(298, 'Layer2copy104_26', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(299, 'Layer2copy106_26', 'Нарс', 3, 'зарагдаагүй', '', ''),
(300, 'Layer2copy105_17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(301, 'Layer2copy104_27', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(302, 'Layer2copy106_27', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(303, 'Layer2copy104_28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(304, 'Layer2copy106_28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(305, 'Layer2copy105_18', 'Нарс', 3, 'зарагдаагүй', '', ''),
(306, 'Layer2copy104_29', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(307, 'Layer2copy106_29', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(308, 'Layer2copy105_19', 'Нарс', 3, 'зарагдаагүй', '', ''),
(309, 'Layer2copy104_30', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(310, 'Layer2copy106_30', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(311, 'Layer2copy104_31', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(312, 'Layer2copy106_31', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(313, 'Layer2copy105_20', 'Нарс', 3, 'зарагдаагүй', '', ''),
(314, 'Layer2copy104_32', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(315, 'Layer2copy106_32', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(316, 'Layer2copy105_21', 'Нарс', 3, 'зарагдаагүй', '', ''),
(317, 'Layer2copy104_33', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(318, 'Layer2copy106_33', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(319, 'Layer2copy104_34', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(320, 'Layer2copy106_34', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(321, 'Layer2copy105_22', 'Нарс', 3, 'зарагдаагүй', '', ''),
(322, 'Layer2copy104_35', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(323, 'Layer2copy106_35', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(324, 'Layer2copy105_23', 'Нарс', 3, 'зарагдаагүй', '', ''),
(325, 'Layer2copy104_36', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(326, 'Layer2copy106_36', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(327, 'Layer2copy104_37', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(328, 'Layer2copy106_37', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(329, 'Layer2copy105_24', 'Нарс', 3, 'зарагдаагүй', '', ''),
(330, 'Layer2copy104_38', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(331, 'Layer2copy106_38', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(332, 'Layer2copy105_25', 'Нарс', 3, 'зарагдаагүй', '', ''),
(333, 'Layer2copy104_39', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(334, 'Layer2copy106_39', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(335, 'Layer2copy104_40', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(336, 'Layer2copy106_40', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(337, 'Layer2copy105_26', 'Нарс', 3, 'зарагдаагүй', '', ''),
(338, 'Layer2copy104_41', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(339, 'Layer2copy106_41', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(340, 'Layer2copy105_27', 'Нарс', 3, 'зарагдаагүй', '', ''),
(341, 'Layer2copy104_42', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(342, 'Layer2copy106_42', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(343, 'Layer2copy104_43', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(344, 'Layer2copy106_43', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(345, 'Layer2copy105_28', 'Нарс', 3, 'зарагдаагүй', '', ''),
(346, 'Layer2copy104_44', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(347, 'Layer2copy106_44', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(348, 'Layer2copy105_29', 'Нарс', 3, 'зарагдаагүй', '', ''),
(349, 'Layer2copy104_45', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(350, 'Layer2copy106_45', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(351, 'Layer2copy104_46', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(352, 'Layer2copy106_46', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(353, 'Layer2copy105_30', 'Нарс', 3, 'зарагдаагүй', '', ''),
(354, 'Layer2copy104_47', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(355, 'Layer2copy106_47', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(356, 'Layer2copy105_31', 'Нарс', 3, 'зарагдаагүй', '', ''),
(357, 'Layer2copy104_48', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(358, 'Layer2copy106_48', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(359, 'Layer2copy104_49', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(360, 'Layer2copy106_49', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(361, 'Layer2copy105_32', 'Нарс', 3, 'зарагдаагүй', '', ''),
(362, 'Layer2copy104_50', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(363, 'Layer2copy106_50', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(364, 'Layer2copy105_33', 'Нарс', 3, 'зарагдаагүй', '', ''),
(365, 'Layer2copy104_51', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(366, 'Layer2copy106_51', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(367, 'Layer2copy104_52', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(368, 'Layer2copy106_52', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(369, 'Layer2copy105_34', 'Нарс', 3, 'зарагдаагүй', '', ''),
(370, 'Layer2copy104_53', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(371, 'Layer2copy106_53', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(372, 'Layer2copy105_35', 'Нарс', 3, 'зарагдаагүй', '', ''),
(373, 'Layer2copy104_54', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(374, 'Layer2copy106_54', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(375, 'Layer2copy104_55', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(376, 'Layer2copy106_55', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(377, 'Layer2copy105_36', 'Нарс', 3, 'зарагдаагүй', '', ''),
(378, 'Layer2copy104_56', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(379, 'Layer2copy106_56', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(380, 'Layer2copy105_37', 'Нарс', 3, 'зарагдаагүй', '', ''),
(381, 'Layer2copy104_57', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(382, 'Layer2copy106_57', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(383, 'Layer2copy104_58', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(384, 'Layer2copy106_58', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(385, 'Layer2copy105_38', 'Нарс', 3, 'зарагдаагүй', '', ''),
(386, 'Layer2copy104_59', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(387, 'Layer2copy106_59', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(388, 'Layer2copy105_39', 'Нарс', 3, 'зарагдаагүй', '', ''),
(389, 'Layer2copy104_60', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(390, 'Layer2copy106_60', 'Нарс', 3, 'зарагдаагүй', '', ''),
(391, 'Layer2copy104_61', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(392, 'Layer2copy106_61', 'Нарс', 3, 'зарагдаагүй', '', ''),
(393, 'Layer2copy105_40', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(394, 'Layer2copy104_62', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(395, 'Layer2copy106_62', 'Нарс', 3, 'зарагдаагүй', '', ''),
(396, 'Layer2copy105_41', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(397, 'Layer2copy104_63', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(398, 'Layer2copy106_63', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(399, 'Layer2copy104_64', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(400, 'Layer2copy106_64', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(401, 'Layer2copy105_42', 'Нарс', 3, 'зарагдаагүй', '', ''),
(402, 'Layer2copy104_65', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(403, 'Layer2copy106_65', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(404, 'Layer2copy105_43', 'Нарс', 3, 'зарагдаагүй', '', ''),
(405, 'Layer2copy104_66', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(406, 'Layer2copy106_66', 'Нарс', 3, 'зарагдаагүй', '', ''),
(407, 'Layer2copy104_67', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(408, 'Layer2copy106_67', 'Нарс', 3, 'зарагдаагүй', '', ''),
(409, 'Layer2copy105_44', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(410, 'Layer2copy104_68', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(411, 'Layer2copy106_68', 'Нарс', 3, 'зарагдаагүй', '', ''),
(412, 'Layer2copy105_45', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(413, 'Layer2copy104_69', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(414, 'Layer2copy106_69', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(415, 'Layer2copy104_70', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(416, 'Layer2copy106_70', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(417, 'Layer2copy105_46', 'Нарс', 3, 'зарагдаагүй', '', ''),
(418, 'Layer2copy104_71', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(419, 'Layer2copy106_71', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(420, 'Layer2copy105_47', 'Нарс', 3, 'зарагдаагүй', '', ''),
(421, 'Layer2copy104_72', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(422, 'Layer2copy106_72', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(423, 'Layer2copy104_73', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(424, 'Layer2copy106_73', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(425, 'Layer2copy105_48', 'Нарс', 3, 'зарагдаагүй', '', ''),
(426, 'Layer2copy104_74', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(427, 'Layer2copy106_74', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(428, 'Layer2copy105_49', 'Нарс', 3, 'зарагдаагүй', '', ''),
(429, 'Layer2copy104_75', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(430, 'Layer2copy106_75', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(431, 'Layer2copy105_50', 'Нарс', 3, 'зарагдаагүй', '', ''),
(432, 'Layer2copy104_76', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(433, 'Layer2copy106_76', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(434, 'Layer2copy104_77', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(435, 'Layer2copy106_77', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(436, 'Layer2copy105_51', 'Нарс', 3, 'зарагдаагүй', '', ''),
(437, 'Layer2copy104_78', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(438, 'Layer2copy106_78', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(439, 'Layer2copy104_79', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(440, 'Layer2copy106_79', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(441, 'Layer2copy105_52', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(442, 'Layer2copy104_80', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(443, 'Layer2copy106_80', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(444, 'Layer2copy104_81', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(445, 'Layer2copy106_81', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(446, 'Layer2copy105_53', 'Нарс', 3, 'зарагдаагүй', '', ''),
(447, 'Layer2copy104_82', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(448, 'Layer2copy106_82', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(449, 'Layer2copy104_83', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(450, 'Layer2copy106_83', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(451, 'Layer2copy105_54', 'Нарс', 3, 'зарагдаагүй', '', ''),
(452, 'Layer2copy104_84', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(453, 'Layer2copy106_84', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(454, 'Layer2copy104_85', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(455, 'Layer2copy106_85', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(456, 'Layer2copy105_55', 'Нарс', 3, 'зарагдаагүй', '', ''),
(457, 'Layer2copy104_86', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(458, 'Layer2copy106_86', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(459, 'Layer2copy104_87', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(460, 'Layer2copy106_87', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(461, 'Layer2copy105_56', 'Нарс', 3, 'зарагдаагүй', '', ''),
(462, 'Layer2copy104_88', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(463, 'Layer2copy106_88', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(464, 'Layer2copy104_89', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(465, 'Layer2copy106_89', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(466, 'Layer2copy105_57', 'Нарс', 3, 'зарагдаагүй', '', ''),
(467, 'Layer2copy104_90', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(468, 'Layer2copy106_90', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(469, 'Layer2copy104_91', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(470, 'Layer2copy106_91', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(471, 'Layer2copy105_58', 'Нарс', 3, 'зарагдаагүй', '', ''),
(472, 'Layer2copy104_92', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(473, 'Layer2copy106_92', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(474, 'Layer2copy104_93', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(475, 'Layer2copy106_93', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(476, 'Layer2copy105_59', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(477, 'Layer2copy104_94', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(478, 'Layer2copy106_94', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(479, 'Layer2copy104_95', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(480, 'Layer2copy106_95', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(481, 'Layer2copy105_60', 'Нарс', 3, 'зарагдаагүй', '', ''),
(482, 'Layer2copy104_96', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(483, 'Layer2copy106_96', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(484, 'Layer2copy104_97', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(485, 'Layer2copy106_97', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(486, 'Layer2copy105_61', 'Нарс', 3, 'зарагдаагүй', '', ''),
(487, 'Layer2copy104_98', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(488, 'Layer2copy106_98', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(489, 'Layer2copy104_99', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(490, 'Layer2copy106_99', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(491, 'Layer2copy105_62', 'Нарс', 3, 'зарагдаагүй', '', ''),
(492, 'Layer2copy104_100', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(493, 'Layer2copy106_100', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(494, 'Layer2copy104_101', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(495, 'Layer2copy106_101', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(496, 'Layer2copy105_63', 'Нарс', 3, 'зарагдаагүй', '', ''),
(497, 'Layer2copy104_102', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(498, 'Layer2copy106_102', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(499, 'Layer2copy104_103', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(500, 'Layer2copy106_103', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(501, 'Layer2copy105_64', 'Нарс', 3, 'зарагдаагүй', '', ''),
(502, 'Layer2copy104_104', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(503, 'Layer2copy106_104', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(504, 'Layer2copy104_105', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(505, 'Layer2copy106_105', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(506, 'Layer2copy105_65', 'Нарс', 3, 'зарагдаагүй', '', ''),
(507, 'Layer2copy104_106', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(508, 'Layer2copy106_106', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(509, 'Layer2copy104_107', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(510, 'Layer2copy106_107', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(511, 'Layer2copy105_66', 'Нарс', 3, 'зарагдаагүй', '', ''),
(512, 'Layer2copy104_108', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(513, 'Layer2copy106_108', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(514, 'Layer2copy104_109', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(515, 'Layer2copy106_109', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(516, 'Layer2copy105_67', 'Нарс', 3, 'зарагдаагүй', '', ''),
(517, 'Layer2copy104_110', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(518, 'Layer2copy106_110', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(519, 'Layer2copy104_111', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(520, 'Layer2copy106_111', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(521, 'Layer2copy105_68', 'Нарс', 3, 'зарагдаагүй', '', ''),
(522, 'Layer2copy104_112', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(523, 'Layer2copy106_112', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(524, 'Layer2copy104_113', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(525, 'Layer2copy106_113', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(526, 'Layer2copy105_69', 'Нарс', 3, 'зарагдаагүй', '', ''),
(527, 'Layer2copy104_114', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(528, 'Layer2copy106_114', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(529, 'Layer2copy104_115', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(530, 'Layer2copy106_115', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(531, 'Layer2copy105_70', 'Нарс', 3, 'зарагдаагүй', '', ''),
(532, 'Layer2copy104_116', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(533, 'Layer2copy106_116', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(534, 'Layer2copy140', 'Нарс', 3, 'зарагдаагүй', '', ''),
(535, 'Layer2copy104_117', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(536, 'Layer2copy106_117', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(537, 'Layer2copy105_71', 'Нарс', 3, 'зарагдаагүй', '', ''),
(538, 'Layer2copy104_118', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(539, 'Layer2copy106_118', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(540, 'Layer2copy140_0', 'Нарс', 3, 'зарагдаагүй', '', ''),
(541, 'Layer2copy104_119', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(542, 'Layer2copy106_119', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(543, 'Layer2copy105_72', 'Нарс', 3, 'зарагдаагүй', '', ''),
(544, 'Layer2copy104_120', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(545, 'Layer2copy106_120', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(546, 'Layer2copy104_121', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(547, 'Layer2copy106_121', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(548, 'Layer2copy105_73', 'Нарс', 3, 'зарагдаагүй', '', ''),
(549, 'Layer2copy104_122', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(550, 'Layer2copy106_122', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(551, 'Layer2copy140_1', 'Нарс', 3, 'зарагдаагүй', '', ''),
(552, 'Layer2copy104_123', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(553, 'Layer2copy106_123', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(554, 'Layer2copy105_74', 'Нарс', 3, 'зарагдаагүй', '', ''),
(555, 'Layer2copy104_124', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(556, 'Layer2copy106_124', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(557, 'Layer2copy140_2', 'Нарс', 3, 'зарагдаагүй', '', ''),
(558, 'Layer2copy104_125', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(559, 'Layer2copy106_125', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(560, 'Layer2copy105_75', 'Нарс', 3, 'зарагдаагүй', '', ''),
(561, 'Layer2copy104_126', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(562, 'Layer2copy106_126', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(563, 'Layer2copy140_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(564, 'Layer2copy104_127', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(565, 'Layer2copy106_127', 'Нарс', 3, 'зарагдаагүй', '', ''),
(566, 'Layer2copy105_76', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(567, 'Layer2copy104_128', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(568, 'Layer2copy106_128', 'Нарс', 3, 'зарагдаагүй', '', ''),
(569, 'Layer2copy140_4', 'Нарс', 3, 'зарагдаагүй', '', ''),
(570, 'Layer2copy104_129', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(571, 'Layer2copy106_129', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(572, 'Layer2copy105_77', 'Нарс', 3, 'зарагдаагүй', '', ''),
(573, 'Layer2copy104_130', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(574, 'Layer2copy106_130', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(575, 'Layer2copy140_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(576, 'Layer2copy104_131', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(577, 'Layer2copy106_131', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(578, 'Layer2copy105_78', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(579, 'Layer2copy104_132', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(580, 'Layer2copy106_132', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(581, 'Layer2copy140_6', 'Нарс', 3, 'зарагдаагүй', '', ''),
(582, 'Layer2copy104_133', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(583, 'Layer2copy106_133', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(584, 'Layer2copy105_79', 'Нарс', 3, 'зарагдаагүй', '', ''),
(585, 'Layer2copy104_134', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(586, 'Layer2copy106_134', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(587, 'Layer2copy104_135', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(588, 'Layer2copy106_135', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(589, 'Layer2copy104_136', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(590, 'Layer2copy106_136', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(591, 'Layer2copy105_80', 'Нарс', 3, 'зарагдаагүй', '', ''),
(592, 'Layer2copy104_137', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(593, 'Layer2copy106_137', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(594, 'Layer2copy105_81', 'Нарс', 3, 'зарагдаагүй', '', ''),
(595, 'Layer2copy104_138', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(596, 'Layer2copy106_138', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(597, 'Layer2copy104_139', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(598, 'Layer2copy106_139', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(599, 'Layer2copy105_82', 'Нарс', 3, 'зарагдаагүй', '', ''),
(600, 'Layer2copy104_140', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(601, 'Layer2copy106_140', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(602, 'Layer2copy105_83', 'Нарс', 3, 'зарагдаагүй', '', ''),
(603, 'Layer2copy104_141', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(604, 'Layer2copy106_141', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(605, 'Layer2copy104_142', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(606, 'Layer2copy106_142', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(607, 'Layer2copy105_84', 'Нарс', 3, 'зарагдаагүй', '', ''),
(608, 'Layer2copy104_143', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(609, 'Layer2copy106_143', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(610, 'Layer2copy105_85', 'Нарс', 3, 'зарагдаагүй', '', ''),
(611, 'Layer2copy104_144', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(612, 'Layer2copy106_144', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(613, 'Layer2copy104_145', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(614, 'Layer2copy106_145', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(615, 'Layer2copy105_86', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(616, 'Layer2copy104_146', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(617, 'Layer2copy106_146', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(618, 'Layer2copy105_87', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(619, 'Layer2copy104_147', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(620, 'Layer2copy106_147', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(621, 'Layer2copy104_148', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(622, 'Layer2copy106_148', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(623, 'Layer2copy105_88', 'Нарс', 3, 'зарагдаагүй', '', ''),
(624, 'Layer2copy104_149', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(625, 'Layer2copy106_149', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(626, 'Layer2copy105_89', 'Нарс', 3, 'зарагдаагүй', '', ''),
(627, 'Layer2copy', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(628, 'Layer2copy107', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(629, 'Layer2copy2', 'Голт бор', 3, 'зарагдаагүй', 'Голт бор', ''),
(630, 'Layer2copy3', 'Нарс', 3, 'зарагдаагүй', '', ''),
(631, 'Layer2copy4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(632, 'Layer2copy5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(633, 'Layer2copy6', 'Нарс', 3, 'зарагдаагүй', '', ''),
(634, 'Layer2copy7', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(635, 'Layer2copy8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(636, 'Layer2copy9', 'Нарс', 3, 'зарагдаагүй', '', ''),
(637, 'Layer2copy10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(638, 'Layer2copy11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(639, 'Layer2copy12', 'Нарс', 3, 'зарагдаагүй', 'Нарс', ''),
(640, 'Layer2copy13', 'Нарс', 3, 'зарагдаагүй', '', ''),
(641, 'Layer2copy14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(642, 'Layer2copy15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(643, 'Layer2copy16', 'Нарс', 3, 'зарагдаагүй', '', ''),
(644, 'Layer2copy17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(645, 'Layer2copy18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(646, 'Layer2copy19', 'Нарс', 3, 'зарагдаагүй', '', ''),
(647, 'Layer2copy20', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(648, 'Layer2copy21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(649, 'Layer2copy22', 'Нарс', 3, 'зарагдаагүй', '', ''),
(650, 'Layer2copy23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(651, 'Layer2copy24', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(652, 'Layer2copy25', 'Нарс', 3, 'зарагдаагүй', '', ''),
(653, 'Layer2copy26', 'Нарс', 3, 'зарагдаагүй', '', ''),
(654, 'Layer2copy27', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(655, 'Layer2copy28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(656, 'Layer2copy29', 'Нарс', 3, 'зарагдаагүй', '', ''),
(657, 'Layer2copy30', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(658, 'Layer2copy31', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(659, 'Layer2copy32', 'Нарс', 3, 'зарагдаагүй', '', ''),
(660, 'Layer2copy33', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(661, 'Layer2copy34', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(662, 'Layer2copy35', 'Нарс', 3, 'зарагдаагүй', '', ''),
(663, 'Layer2copy36', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(664, 'Layer2copy37', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(665, 'Layer2copy38', 'Нарс', 3, 'зарагдаагүй', '', ''),
(666, 'Layer2copy39', 'Нарс', 3, 'зарагдаагүй', '', ''),
(667, 'Layer2copy40', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(668, 'Layer2copy41', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(669, 'Layer2copy42', 'Нарс', 3, 'зарагдаагүй', '', ''),
(670, 'Layer2copy43', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(671, 'Layer2copy44', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(672, 'Layer2copy45', 'Нарс', 3, 'зарагдаагүй', 'Нарс', ''),
(673, 'Layer2copy46', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(674, 'Layer2copy47', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(675, 'Layer2copy48', 'Нарс', 3, 'зарагдаагүй', '', ''),
(676, 'Layer2copy49', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(677, 'Layer2copy50', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(678, 'Layer2copy51', 'Нарс', 3, 'зарагдаагүй', '', ''),
(679, 'Layer2copy52', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(680, 'Layer2copy53', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(681, 'Layer2copy54', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(682, 'Layer2copy55', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(683, 'Layer2copy56', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(684, 'Layer2copy57', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(685, 'Layer2copy58', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(686, 'Layer2copy59', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(687, 'Layer2copy60', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(688, 'Layer2copy61', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(689, 'Layer2copy62', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(690, 'Layer2copy63', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(691, 'Layer2copy64', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(692, 'Layer2copy65', 'Нарс', 3, 'зарагдаагүй', '', ''),
(693, 'Layer2copy66', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(694, 'Layer2copy67', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(695, 'Layer2copy68', 'Нарс', 3, 'зарагдаагүй', '', ''),
(696, 'Layer2copy69', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(697, 'Layer2copy70', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(698, 'Layer2copy71', 'Нарс', 3, 'зарагдаагүй', '', ''),
(699, 'Layer2copy72', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(700, 'Layer2copy73', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(701, 'Layer2copy74', 'Нарс', 3, 'зарагдаагүй', '', ''),
(702, 'Layer2copy75', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(703, 'Layer2copy76', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(704, 'Layer2copy77', 'Нарс', 3, 'зарагдаагүй', '', ''),
(705, 'Layer2copy78', 'Нарс', 3, 'зарагдаагүй', '', ''),
(706, 'Layer2copy79', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(707, 'Layer2copy80', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(708, 'Layer2copy81', 'Нарс', 3, 'зарагдаагүй', '', ''),
(709, 'Layer2copy82', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(710, 'Layer2copy83', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(711, 'Layer2copy84', 'Нарс', 3, 'зарагдаагүй', '', ''),
(712, 'Layer2copy85', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(713, 'Layer2copy86', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(714, 'Layer2copy87', 'Нарс', 3, 'зарагдаагүй', '', ''),
(715, 'Layer2copy88', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(716, 'Layer2copy89', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(717, 'Layer2copy90', 'Нарс', 3, 'зарагдаагүй', '', ''),
(718, 'Layer2copy91', 'Нарс', 3, 'зарагдаагүй', '', ''),
(719, 'Layer2copy92', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(720, 'Layer2copy93', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(721, 'Layer2copy94', 'Нарс', 3, 'зарагдаагүй', '', ''),
(722, 'Layer2copy95', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(723, 'Layer2copy96', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(724, 'Layer2copy97', 'Нарс', 3, 'зарагдаагүй', '', ''),
(725, 'Layer2copy98', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(726, 'Layer2copy99', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(727, 'Layer2copy100', 'Нарс', 3, 'зарагдаагүй', '', ''),
(728, 'Layer2copy101', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(729, 'Layer2copy102', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(730, 'Layer2copy103', 'Нарс', 3, 'зарагдаагүй', '', ''),
(731, 'Layer2copy91_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(732, 'Layer2copy92_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(733, 'Layer2copy93_0', 'Нарс', 3, 'зарагдаагүй', '', ''),
(734, 'Layer2copy94_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(735, 'Layer2copy95_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(736, 'Layer2copy96_0', 'Нарс', 3, 'зарагдаагүй', '', ''),
(737, 'Layer2copy97_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(738, 'Layer2copy98_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(739, 'Layer2copy99_0', 'Нарс', 3, 'зарагдаагүй', '', ''),
(740, 'Layer2copy100_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(741, 'Layer2copy101_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(742, 'Layer2copy102_0', 'Нарс', 3, 'зарагдаагүй', '', ''),
(743, 'Layer2copy103_0', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(744, 'Layer2copy91_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(745, 'Layer2copy92_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(746, 'Layer2copy93_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(747, 'Layer2copy94_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(748, 'Layer2copy95_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(749, 'Layer2copy96_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(750, 'Layer2copy97_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(751, 'Layer2copy98_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(752, 'Layer2copy99_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(753, 'Layer2copy100_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(754, 'Layer2copy101_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(755, 'Layer2copy91_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(756, 'Layer2copy92_2', 'Нарс', 3, 'зарагдаагүй', '', ''),
(757, 'Layer2copy93_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(758, 'Layer2copy94_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(759, 'Layer2copy95_2', 'Нарс', 3, 'зарагдаагүй', '', ''),
(760, 'Layer2copy96_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(761, 'Layer2copy97_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(762, 'Layer2copy98_2', 'Нарс', 3, 'зарагдаагүй', '', ''),
(763, 'Layer2copy99_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(764, 'Layer2copy100_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(765, 'Layer2copy101_2', 'Нарс', 3, 'зарагдаагүй', '', ''),
(766, 'Layer2copy91_3', 'Нарс', 3, 'зарагдаагүй', '', ''),
(767, 'Layer2copy92_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(768, 'Layer2copy93_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(769, 'Layer2copy94_3', 'Нарс', 3, 'зарагдаагүй', '', ''),
(770, 'Layer2copy95_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(771, 'Layer2copy96_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(772, 'Layer2copy97_3', 'Нарс', 3, 'зарагдаагүй', '', ''),
(773, 'Layer2copy98_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(774, 'Layer2copy99_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(775, 'Layer2copy100_3', 'Нарс', 3, 'зарагдаагүй', '', ''),
(776, 'Layer2copy101_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(777, 'Layer2copy102_1', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(778, 'Layer2copy103_1', 'Нарс', 3, 'зарагдаагүй', '', ''),
(779, 'Layer2copy91_4', 'Нарс', 3, 'зарагдаагүй', '', ''),
(780, 'Layer2copy92_4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(781, 'Layer2copy93_4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(782, 'Layer2copy94_4', 'Нарс', 3, 'зарагдаагүй', '', ''),
(783, 'Layer2copy95_4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(784, 'Layer2copy96_4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(785, 'Layer2copy97_4', 'Нарс', 3, 'зарагдаагүй', '', ''),
(786, 'Layer2copy98_4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(787, 'Layer2copy99_4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(788, 'Layer2copy100_4', 'Нарс', 3, 'зарагдаагүй', '', ''),
(789, 'Layer2copy101_4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(790, 'Layer2copy102_2', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(791, 'Layer2copy103_2', 'Нарс', 3, 'зарагдаагүй', '', ''),
(792, 'Layer2copy91_5', 'Нарс', 3, 'зарагдаагүй', '', ''),
(793, 'Layer2copy92_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(794, 'Layer2copy93_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(795, 'Layer2copy94_5', 'Нарс', 3, 'зарагдаагүй', '', ''),
(796, 'Layer2copy95_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(797, 'Layer2copy96_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(798, 'Layer2copy97_5', 'Нарс', 3, 'зарагдаагүй', '', ''),
(799, 'Layer2copy98_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(800, 'Layer2copy99_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(801, 'Layer2copy100_5', 'Нарс', 3, 'зарагдаагүй', '', ''),
(802, 'Layer2copy101_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(803, 'Layer2copy102_3', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(804, 'Layer2copy103_3', 'Нарс', 3, 'зарагдаагүй', '', ''),
(805, 'Layer2copy91_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(806, 'Layer2copy92_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(807, 'Layer2copy93_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(808, 'Layer2copy94_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(809, 'Layer2copy95_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(810, 'Layer2copy96_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(811, 'Layer2copy91_7', 'Нарс', 3, 'зарагдаагүй', 'Нарс', ''),
(812, 'Layer2copy92_7', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(813, 'Layer2copy93_7', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(814, 'Layer2copy94_7', 'Нарс', 3, 'зарагдаагүй', '', ''),
(815, 'Layer2copy95_7', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(816, 'Layer2copy96_7', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(817, 'Layer2copy91_8', 'Нарс', 3, 'зарагдаагүй', '', ''),
(818, 'Layer2copy92_8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(819, 'Layer2copy93_8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(820, 'Layer2copy94_8', 'Нарс', 3, 'зарагдаагүй', '', ''),
(821, 'Layer2copy95_8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(822, 'Layer2copy96_8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(823, 'Layer2copy97_6', 'Нарс', 3, 'зарагдаагүй', '', ''),
(824, 'Layer2copy98_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(825, 'Layer2copy99_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(826, 'Layer2copy100_6', 'Нарс', 3, 'зарагдаагүй', '', ''),
(827, 'Layer2copy101_6', 'Голт бор', 3, 'зарагдаагүй', '', '');
INSERT INTO `pm_tree` (`id`, `code`, `name`, `age`, `status`, `owner`, `description`) VALUES
(828, 'Layer2copy102_4', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(829, 'Layer2copy103_4', 'Нарс', 3, 'зарагдаагүй', '', ''),
(830, 'Layer2copy91_9', 'Нарс', 3, 'зарагдаагүй', '', ''),
(831, 'Layer2copy92_9', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(832, 'Layer2copy93_9', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(833, 'Layer2copy94_9', 'Нарс', 3, 'зарагдаагүй', '', ''),
(834, 'Layer2copy95_9', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(835, 'Layer2copy96_9', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(836, 'Layer2copy97_7', 'Нарс', 3, 'зарагдаагүй', '', ''),
(837, 'Layer2copy98_7', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(838, 'Layer2copy99_7', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(839, 'Layer2copy100_7', 'Нарс', 3, 'зарагдаагүй', '', ''),
(840, 'Layer2copy101_7', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(841, 'Layer2copy102_5', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(842, 'Layer2copy103_5', 'Нарс', 3, 'зарагдаагүй', '', ''),
(843, 'Layer2copy91_10', 'Нарс', 3, 'зарагдаагүй', '', ''),
(844, 'Layer2copy92_10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(845, 'Layer2copy93_10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(846, 'Layer2copy94_10', 'Нарс', 3, 'зарагдаагүй', '', ''),
(847, 'Layer2copy95_10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(848, 'Layer2copy96_10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(849, 'Layer2copy97_8', 'Нарс', 3, 'зарагдаагүй', '', ''),
(850, 'Layer2copy98_8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(851, 'Layer2copy99_8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(852, 'Layer2copy100_8', 'Нарс', 3, 'зарагдаагүй', '', ''),
(853, 'Layer2copy101_8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(854, 'Layer2copy102_6', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(855, 'Layer2copy103_6', 'Нарс', 3, 'зарагдаагүй', '', ''),
(856, 'Layer2copy91_11', 'Нарс', 3, 'зарагдаагүй', '', ''),
(857, 'Layer2copy92_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(858, 'Layer2copy93_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(859, 'Layer2copy94_11', 'Нарс', 3, 'зарагдаагүй', '', ''),
(860, 'Layer2copy95_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(861, 'Layer2copy96_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(862, 'Layer2copy97_9', 'Нарс', 3, 'зарагдаагүй', '', ''),
(863, 'Layer2copy98_9', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(864, 'Layer2copy99_9', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(865, 'Layer2copy100_9', 'Нарс', 3, 'зарагдаагүй', '', ''),
(866, 'Layer2copy101_9', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(867, 'Layer2copy102_7', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(868, 'Layer2copy103_7', 'Нарс', 3, 'зарагдаагүй', '', ''),
(869, 'Layer2copy91_12', 'Нарс', 3, 'зарагдаагүй', '', ''),
(870, 'Layer2copy92_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(871, 'Layer2copy93_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(872, 'Layer2copy94_12', 'Нарс', 3, 'зарагдаагүй', '', ''),
(873, 'Layer2copy95_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(874, 'Layer2copy96_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(875, 'Layer2copy97_10', 'Нарс', 3, 'зарагдаагүй', '', ''),
(876, 'Layer2copy98_10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(877, 'Layer2copy99_10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(878, 'Layer2copy100_10', 'Нарс', 3, 'зарагдаагүй', '', ''),
(879, 'Layer2copy101_10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(880, 'Layer2copy102_8', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(881, 'Layer2copy103_8', 'Нарс', 3, 'зарагдаагүй', '', ''),
(882, 'Layer2copy91_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(883, 'Layer2copy92_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(884, 'Layer2copy93_13', 'Нарс', 3, 'зарагдаагүй', '', ''),
(885, 'Layer2copy94_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(886, 'Layer2copy95_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(887, 'Layer2copy96_13', 'Нарс', 3, 'зарагдаагүй', '', ''),
(888, 'Layer2copy97_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(889, 'Layer2copy98_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(890, 'Layer2copy99_11', 'Нарс', 3, 'зарагдаагүй', '', ''),
(891, 'Layer2copy100_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(892, 'Layer2copy101_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(893, 'Layer2copy102_9', 'Нарс', 3, 'зарагдаагүй', '', ''),
(894, 'Layer2copy91_14', 'Нарс', 3, 'зарагдаагүй', '', ''),
(895, 'Layer2copy92_14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(896, 'Layer2copy93_14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(897, 'Layer2copy94_14', 'Нарс', 3, 'зарагдаагүй', '', ''),
(898, 'Layer2copy95_14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(899, 'Layer2copy96_14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(900, 'Layer2copy97_12', 'Нарс', 3, 'зарагдаагүй', '', ''),
(901, 'Layer2copy98_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(902, 'Layer2copy99_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(903, 'Layer2copy100_12', 'Нарс', 3, 'зарагдаагүй', '', ''),
(904, 'Layer2copy101_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(905, 'Layer2copy102_10', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(906, 'Layer2copy91_15', 'Нарс', 3, 'зарагдаагүй', '', ''),
(907, 'Layer2copy92_15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(908, 'Layer2copy93_15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(909, 'Layer2copy94_15', 'Нарс', 3, 'зарагдаагүй', '', ''),
(910, 'Layer2copy95_15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(911, 'Layer2copy96_15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(912, 'Layer2copy97_13', 'Нарс', 3, 'зарагдаагүй', '', ''),
(913, 'Layer2copy98_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(914, 'Layer2copy99_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(915, 'Layer2copy100_13', 'Нарс', 3, 'зарагдаагүй', '', ''),
(916, 'Layer2copy101_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(917, 'Layer2copy102_11', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(918, 'Layer2copy91_16', 'Нарс', 3, 'зарагдаагүй', '', ''),
(919, 'Layer2copy92_16', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(920, 'Layer2copy93_16', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(921, 'Layer2copy94_16', 'Нарс', 3, 'зарагдаагүй', '', ''),
(922, 'Layer2copy95_16', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(923, 'Layer2copy96_16', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(924, 'Layer2copy97_14', 'Нарс', 3, 'зарагдаагүй', '', ''),
(925, 'Layer2copy98_14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(926, 'Layer2copy99_14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(927, 'Layer2copy100_14', 'Нарс', 3, 'зарагдаагүй', '', ''),
(928, 'Layer2copy101_14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(929, 'Layer2copy102_12', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(930, 'Layer2copy91_17', 'Нарс', 3, 'зарагдаагүй', '', ''),
(931, 'Layer2copy92_17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(932, 'Layer2copy93_17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(933, 'Layer2copy94_17', 'Нарс', 3, 'зарагдаагүй', '', ''),
(934, 'Layer2copy95_17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(935, 'Layer2copy96_17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(936, 'Layer2copy97_15', 'Нарс', 3, 'зарагдаагүй', '', ''),
(937, 'Layer2copy98_15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(938, 'Layer2copy99_15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(939, 'Layer2copy100_15', 'Нарс', 3, 'зарагдаагүй', '', ''),
(940, 'Layer2copy101_15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(941, 'Layer2copy102_13', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(942, 'Layer2copy103_9', 'Нарс', 3, 'зарагдаагүй', '', ''),
(943, 'Layer2copy91_18', 'Нарс', 3, 'зарагдаагүй', '', ''),
(944, 'Layer2copy92_18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(945, 'Layer2copy93_18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(946, 'Layer2copy94_18', 'Нарс', 3, 'зарагдаагүй', '', ''),
(947, 'Layer2copy95_18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(948, 'Layer2copy96_18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(949, 'Layer2copy97_16', 'Нарс', 3, 'зарагдаагүй', '', ''),
(950, 'Layer2copy98_16', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(951, 'Layer2copy99_16', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(952, 'Layer2copy100_16', 'Нарс', 3, 'зарагдаагүй', '', ''),
(953, 'Layer2copy101_16', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(954, 'Layer2copy102_14', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(955, 'Layer2copy103_10', 'Нарс', 3, 'зарагдаагүй', '', ''),
(956, 'Layer2copy91_19', 'Нарс', 3, 'зарагдаагүй', '', ''),
(957, 'Layer2copy92_19', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(958, 'Layer2copy93_19', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(959, 'Layer2copy94_19', 'Нарс', 3, 'зарагдаагүй', '', ''),
(960, 'Layer2copy95_19', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(961, 'Layer2copy96_19', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(962, 'Layer2copy97_17', 'Нарс', 3, 'зарагдаагүй', '', ''),
(963, 'Layer2copy98_17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(964, 'Layer2copy99_17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(965, 'Layer2copy100_17', 'Нарс', 3, 'зарагдаагүй', '', ''),
(966, 'Layer2copy101_17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(967, 'Layer2copy102_15', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(968, 'Layer2copy103_11', 'Нарс', 3, 'зарагдаагүй', '', ''),
(969, 'Layer2copy91_20', 'Нарс', 3, 'зарагдаагүй', '', ''),
(970, 'Layer2copy92_20', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(971, 'Layer2copy93_20', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(972, 'Layer2copy94_20', 'Нарс', 3, 'зарагдаагүй', '', ''),
(973, 'Layer2copy95_20', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(974, 'Layer2copy96_20', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(975, 'Layer2copy97_18', 'Нарс', 3, 'зарагдаагүй', '', ''),
(976, 'Layer2copy98_18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(977, 'Layer2copy99_18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(978, 'Layer2copy100_18', 'Нарс', 3, 'зарагдаагүй', '', ''),
(979, 'Layer2copy101_18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(980, 'Layer2copy102_16', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(981, 'Layer2copy103_12', 'Нарс', 3, 'зарагдаагүй', '', ''),
(982, 'Layer2copy91_21', 'Нарс', 3, 'зарагдаагүй', '', ''),
(983, 'Layer2copy92_21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(984, 'Layer2copy93_21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(985, 'Layer2copy94_21', 'Нарс', 3, 'зарагдаагүй', '', ''),
(986, 'Layer2copy95_21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(987, 'Layer2copy96_21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(988, 'Layer2copy97_19', 'Нарс', 3, 'зарагдаагүй', '', ''),
(989, 'Layer2copy98_19', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(990, 'Layer2copy99_19', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(991, 'Layer2copy100_19', 'Нарс', 3, 'зарагдаагүй', '', ''),
(992, 'Layer2copy101_19', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(993, 'Layer2copy102_17', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(994, 'Layer2copy103_13', 'Нарс', 3, 'зарагдаагүй', '', ''),
(995, 'Layer2copy91_22', 'Нарс', 3, 'зарагдаагүй', '', ''),
(996, 'Layer2copy92_22', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(997, 'Layer2copy93_22', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(998, 'Layer2copy94_22', 'Нарс', 3, 'зарагдаагүй', '', ''),
(999, 'Layer2copy95_22', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1000, 'Layer2copy96_22', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1001, 'Layer2copy97_20', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1002, 'Layer2copy98_20', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1003, 'Layer2copy99_20', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1004, 'Layer2copy100_20', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1005, 'Layer2copy101_20', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1006, 'Layer2copy102_18', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1007, 'Layer2copy103_14', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1008, 'Layer2copy91_23', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1009, 'Layer2copy92_23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1010, 'Layer2copy93_23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1011, 'Layer2copy94_23', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1012, 'Layer2copy95_23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1013, 'Layer2copy96_23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1014, 'Layer2copy97_21', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1015, 'Layer2copy98_21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1016, 'Layer2copy99_21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1017, 'Layer2copy100_21', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1018, 'Layer2copy101_21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1019, 'Layer2copy102_19', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1020, 'Layer2copy103_15', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1021, 'Layer2copy91_24', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1022, 'Layer2copy92_24', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1023, 'Layer2copy93_24', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1024, 'Layer2copy94_24', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1025, 'Layer2copy95_24', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1026, 'Layer2copy96_24', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1027, 'Layer2copy97_22', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1028, 'Layer2copy98_22', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1029, 'Layer2copy99_22', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1030, 'Layer2copy100_22', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1031, 'Layer2copy101_22', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1032, 'Layer2copy102_20', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1033, 'Layer2copy103_16', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1034, 'Layer2copy91_25', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1035, 'Layer2copy92_25', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1036, 'Layer2copy93_25', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1037, 'Layer2copy94_25', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1038, 'Layer2copy95_25', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1039, 'Layer2copy96_25', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1040, 'Layer2copy97_23', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1041, 'Layer2copy98_23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1042, 'Layer2copy99_23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1043, 'Layer2copy100_23', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1044, 'Layer2copy101_23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1045, 'Layer2copy102_21', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1046, 'Layer2copy103_17', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1047, 'Layer2copy91_26', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1048, 'Layer2copy92_26', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1049, 'Layer2copy93_26', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1050, 'Layer2copy94_26', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1051, 'Layer2copy95_26', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1052, 'Layer2copy96_26', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1053, 'Layer2copy97_24', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1054, 'Layer2copy98_24', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1055, 'Layer2copy99_24', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1056, 'Layer2copy100_24', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1057, 'Layer2copy101_24', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1058, 'Layer2copy102_22', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1059, 'Layer2copy103_18', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1060, 'Layer2copy91_27', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1061, 'Layer2copy92_27', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1062, 'Layer2copy93_27', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1063, 'Layer2copy94_27', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1064, 'Layer2copy95_27', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1065, 'Layer2copy96_27', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1066, 'Layer2copy97_25', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1067, 'Layer2copy98_25', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1068, 'Layer2copy99_25', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1069, 'Layer2copy100_25', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1070, 'Layer2copy101_25', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1071, 'Layer2copy102_23', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1072, 'Layer2copy103_19', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1073, 'Layer2copy91_28', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1074, 'Layer2copy92_28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1075, 'Layer2copy93_28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1076, 'Layer2copy94_28', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1077, 'Layer2copy95_28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1078, 'Layer2copy96_28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1079, 'Layer2copy97_26', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1080, 'Layer2copy98_26', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1081, 'Layer2copy99_26', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1082, 'Layer2copy100_26', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1083, 'Layer2copy101_26', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1084, 'Layer2copy102_24', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1085, 'Layer2copy103_20', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1086, 'Layer2copy91_29', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1087, 'Layer2copy92_29', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1088, 'Layer2copy93_29', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1089, 'Layer2copy94_29', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1090, 'Layer2copy95_29', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1091, 'Layer2copy96_29', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1092, 'Layer2copy97_27', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1093, 'Layer2copy98_27', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1094, 'Layer2copy99_27', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1095, 'Layer2copy100_27', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1096, 'Layer2copy101_27', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1097, 'Layer2copy102_25', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1098, 'Layer2copy103_21', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1099, 'Layer2copy91_30', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1100, 'Layer2copy92_30', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1101, 'Layer2copy93_30', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1102, 'Layer2copy94_30', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1103, 'Layer2copy95_30', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1104, 'Layer2copy96_30', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1105, 'Layer2copy97_28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1106, 'Layer2copy98_28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1107, 'Layer2copy99_28', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1108, 'Layer2copy100_28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1109, 'Layer2copy101_28', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1110, 'Layer2copy102_26', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1111, 'Layer2copy91_31', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1112, 'Layer2copy92_31', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1113, 'Layer2copy93_31', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1114, 'Layer2copy94_31', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1115, 'Layer2copy95_31', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1116, 'Layer2copy96_31', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1117, 'Layer2copy97_29', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1118, 'Layer2copy91_32', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1119, 'Layer2copy92_32', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1120, 'Layer2copy93_32', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1121, 'Layer2copy94_32', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1122, 'Layer2copy95_32', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1123, 'Layer2copy96_32', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1124, 'Layer2copy97_30', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1125, 'Layer2copy91_33', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1126, 'Layer2copy92_33', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1127, 'Layer2copy93_33', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1128, 'Layer2copy94_33', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1129, 'Layer2copy95_33', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1130, 'Layer2copy96_33', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1131, 'Layer2copy97_31', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1132, 'Layer2copy91_34', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1133, 'Layer2copy92_34', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1134, 'Layer2copy93_34', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1135, 'Layer2copy94_34', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1136, 'Layer2copy95_34', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1137, 'Layer2copy96_34', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1138, 'Layer2copy97_32', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1139, 'Layer2copy91_35', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1140, 'Layer2copy92_35', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1141, 'Layer2copy93_35', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1142, 'Layer2copy94_35', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1143, 'Layer2copy95_35', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1144, 'Layer2copy96_35', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1145, 'Layer2copy97_33', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1146, 'Layer2copy91_36', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1147, 'Layer2copy92_36', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1148, 'Layer2copy93_36', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1149, 'Layer2copy94_36', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1150, 'Layer2copy95_36', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1151, 'Layer2copy96_36', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1152, 'Layer2copy97_34', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1153, 'Layer2copy91_37', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1154, 'Layer2copy92_37', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1155, 'Layer2copy93_37', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1156, 'Layer2copy94_37', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1157, 'Layer2copy95_37', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1158, 'Layer2copy96_37', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1159, 'Layer2copy97_35', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1160, 'Layer2copy91_38', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1161, 'Layer2copy92_38', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1162, 'Layer2copy93_38', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1163, 'Layer2copy94_38', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1164, 'Layer2copy95_38', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1165, 'Layer2copy96_38', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1166, 'Layer2copy97_36', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1167, 'Layer2copy91_39', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1168, 'Layer2copy92_39', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1169, 'Layer2copy93_39', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1170, 'Layer2copy94_39', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1171, 'Layer2copy95_39', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1172, 'Layer2copy96_39', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1173, 'Layer2copy97_37', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1174, 'Layer2copy91_40', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1175, 'Layer2copy92_40', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1176, 'Layer2copy93_40', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1177, 'Layer2copy94_40', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1178, 'Layer2copy95_40', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1179, 'Layer2copy96_40', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1180, 'Layer2copy97_38', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1181, 'Layer2copy91_41', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1182, 'Layer2copy92_41', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1183, 'Layer2copy93_41', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1184, 'Layer2copy94_41', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1185, 'Layer2copy95_41', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1186, 'Layer2copy96_41', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1187, 'Layer2copy97_39', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1188, 'Layer2copy91_42', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1189, 'Layer2copy92_42', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1190, 'Layer2copy93_42', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1191, 'Layer2copy94_42', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1192, 'Layer2copy95_42', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1193, 'Layer2copy96_42', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1194, 'Layer2copy97_40', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1195, 'Layer2copy91_43', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1196, 'Layer2copy92_43', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1197, 'Layer2copy93_43', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1198, 'Layer2copy94_43', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1199, 'Layer2copy95_43', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1200, 'Layer2copy96_43', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1201, 'Layer2copy97_41', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1202, 'Layer2copy91_44', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1203, 'Layer2copy92_44', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1204, 'Layer2copy93_44', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1205, 'Layer2copy94_44', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1206, 'Layer2copy95_44', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1207, 'Layer2copy96_44', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1208, 'Layer2copy97_42', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1209, 'Layer2copy91_45', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1210, 'Layer2copy92_45', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1211, 'Layer2copy93_45', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1212, 'Layer2copy94_45', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1213, 'Layer2copy95_45', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1214, 'Layer2copy96_45', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1215, 'Layer2copy97_43', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1216, 'Layer2copy91_46', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1217, 'Layer2copy92_46', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1218, 'Layer2copy93_46', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1219, 'Layer2copy94_46', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1220, 'Layer2copy95_46', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1221, 'Layer2copy96_46', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1222, 'Layer2copy97_44', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1223, 'Layer2copy91_47', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1224, 'Layer2copy92_47', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1225, 'Layer2copy93_47', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1226, 'Layer2copy94_47', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1227, 'Layer2copy95_47', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1228, 'Layer2copy96_47', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1229, 'Layer2copy97_45', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1230, 'Layer2copy92_48', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1231, 'Layer2copy93_48', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1232, 'Layer2copy94_48', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1233, 'Layer2copy95_48', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1234, 'Layer2copy96_48', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1235, 'Layer2copy97_46', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1236, 'Layer2copy91_48', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1237, 'Layer2copy92_49', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1238, 'Layer2copy93_49', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1239, 'Layer2copy94_49', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1240, 'Layer2copy95_49', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1241, 'Layer2copy96_49', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1242, 'Layer2copy97_47', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1243, 'Layer2copy91_49', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1244, 'Layer2copy92_50', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1245, 'Layer2copy93_50', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1246, 'Layer2copy94_50', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1247, 'Layer2copy95_50', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1248, 'Layer2copy96_50', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1249, 'Layer2copy97_48', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1250, 'Layer2copy91_50', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1251, 'Layer2copy92_51', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1252, 'Layer2copy93_51', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1253, 'Layer2copy94_51', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1254, 'Layer2copy95_51', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1255, 'Layer2copy96_51', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1256, 'Layer2copy97_49', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1257, 'Layer2copy91_51', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1258, 'Layer2copy92_52', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1259, 'Layer2copy93_52', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1260, 'Layer2copy94_52', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1261, 'Layer2copy95_52', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1262, 'Layer2copy96_52', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1263, 'Layer2copy97_50', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1264, 'Layer2copy91_52', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1265, 'Layer2copy92_53', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1266, 'Layer2copy93_53', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1267, 'Layer2copy94_53', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1268, 'Layer2copy95_53', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1269, 'Layer2copy96_53', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1270, 'Layer2copy97_51', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1271, 'Layer2copy91_53', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1272, 'Layer2copy92_54', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1273, 'Layer2copy93_54', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1274, 'Layer2copy94_54', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1275, 'Layer2copy95_54', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1276, 'Layer2copy96_54', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1277, 'Layer2copy97_52', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1278, 'Layer2copy91_54', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1279, 'Layer2copy92_55', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1280, 'Layer2copy93_55', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1281, 'Layer2copy94_55', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1282, 'Layer2copy95_55', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1283, 'Layer2copy96_55', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1284, 'Layer2copy97_53', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1285, 'Layer2copy91_55', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1286, 'Layer2copy92_56', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1287, 'Layer2copy93_56', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1288, 'Layer2copy94_56', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1289, 'Layer2copy95_56', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1290, 'Layer2copy96_56', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1291, 'Layer2copy97_54', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1292, 'Layer2copy91_56', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1293, 'Layer2copy92_57', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1294, 'Layer2copy93_57', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1295, 'Layer2copy94_57', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1296, 'Layer2copy95_57', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1297, 'Layer2copy96_57', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1298, 'Layer2copy97_55', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1299, 'Layer2copy91_57', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1300, 'Layer2copy92_58', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1301, 'Layer2copy93_58', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1302, 'Layer2copy91_58', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1303, 'Layer2copy92_59', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1304, 'Layer2copy93_59', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1305, 'Layer2copy94_58', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1306, 'Layer2copy95_58', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1307, 'Layer2copy96_58', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1308, 'Layer2copy97_56', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1309, 'Layer2copy91_59', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1310, 'Layer2copy92_60', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1311, 'Layer2copy93_60', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1312, 'Layer2copy94_59', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1313, 'Layer2copy95_59', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1314, 'Layer2copy96_59', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1315, 'Layer2copy97_57', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1316, 'Layer2copy91_60', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1317, 'Layer2copy92_61', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1318, 'Layer2copy93_61', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1319, 'Layer2copy94_60', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1320, 'Layer2copy95_60', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1321, 'Layer2copy96_60', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1322, 'Layer2copy91_61', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1323, 'Layer2copy92_62', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1324, 'Layer2copy93_62', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1325, 'Layer2copy94_61', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1326, 'Layer2copy95_61', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1327, 'Layer2copy96_61', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1328, 'Layer2copy97_58', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1329, 'Layer2copy91_62', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1330, 'Layer2copy92_63', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1331, 'Layer2copy93_63', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1332, 'Layer2copy94_62', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1333, 'Layer2copy95_62', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1334, 'Layer2copy96_62', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1335, 'Layer2copy97_59', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1336, 'Layer2copy91_63', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1337, 'Layer2copy92_64', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1338, 'Layer2copy93_64', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1339, 'Layer2copy94_63', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1340, 'Layer2copy95_63', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1341, 'Layer2copy96_63', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1342, 'Layer2copy97_60', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1343, 'Layer2copy91_64', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1344, 'Layer2copy92_65', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1345, 'Layer2copy93_65', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1346, 'Layer2copy94_64', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1347, 'Layer2copy95_64', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1348, 'Layer2copy96_64', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1349, 'Layer2copy91_65', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1350, 'Layer2copy92_66', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1351, 'Layer2copy93_66', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1352, 'Layer2copy94_65', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1353, 'Layer2copy95_65', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1354, 'Layer2copy96_65', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1355, 'Layer2copy97_61', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1356, 'Layer2copy91_66', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1357, 'Layer2copy92_67', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1358, 'Layer2copy93_67', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1359, 'Layer2copy94_66', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1360, 'Layer2copy95_66', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1361, 'Layer2copy96_66', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1362, 'Layer2copy91_67', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1363, 'Layer2copy92_68', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1364, 'Layer2copy93_68', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1365, 'Layer2copy94_67', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1366, 'Layer2copy95_67', 'Голт бор', 3, 'зарагдаагүй', '', ''),
(1367, 'Layer2copy400', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1368, 'Layer2copy401', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1369, 'Layer2copy402', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1370, 'Layer2copy403', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1371, 'Layer2copy404', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1372, 'Layer2copy405', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1373, 'Layer2copy406', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1374, 'Layer2copy408', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1375, 'Layer2copy409', 'Нарс', 3, 'зарагдаагүй', '', ''),
(1376, 'Layer2copy410', 'Нарс', 3, 'зарагдаагүй', '', '');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

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


--
-- Table structure for table `pm_wd`
--

DROP TABLE IF EXISTS `pm_wd`;
CREATE TABLE IF NOT EXISTS `pm_wd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(25) NOT NULL,
  `name` varchar(255) NOT NULL,
  `age` int(5) NOT NULL,
  `status` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

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
