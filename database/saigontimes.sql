-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 16, 2020 at 02:51 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `saigontimes`
--
CREATE DATABASE IF NOT EXISTS `saigontimes` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `saigontimes`;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `CatID` int(11) NOT NULL AUTO_INCREMENT,
  `CatName` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `Editor` int(10) DEFAULT NULL,
  PRIMARY KEY (`CatID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`CatID`, `CatName`, `Editor`) VALUES
(1, 'Chính tr?', 2),
(2, 'Bóng dá', 2),
(3, 'Gia Ðình', 2),
(4, 'Xã H?i', 2),
(5, 'Th? gi?i', 2),
(6, 'Kinh doanh', NULL),
(7, 'S?c Kh?e', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cat_editor`
--

DROP TABLE IF EXISTS `cat_editor`;
CREATE TABLE IF NOT EXISTS `cat_editor` (
  `UserID` int(11) NOT NULL,
  `CatID` int(11) NOT NULL,
  PRIMARY KEY (`UserID`,`CatID`),
  KEY `fk_categories` (`CatID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `cat_editor`
--

INSERT INTO `cat_editor` (`UserID`, `CatID`) VALUES
(2, 1),
(2, 3),
(2, 5),
(2, 7),
(3, 2),
(3, 4),
(3, 6);

-- --------------------------------------------------------

--
-- Table structure for table `censorship`
--

DROP TABLE IF EXISTS `censorship`;
CREATE TABLE IF NOT EXISTS `censorship` (
  `PostID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Reason` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`PostID`,`UserID`,`StatusID`,`Date`),
  KEY `fk_censor_user` (`UserID`),
  KEY `fk_censor_status` (`StatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `censorship`
--

INSERT INTO `censorship` (`PostID`, `UserID`, `StatusID`, `Date`, `Reason`) VALUES
(1, 2, 1, '2020-06-19', 'pass'),
(2, 1, 1, '2020-06-19', 'pass'),
(3, 2, 1, '2020-06-19', 'pass');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `User` int(11) NOT NULL,
  `PostID` int(11) NOT NULL,
  `CommentContent` text COLLATE utf8_unicode_ci NOT NULL,
  `CommentDate` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`User`,`PostID`,`CommentDate`),
  KEY `fk_comment_post` (`PostID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`User`, `PostID`, `CommentContent`, `CommentDate`) VALUES
(1, 1, 'nice bro', '0000-00-00 00:00:00'),
(2, 1, 'good', '2020-07-09 00:00:00'),
(2, 2, 'exellecnt', '2020-07-27 00:00:00'),
(3, 1, 'nice post :V)', '0000-00-00 00:00:00'),
(3, 4, 'yeah yeah~', '0000-00-00 00:00:00'),
(3, 8, 'nordric coffee', '2020-08-13 14:19:53'),
(5, 8, 'good game', '2020-07-27 08:33:28');

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
CREATE TABLE IF NOT EXISTS `permission` (
  `PerID` int(11) NOT NULL AUTO_INCREMENT,
  `PermissionName` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`PerID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`PerID`, `PermissionName`) VALUES
(1, 'Admin'),
(2, 'Editor'),
(3, 'Writer'),
(4, 'User'),
(5, 'Guest');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `PostID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Abtract` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `PostContent` text COLLATE utf8_unicode_ci NOT NULL,
  `Author` int(11) NOT NULL,
  `CatID` int(11) DEFAULT 1,
  `SubCatID` int(11) NOT NULL,
  `HasAvatar` text COLLATE utf8_unicode_ci NOT NULL,
  `BigAvatar` text COLLATE utf8_unicode_ci NOT NULL,
  `PostDate` date NOT NULL,
  `Views` int(11) NOT NULL,
  `Ranks` int(11) NOT NULL,
  `Status` int(11) NOT NULL,
  `TagID` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Editor` int(11) DEFAULT NULL,
  PRIMARY KEY (`PostID`),
  KEY `fk_post_user` (`Author`),
  KEY `fk_post_status` (`Status`),
  KEY `fk_post_cat` (`CatID`),
  KEY `Title` (`Title`),
  KEY `Abtract` (`Abtract`),
  KEY `PostContent` (`PostContent`(1024))
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`PostID`, `Title`, `Abtract`, `PostContent`, `Author`, `CatID`, `SubCatID`, `HasAvatar`, `BigAvatar`, `PostDate`, `Views`, `Ranks`, `Status`, `TagID`, `Editor`) VALUES
(1, '', 'Lo là ch? quan có th? khi?n b?n “m?t m?ng nhu choi', '<div class=\"updTm updTmD mrT5\">Th? Nam, ng&agrave;y 18/06/2020 17:58 PM (GMT+7)</div>\r\n<div class=\"bmTpSeoBlk bmTpSeoBlkD clF\">\r\n<div class=\"icoSocial icoSocialx txtRt flRt\"><a class=\"icoSocialCm\" title=\"Chia s? tr&ecirc;n Fanpage\" href=\"http://www.facebook.com/fan24h\" target=\"_blank\" rel=\"noopener\">&nbsp;</a></div>\r\n<div class=\"clF\">&nbsp;</div>\r\n</div>\r\n<h2 id=\"article_sapo\" class=\"ctTp tuht_show\">M&ugrave;a mua d?n cung l&agrave; m&ugrave;a m&agrave; can b?nh s?t xu?t huy?t l?i b?t d?u xu?t hi?n \r\nv&agrave; g&acirc;y th&agrave;nh d?ch. Can b?nh n&agrave;y tuy kh&ocirc;ng m?i nhung c&oacute; th? g&acirc;y n&ecirc;n nh?ng h?u qu? nghi&ecirc;m \r\ntr?ng n?u b?n ch? quan v&agrave; kh&ocirc;ng ph&ograve;ng ng?a. Vi?t Nam l&agrave; m?t trong nh?ng qu?c gia c&oacute; t? l? nhi?m s?t xu?t huy?t cao nh?t th? gi?i. V?y can b?nh n&agrave;y l&agrave; g&igrave;, n&oacute; nguy hi?m nhu th? n&agrave;o? B?n h&atilde;y t&igrave;m hi?u th&ocirc;ng \r\nqua b&agrave;i vi?t du?i d&acirc;y nh&eacute;.</h2>\r\n<p><strong>B?nh s?t xu?t huy?t l&agrave; g&igrave;?</strong></p>\r\n<p><a href=\"https://youmed.vn/tin-tuc/sot-xuat-huyet/\" target=\"_blank\" rel=\"nofollow noopener\">S?t xu?t huy?t</a>&nbsp;hay c&ograve;n g?i l&agrave; s?t xu?t huy?t Dengue l&agrave; m?t b?nh truy?n nhi?m do virus Dengue g&acirc;y ra. B?nh kh&ocirc;ng l&acirc;y tr?c ti?p t? ngu?i sang ngu?i nhung du?c truy?n sang ngu?i qua mu?i d?t. Mu?i v?n Aedes l&agrave; t&aacute;c nh&acirc;n truy?n b?nh. Mu?i s? h&uacute;t m&aacute;u ngu?i m?c b?nh ho?c ngu?i d&atilde; nhi?m ph?i virus nhung kh&ocirc;ng c&oacute; tri?u ch?ng r?i truy?n n&oacute; cho ngu?i kh?e m?nh. An u?ng, d&ugrave;ng chung \r\nd? v?i ngu?i b?nh kh&ocirc;ng l&agrave;m l&acirc;y nhi?m s?t xu?t huy?t.</p>\r\n<p>Virus Dengue c&oacute; 4 tu&yacute;p g&acirc;y b?nh du?c k&yacute; hi?u l&agrave; D1, D2, D3, D4. C? 4 tu&yacute;p n&agrave;y d?u g?p ? Vi?t Nam v&agrave; c&oacute; th? lu&acirc;n phi&ecirc;n g&acirc;y d?ch. Do mi?n d?ch du?c t?o th&agrave;nh sau khi m?c b?nh ch? d?c hi?u v?i t?ng tu&yacute;p virus n&ecirc;n ngu?i ta c&oacute; th? m?c s?t xu?t huy?t d?n 4 l?n trong d?i, tuy nhi&ecirc;n r?t hi?m khi m?c ph?i b?nh d?n l?n th? 4.</p> \r\n', 2, 7, 0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOwLqQLZR8WxMWJy9VGrnkFvZHbODKH1tSEyDCKIa-o6X79o0&s', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOwLqQLZR8WxMWJy9VGrnkFvZHbODKH1tSEyDCKIa-o6X79o0&s', '2020-06-18', 276, 10, 1, '', 2),
(2, '', '\"Ð? ru?t\" Ronaldo tính r?i Juventus, \"d?n nhà\" d?n', '<p>&nbsp;</p>\r\n<p><strong>Tottenham tho&aacute;t \"n?n\" nh? Covid-19</strong></p>\r\n<p>Tru?c khi gi?i Ngo?i h?ng Anh ph?i ho&atilde;n l?i v&igrave; d?ch b?nh, Tottenham dang roi t? do v?i chu?i phong d? tuong d?i ngh&egrave;o n&agrave;n. Ðo&agrave;n qu&acirc;n c?a Jose Mourinho d?i m?t v?i l?ch thi d?u d&agrave;y d?c v&agrave; c&oacute; ph?n n?ng n?. H? b? lo?i kh?i Champions League ? v&ograve;ng knock-out. Sau d&oacute; l&agrave; b? m?t th?m h?i t?i&nbsp;<a class=\"TextlinkBaiviet\" title=\"Premier League\" href=\"https://www.24h.com.vn/premier-league-2018-2019-c48e2367.html\">Premier League</a>&nbsp;khi t?t xu?ng t?n v? tr&iacute; th? 8.</p>\r\n<p><strong>Ð?i d?u kh&ocirc;ng khoan nhu?ng</strong></p>\r\n<p>L?i th? s&acirc;n nh&agrave; s? thu?c v? Tottenham, nhung co h?i chen ch&acirc;n v&agrave;o nh&oacute;m d?&nbsp;<a href=\"https://www.24h.com.vn/cup-c1-champions-league-c153.html\">UEFA Champions League</a>&nbsp;l?i dang r?ng m? d&agrave;nh cho MU. B?i v?y, d&acirc;y h?a h?n s? l&agrave; m?t cu?c d?i d?u kh&ocirc;ng khoan nhu?ng, trong l?n t&aacute;i ng? d?i b&oacute;ng cu c?a \"Ngu?i d?c bi?t\" Jose Mourinho.</p>\r\n<p><strong>Ph? hoi n&oacute;ng v&agrave;o g&aacute;y Chelsea</strong></p>\r\n<p>? ph&iacute;a b&ecirc;n kia chi?n tuy?n, MU cung bu?c v&agrave;o tr?n d?i chi?n n&agrave;y b?ng quy?t t&acirc;m cao nh?t. \"Qu? Ð?\" dang x?p th? 5 v?i 3 di?m &iacute;t hon&nbsp;<a class=\"TextlinkBaiviet\" title=\"Chelsea\" href=\"https://www.24h.com.vn/chelsea-c48e1505.html\">Chelsea</a>, d?i b&oacute;ng d?ng th? 4 l&uacute;c n&agrave;y. M?t&nbsp;chi?n th?ng ?&nbsp;tr?n d?u s?m v&ograve;ng 30 c&oacute; th? gi&uacute;p h? t?o ra &aacute;p l?c l?n l&ecirc;n \"The Blues\", d?i b&oacute;ng&nbsp;s? ph?i l&agrave;m kh&aacute;ch tru?c Aston Villa v&agrave;o ng&agrave;y Ch? Nh?t.</p>       \r\n<table width=\"500\" cellspacing=\"0\" cellpadding=\"3\" align=\"center\">\r\n<tbody>\r\n<tr>\r\n<td valign=\"top\">\r\n<p><strong>Th&ocirc;ng tin d?i h&igrave;nh</strong></p>\r\n<p>Tottenham: Dele Alli treo gi&ograve;. Tanganga, Parrott ch?n thuong. Lo Celso, Son b? ng? kh? nang ra s&acirc;n.</p>\r\n<p>MU: Phil Jones b? dau nh?, b? ng? kh? nang ra s&acirc;n.</p>\r\n<p><strong>Th&agrave;nh t&iacute;ch d?i d?u</strong></p>\r\n<p>Tottenham th?ng 2, thua 3 trong 5 cu?c d?i d?u g?n nh?t v?i MU t?i Ngo?i h?ng Anh.</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<h2 id=\"article_sapo\" class=\"ctTp tuht_show\">Federico Bernardeschi l&agrave; m?t trong nh?ng ng&ocirc;i sao kh&ocirc;ng du?c d&aacute;nh gi&aacute; d&uacute;ng kh? nang ? Juventus, gi?a nh?ng si&ecirc;u sao t?m c? th? gi?i c?a d?i ch? s&acirc;n Turin. V&igrave; th?, tuy?n th? Italia dang t&iacute;nh d?n Anh l?p nghi?p.</h2>\r\n<p><strong>Phuong &aacute;n d? ph&ograve;ng c?a MU</strong></p>\r\n<p>Kh&ocirc;ng c&ograve;n nghi ng? g&igrave; n?a, Jadon Sancho l&agrave; m?c ti&ecirc;u quan tr?ng c?a&nbsp;<a class=\"TextlinkBaiviet\" title=\"MU\" \r\nhref=\"https://www.24h.com.vn/manchester-united-c48e1521.html\">MU</a>&nbsp;trong phi&ecirc;n ch? h&egrave; 2020 n&agrave;y. Ch? c&oacute; di?u, kh? nang hi?n th?c h&oacute;a tham v?ng&nbsp;c?a \"Qu? d?\" c&ograve;n b? ng?, khi m&agrave; Sancho l&agrave; c&aacute;i t&ecirc;n \"hot\" c&ograve;n t&agrave;i ch&iacute;nh MU l?i kh&ocirc;ng th?c s? d?m b?o.</p>\r\n<p>H?u d?i d?ch Covid-19, gi&aacute; c?a Sancho kh&ocirc;ng h? gi?m. Theo d? do&aacute;n c?a c&acirc;y vi?t th? thao k? c? Martin Samuel tr&ecirc;n Daily Mail, d? c&oacute; s? ph?c v? c?a Jadon Sancho, MU ph?i chi s? ti?n kh&ocirc;ng du?i 100 tri?u b?ng.</p>\r\n<p>Ð&acirc;y l&agrave; r&agrave;o c?n kh&ocirc;ng d? vu?t qua n&ecirc;n d?i ch? s&acirc;n&nbsp;<a class=\"TextlinkBaiviet\" title=\"Old Trafford\" href=\"https://www.24h.com.vn/manchester-united-c48e1521.html\">Old Trafford</a>&nbsp;bu?c ph?i l&ecirc;n c&aacute;c phuong &aacute;n d? ph&ograve;ng. \r\nV?n theo ngu?n tin n&agrave;y, Ph&oacute; ch? t?ch Ed Woodward cung nhu b? ph?n chuy?n nhu?ng MU dang nh?m d?n Federico Bernardeschi l&agrave;m phuong &aacute;n B n?u th?t b?i ? thuong v? Sancho.</p>\r\n<p>Trong l&uacute;c d&oacute;, t? Tutto Sport b&aacute;o tin vui cho d?i b&oacute;ng nu?c Anh, khi m&agrave; ch&iacute;nh Juventus cung s?n s&agrarizio Sarri.</p>\r\n<div id=\"ADS_159_15s\" class=\"txtCent\">\r\n<div id=\"ADS_159_15stxtBnrHor\"></div>\r\n<div class=\"banner_inread\">&nbsp;</div>\r\n<span id=\"ADS_159_15s_0\" class=\"m_banner_show\"></span></div>\r\n<p>? Serie A m&ugrave;a n&agrave;y, Bernardeschi m?i c&oacute; 18 l?n ra s&acirc;n, trong d&oacute; c&oacute; 9 l?n v&agrave;o s&acirc;n t? bang gh? d? b?. V?y n&ecirc;n, Juventus h?a h?n s? ch?p thu?n d? Bernardeschi ra di n?u nh?n du?c d? ngh? kho?ng 30 tri?u b?ng - con s? ch? chua d?n 1/3 kho?n ti?n m&agrave; MU c&oacute; th? ph?i chi ra d? c&oacute; Sancho.</p>\r\n<p>Bernardeschi du?c Juventus chi&ecirc;u m? t? Fiorentina h?i m&ugrave;a h&egrave; nam 2017 v?i m?c gi&aacute; 40 tri?u euro (tuong duong 35,6 tri?u b?ng). T? ng&agrave;y t?i Turin, ti?n v? 26 tu?i n&agrave;y chua th? hi?n du?c nhi?u nhu k&igrave; v?ng. Du?i th?i HLV Sarri, Bernardeschi ng&agrave;y c&agrave;ng c&oacute; &iacute;t co h?i ra s&acirc;n. Anh v?n c&ograve;n h?p d?ng 2 nam v?i \"B&agrave; d?m gi&agrave;\" th&agrave;nh Turin.</p>\r\n<p><strong>Tham v?ng l?n trong chuy?n x&ecirc; d?ch</strong></p>\r\n<p>B?n th&acirc;n Federico Bernardeschi cung hi?u r?ng, th?i gian c?a anh t?i s&acirc;n Allianz dang kh&eacute;p l?i. HLV ti?n nhi?m Max Alleri uu ti&ecirc;n s? d?ng Bernardeschi l&agrave;m v? tinh h? tr? si&ecirc;u sao Ronaldo, th?m ch&iacute; s?n s&agrave;ng g?t Dybala l&ecirc;n gh? d? b?.</p>\r\n<p><br /><br /></p>\r\n<h2 id=\"article_sapo\" class=\"ctTp tuht_show\">Federico Bernardeschi l&agrave; m?t trong nh?ng ng&ocirc;i sao kh&ocirc;ng du?c d&aacute;nh gi&aacute; d&uacute;ng kh? nang ? Juventus, gi?a nh?ng si&ecirc;u sao t?m c? th? gi?i c?a d?i ch? s&acirc;n Turin. V&igrave; th?, tuy?n th? Italia dang t&iacute;nh d?n Anh l?p nghi?p.</h2>\r\n<p><strong>Phuong &aacute;n d? ph&ograve;ng c?a MU</strong></p>\r\n<p>Kh&ocirc;ng c&ograve;n nghi ng? g&igrave; n?a, Jadon Sancho l&agrave; m?c ti&ecirc;u quan tr?ng c?a&nbsp;<a class=\"TextlinkBaiviet\" title=\"MU\" \r\nhref=\"https://www.24h.com.vn/manchester-united-c48e1521.html\">MU</a>&nbsp;trong phi&ecirc;n ch? h&egrave; 2020 n&agrave;y. Ch? c&oacute; di?u, kh? nang hi?n th?c h&oacute;a tham v?ng&nbsp;c?a \"Qu? d?\" c&ograve;n b? ng?, khi m&agrave; Sancho l&agrave; c&aacute;i t&ecirc;n \"hot\" c&ograve;n t&agrave;i ch&iacute;nh MU l?i kh&ocirc;ng th?c s? d?m b?o.</p>\r\n<p>H?u d?i d?ch Covid-19, gi&aacute; c?a Sancho kh&ocirc;ng h? gi?m. Theo d? do&aacute;n c?a c&acirc;y vi?t th? thao k? c? Martin Samuel tr&ecirc;n Daily Mail, d? c&oacute; s? ph?c v? c?a Jadon Sancho, MU ph?i chi s? ti?n kh&ocirc;ng du?i 100 tri?u b?ng.</p>\r\n<p>Ð&acirc;y l&agrave; r&agrave;o c?n kh&ocirc;ng d? vu?t qua n&ecirc;n d?i ch? s&acirc;n&nbsp;<a class=\"TextlinkBaiviet\" title=\"Old Trafford\" href=\"https://www.24h.com.vn/manchester-united-c48e1521.html\">Old Trafford</a>&nbsp;bu?c ph?i l&ecirc;n c&aacute;c phuong &aacute;n d? ph&ograve;ng. \r\nV?n theo ngu?n tin n&agrave;y, Ph&oacute; ch? t?ch Ed Woodward cung nhu b? ph?n chuy?n nhu?ng MU dang nh?m d?n Federico Bernardeschi l&agrave;m phuong &aacute;n B n?u th?t b?i ? thuong v? Sancho.</p>\r\n<p>Trong l&uacute;c d&oacute;, t? Tutto Sport b&aacute;o tin vui cho d?i b&oacute;ng nu?c Anh, khi m&agrave; ch&iacute;nh Juventus cung s?n s&agrave;ng d? Bernardeschi ra di trong m&ugrave;a h&egrave; 2020. Theo d&oacute;, ti?n v? n&agrave;y kh&ocirc;ng n?m trong k? ho?ch s? d?ng c?a HLV Maurizio Sarri.</p>\r\n<div id=\"ADS_159_15s\" class=\"txtCent\">\r\n<div id=\"ADS_159_15stxtBnrHor\"></div>\r\n<div class=\"banner_inread\">&nbsp;</div>\r\n<span id=\"ADS_159_15s_0\" class=\"m_banner_show\"></span></div>\r\n<p>? Serie A m&ugrave;a n&agrave;y, Bernardeschi m?i c&oacute; 18 l?n ra s&acirc;n, trong d&oacute; c&oacute; 9 l?n v&agrave;o s&acirc;n t? bang gh? d? b?. V?y n&ecirc;n, Juventus h?a h?n s? ch?p thu?n d? Bernardeschi ra di n?u nh?n du?c d? ngh? kho?ng 30 tri?u b?ng - con s? ch? chua d?n 1/3 kho?n ti?n m&agrave; MU c&oacute; th? ph?i chi ra d? c&oacute; Sancho.</p>\r\n<p>Bernardeschi du?c Juventus chi&ecirc;u m? t? Fiorentina h?i m&ugrave;a h&egrave; nam 2017 v?i m?c gi&aacute; 40 tri?u euro (tuong duong 35,6 tri?u b?ng). T? ng&agrave;y t?i Turin, ti?n v? 26 tu?i n&agrave;y chua th? hi?n du?c nhi?u nhu k&igrave; v?ng. Du?i th?i HLV Sarri, Bernardeschi ng&agrave;y c&agrave;ng c&oacute; &iacute;t co h?i ra s&acirc;n. Anh v?n c&ograve;n h?p d?ng 2 nam v?i \"B&agrave; d?m gi&agrave;\" th&agrave;nh Turin.</p>\r\n<p><strong>Tham v?ng l?n trong chuy?n x&ecirc; d?ch</strong></p>\r\n<p>B?n th&acirc;n Federico Bernardeschi cung hi?u r?ng, th?i gian c?a anh t?i s&acirc;n Allianz dang kh&eacute;p l?i. HLV ti?n nhi?m Max Alleri uu ti&ecirc;n s? d?ng Bernardeschi l&agrave;m v? tinh h? tr? si&ecirc;u sao Ronaldo, th?m ch&iacute; s?n s&agrave;ng g?t Dybala l&ecirc;n gh? d? b?.</p>', 2, 2, 0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaQS8Vi58O4M7YpNDKKNjfJywIjdFVmLkTGtfSAzLbLI3L29Hj&s', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaQS8Vi58O4M7YpNDKKNjfJywIjdFVmLkTGtfSAzLbLI3L29Hj&s', '2020-06-17', 303, 9, 1, NULL, 2),
(3, '', 'B? Y t? công b? thêm 7 ca nhi?m COVID-19', '<h2 id=\"article_sapo\" class=\"ctTp tuht_show\">Chi?u 19/6, B? Y t? cho bi?t, Vi?t Nam v?a ghi nh?n th&ecirc;m 7 ca nhi?m COVID-19, n&acirc;ng t?ng s? ca l&ecirc;n 349.</h2>\r\n<p><strong>C&aacute;c b?nh nh&acirc;n bao g?m:</strong></p>\r\n<p>BN343: be?^nh nha^n nu?~, 27 tuo^?i, co´ di?a chi? ta?i Ca^?m Thu?y, Ca^?m Pha?, Qua?ng Ninh.</p>\r\n<p>BN344: be?^nh nha^n nam, 52 tuo^?i, co´ di?a chi? ta?i Nghi Thu?y, Cu??a Lo`, Nghe?^ An.</p>\r\n<p>BN345: be?^nh nha^n nu?~, 39 tuo^?i, co´ di?a chi? ta?i Co^? Nhue^´ 1, Ba?´c Tu?` Lie^m, Ha` No?^i. BN346: be?^nh nha^n nam, 6 tuo^?i, co´ di?a\r\n chi? ta?i Co^? Nhue^´ 1, Ba?´c Tu?` Lie^m, Ha` No?^i.</p>\r\n<p>BN347: be?^nh nha^n nam, 6 tuo^?i, co´ di?a chi? ta?i Co^? Nhue^´ 1, Ba?´c Tu?` Lie^m, Ha` No?^i.</p>\r\n<p>BN348: be?^nh nha^n nam, 39 tuo^?i, co´ di?a chi? ta?i Co^? Nhue^´ 1, Ba?´c Tu?` Lie^m, Ha` No?^i.</p>\r\n<p>BN349: be?^nh nha^n nam, 12 tuo^?i, co´ di?a chi? ta?i Co^? Nhue^´ 1, Ba?´c Tu?` Lie^m, Ha` No?^i.</p>\r\n<p>Nga`y 06/6 ca´c be?^nh nha^n na`y tu?` cha^u A^u (Thu?y Ðie^?n, Pha^`n Lan) ve^` Sa^n bay Quo^´c te^´ No?^i Ba`i (Ha` No?^i) tre^n chuye^´n bay\r\n VN2, sau khi nha?^p ca?nh du?o??c ca´ch ly ngay ta?i Tru?o?`ng Cao da??ng nghe^` Co^ng nghe?^ cao, Ta^y Mo^~, Nam Tu?` Lie^m, Ha` No?^i.</p>     \r\n<p>Nga`y 07/6 du?o??c la^´y ma^~u xe´t nghie?^m la^`n 1, ke^´t qua? de^`u a^m ti´nh. Nga`y 18/6 du?o??c la^´y ma^~u xe´t nghie?^m la^`n 2, ke^´t q\r\nua? 7 ma^~u du?o?ng ti´nh vo?´i&nbsp;<a class=\"TextlinkBaiviet\" title=\"SARS-CoV-2\" href=\"https://www.24h.com.vn/dich-covid-19-c62e6058.html\">SARS-\r\nCoV-2</a>. Hie?^n 7 be?^nh nha^n du?o??c ca´ch ly, die^`u tri? ta?i Be?^nh vie?^n Be?^nh Nhie?^t do?´i Trung u?o?ng co? so?? 2.</p>\r\n<p>B? Y t? cho bi?t, c? 7 ca nhi?m COVID-19 du?c c&ocirc;ng b? chi?u 19/6 d?u kh&ocirc;ng c&oacute; nguy co l&acirc;y ra c?ng d?ng.</p>\r\n<p>Nhu? va?^y, ti´nh de^´n 18h nga`y 19/6, Vie?^t Nam co´ to^?ng co?^ng 209 ca nhie^~m nha?^p ca?nh du?o??c ca´ch ly ngay, da~ co´ 64 nga`y lie^n \r\ntie^´p kho^ng co´ ca nhie^~m trong co?^ng do^`ng.</p>', 3, 7, 0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJylmR1TzlCGOudXjT8CiD6Ur8HWefR9VLcoYk_8_GhaXkKXi&s', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJylmR1TzlCGOudXjT8CiD6Ur8HWefR9VLcoYk_8_GhaXkKXi&s', '2020-01-15', 300, 8, 1, NULL, 2),
(4, '', 'Ai ng? tr?ng chim cút có t?i 15 tác d?ng ch?a b?nh', '<h1 id=\"article_title\" class=\"clrTit bld tuht_show\"><strong>1. Gi?m nguy co m?c b?nh nan y</strong></h1>\r\n<p>Lu?ng kali th?p trong co th? c&oacute; th? khi?n b?n d? m?c c&aacute;c b?nh nan y nhu b?nh tim, huy?t &aacute;p cao, vi&ecirc;m kh?p, d?t qu?, \r\nung thu v&agrave; r?i lo?n ti&ecirc;u h&oacute;a. Tr?ng c&uacute;t b? sung lu?ng kali c?n thi?t cho co th?, gi&uacute;p b?n kh?e m?nh.</p>        \r\n<p><strong>2. Ngan ng?a c&aacute;c b?nh m&atilde;n t&iacute;nh</strong></p>\r\n<p>Tr?ng chim c&uacute;t ch?a nhi?u vitamin A v&agrave; vitamin C c&oacute; th? ngan ch?n s? kh?i ph&aacute;t c?a nhi?u b?nh m&atilde;n t&iacute;nh v&agrave; tang cu?ng s?c kh?e t?ng th?</p>\r\n<p><strong>3. Ði?u tr? d? ?ng v&agrave; vi&ecirc;m</strong></p>\r\n<p>Ovomucoid c&oacute; trong nh?ng qu? tr?ng c&uacute;t nh? nh?n n&agrave;y ho?t d?ng nhu m?t th&agrave;nh ph?n ch?ng d? ?ng t? nhi&ecirc;n. Vi&ecirc;m, xung huy?t ho?c c&aacute;c tri?u ch?ng kh&aacute;c c?a ph?n ?ng d? ?ng c&oacute; th? du?c gi?m b?t v?i s? tr? gi&uacute;p c?a tr?ng c&uacute;t n?u b?n ti&ecirc;u th? n&oacute;.</p>\r\n<p><strong>4. Tang cu?ng trao d?i ch?t</strong></p>\r\n<p>Vitamin B c&oacute; trong nh?ng qu? tr?ng n&agrave;y c&oacute; th? tang cu?ng ho?t d?ng trao d?i ch?t tr&ecirc;n to&agrave;n co th? b?ng c&aacute;ch c?i thi?n ch?c nang c?a hormone v&agrave; enzyme</p>\r\n<p><strong>5. Tang cu?ng kh? nang mi?n d?ch</strong></p>\r\n<p>Tr?ng chim c&uacute;t c?i thi?n h? th?ng mi?n d?ch c?a b?n. Ch&uacute;ng l&agrave;m s?ch m&aacute;u kh?i d?c t? v&agrave; kim lo?i n?ng, tang cu?ng d? tinh khi?t c?a m&aacute;u, tang cu?ng tr&iacute; nh? v&agrave; tang ho?t d?ng c?a n&atilde;o.</p>\r\n<div id=\"ADS_159_15s\" class=\"txtCent\">\r\n<div id=\"ADS_159_15stxtBnrHor\"></div>\r\n</div>\r\n<p><strong>6. Tang n?ng d? huy?t s?c t? trong m&aacute;u</strong></p>\r\n<p>H&agrave;m lu?ng s?t cao trong tr?ng c&uacute;t c&oacute; th? gi&uacute;p ngu?i thi?u m&aacute;u ? m?c d? l?n. An tr?ng c&uacute;t thu?ng xuy&ecirc;n c?i thi?n n?ng d? hemoglobin.</p>\r\n<p><strong>7. C?i thi?n th? l?c</strong></p>\r\n<p>Vitamin A c&oacute; trong tr?ng chim c&uacute;t b?o v? th? l?c, gi&uacute;p gi?m tho&aacute;i h&oacute;a di?m v&agrave;ng v&agrave; ngan ng?a s? ph&aacute;t tri?n c?a d?c th?y tinh th?.</p>\r\n<p><strong>8. Ki?m so&aacute;t huy?t &aacute;p</strong></p>\r\n<p>Tr?ng chim c&uacute;t c&oacute; nhi?u kali. Kho&aacute;ng ch?t n&agrave;y gi&uacute;p gi?m cang th?ng cho c&aacute;c d?ng m?ch v&agrave; m?ch m&aacute;u, do d&oacute; gi? cho huy?t &aacute;p trong t?m ki?m so&aacute;t</p>', 2, 7, 0, 'https://cdn.24h.com.vn/upload/3-2019/images/2019-07-24/Ai-ngo-trung-chim-cut-co-the-chua-duoc-15-benh-cuc-hieu-qua-the-nay-1-1563963555-824-width600height450.jpg', 'https://cdn.24h.com.vn/upload/3-2019/images/2019-07-24/Ai-ngo-trung-chim-cut-co-the-chua-duoc-15-benh-cuc-hieu-qua-the-nay-1-1563963555-824-width600height450.jpg', '2020-06-10', 502, 7, 1, NULL, 2),
(5, '', 'An ki?u này v?a h?i s?c kh?e, v?a m?t ng? tri?n mi', '<h2 id=\"article_sapo\" class=\"ctTp tuht_show\">N?u b? m?t ng? nhung chua t&igrave;m du?c nguy&ecirc;n nh&acirc;n th&igrave; n&ecirc;n xem l?i nh?ng \r\nth&oacute;i quen an u?ng, sinh ho?t v&agrave; d&ocirc;i khi ch? c?n thay d?i th&oacute;i quen &ldquo;x?u&rdquo; n&agrave;y b?n c&oacute; th? kh?c \r\nph?c du?c.</h2>\r\n<p><strong>D&ugrave;ng b?a t?i qu&aacute; s?m ho?c qu&aacute; mu?n</strong></p>\r\n<p>An qu&aacute; s?m hay qu&aacute; mu?n c&oacute; th? ?nh hu?ng d?n&nbsp;gi?c ng?. Trong tru?ng h?p d?u ti&ecirc;n b?n c&oacute; th? d&oacute;i b?ng khi di ng?, c&ograve;n tru?ng h?p sau th&igrave; vi?c ti&ecirc;u h&oacute;a d&atilde; ?nh hu?ng d?n gi?c ng?. N?u b?n an qu&aacute; s?m n&ecirc;n b? sung th&ecirc;m b&aacute;t b?t ngu c?c v?i s?a v&agrave; co th? c?n &iacute;t nh?t 2 gi? d? ti&ecirc;u h&oacute;a h?t th?c an.</p>\r\n<p><strong>U?ng nhi?u th?c u?ng c&oacute; c?n hay c&agrave; ph&ecirc;</strong></p>\r\n<p>Th?c u?ng c&oacute; c?n gi&uacute;p b?n ch&igrave;m v&agrave;o gi?c ng? r?t nhanh nhung d&ocirc;i khi g&acirc;y m?t nu?c v&agrave; c&oacute; th? g&acirc;y r?i lo?n v&agrave;i giai do?n c?a gi?c ng? khi?n b?n l?i t?nh gi?c.</p>\r\n<p>Luu &yacute; kh&ocirc;ng n&ecirc;n u?ng c&agrave; ph&ecirc; v&agrave;o bu?i t?i. Theo trang web Reader&rsquo;s Digest-M?. th&igrave; u?ng c?c c&agrave; ph&ecirc; v&agrave;o bu?i chi?u gi&uacute;p t?p trung tu tu?ng l&agrave;m vi?c nhung d&ocirc;i khi l&agrave;m b?n t?nh t&aacute;o v&agrave;o ban d&ecirc;m, kh&ocirc;ng n&ecirc;n u?ng qu&aacute; 3-4 c?c c&agrave; ph&ecirc; m?i ng&agrave;y.</p>\r\n<p><strong>Lu?ng th?c an qu&aacute; nhi?u</strong></p>\r\n<p>V&agrave;o bu?i t?i an qu&aacute; nhi?u s? kh&ocirc;ng t?t cho co th? v&igrave; h? ti&ecirc;u h&oacute;a ph?i l&agrave;m vi?c nhi?u hon so v?i \r\nkhi ch&uacute;ng ta d?ng hay ng?i. Tuy v?y n?u an qu&aacute; &iacute;t cung kh&ocirc;ng n&ecirc;n v&igrave; khi di ng? v?i c?m gi&aacute;c d&oacute;i khi?n b?n lo &acirc;u v&agrave; dau d? d&agrave;y... N&ecirc;n c&oacute; ch? d? an u?ng h?p l&yacute; d? c&oacute; th? ch&igrave;m v&agrave;o \r\ngi?c ng? ngon.</p>\r\n<div id=\"ADS_159_15s\" class=\"txtCent\">\r\n<div id=\"ADS_159_15stxtBnrHor\"></div>\r\n<div class=\"banner_inread\">&nbsp;</div>\r\n<span id=\"ADS_159_15s_0\" class=\"m_banner_show\"></span></div>\r\n<p><strong>D&ugrave;ng nhi?u ch?t b&eacute;o, du?ng&hellip;</strong></p>\r\n<p>N?u b?n th&iacute;ch an cay th&igrave; n&ecirc;n d&agrave;nh cho bu?i an trua. Ti&ecirc;u h&oacute;a c&aacute;c ch?t n&agrave;y g&acirc;y c?m gi&aacute;c n&oacute;ng r&aacute;t d? d&agrave;y hay tr&agrave;o ngu?c v&agrave; g&acirc;y c?m gi&aacute;c kh&oacute; ch?u v? d&ecirc;m. Nh?ng th?c ph?m nhi?u ch?t du?ng, b&eacute;o cung ?nh hu?ng d?n gi?c ng?.&nbsp;</p>\r\n<p><strong>Nh?ng th?c ph?m kh&ocirc;ng n&ecirc;n v&agrave;o bu?i t?i</strong></p>\r\n<p><strong>Th?c ph?m cay</strong></p>\r\n<p>Th?c ph?m cay thu?ng du?c khuy?n kh&iacute;ch trong th?c don gi?m c&acirc;n nhung n&oacute; cung c&oacute; th? khi?n b?n kh&oacute; ng? v&igrave; g&acirc;y ra ch?ng ? n&oacute;ng. Th?c an cay cung l&agrave;m tang nhi?t d? co th?, khi?n b?n kh&oacute; di v&agrave;o gi?c ng?.</p>\r\n<p><strong>Th?c ph?m ch? bi?n s?n</strong></p>\r\n<p><strong>Th?t x&ocirc;ng kh&oacute;i, x&uacute;c x&iacute;ch hay c&aacute;c s?n ph?m ch? bi?n s?n thu?ng ch?a h&agrave;m lu?ng l?n tyramine, m?t axit amin gi&uacute;p s?n sinh ra ch?t k&iacute;ch th&iacute;ch n&atilde;o norepinephrine c&ugrave;ng h&agrave;m lu?ng cao ch?t b&eacute;o v&agrave; protein ti&ecirc;u h&oacute;a r?t ch?m. V&igrave; v?y, n?u b?n an th?t x&ocirc;ng kh&oacute;i ngay tru?c khi di ng?, b?n s? c?m th?y kh&ocirc;ng tho?i m&aacute;i v&agrave; s? kh&ocirc;ng th? ng? du?c v&igrave; n&atilde;o v&agrave; d? d&agrave;y c?a b?n v?n s? ho?t d?ng.</strong></p>     \r\n<p><strong>H&agrave;nh t&acirc;y</strong></p>\r\n<p>H&agrave;nh t&acirc;y c&oacute; th? g&acirc;y d?y hoi v&igrave; ch&uacute;ng ch?a ch?t xo h&ograve;a tan g?i l&agrave; fructans. Ði?u n&agrave;y s? ?nh hu?ng &iacute;t nhi?u t?i gi?c ng?. V&igrave; v?y, n?u b?n mu?n ng? ngon, h&atilde;y d?m b?o r?ng b?a t?i kh&ocirc;ng ch?a nhi?u h&agrave;nh t&acirc;y.</p>', 4, 7, 0, 'https://cdn.24h.com.vn/upload/3-2020/images/2020-07-01/1593572341-1d7d65be37e500291e307977404da0e7.jpg', 'https://cdn.24h.com.vn/upload/3-2020/images/2020-07-01/1593572341-1d7d65be37e500291e307977404da0e7.jpg', '2020-05-16', 502, 3, 1, NULL, 2),
(6, '', 'Nh?ng hình ?nh m?t th?i c?a c?p dôi Vân Son - B?o ', '<h2 id=\"article_sapo\" class=\"ctTp tuht_show\">M?i d&acirc;y, danh h&agrave;i V&acirc;n Son chia s? lo?t ?nh c&ugrave;ng B?o Li&ecirc;m thu? d?u muu sinh ? M?, th&agrave;nh l?p nh&oacute;m h&agrave;i v&agrave; th&agrave;nh c&ocirc;ng vang d?i.</h2>\r\n<div class=\"sbNws\">S? ki?n:&nbsp;<a class=\"sbevt clrGr fs12\" title=\"H&agrave;i V&Acirc;N SON B?O LI&Ecirc;M\" href=\"https://www.24h.com.vn/hai-van-son-bao-liem-c746e2562.html\">H&agrave;i V&Acirc;N SON B?O LI&Ecirc;M</a></div>\r\n<p>V&agrave;o nh?ng nam 90, tr&ecirc;n c&aacute;c s&acirc;n kh?u h?i ngo?i, V&acirc;n Son &ndash; B?o Li&ecirc;m c&ugrave;ng MC Vi?t Th?o t?ng l&agrave; c?p di?n vi&ecirc;n h&agrave;i du?c y&ecirc;u th&iacute;ch nh?t nh&igrave;, kh&ocirc;ng k&eacute;m c?nh Ho&agrave;i Linh &ndash; Ch&iacute; T&agrave;i. Th? nhung sau d&oacute; kh&ocirc;ng l&acirc;u, danh h&agrave;i B?o Li&ecirc;m d&atilde; b?t ng? t&aacute;ch nh&oacute;m.</p>\r\n<p>Th?i di?m n&agrave;y, ngh? si h&agrave;i B?o Chung sang M? d?nh cu n&ecirc;n anh v&agrave; V&acirc;n Son k?t h?p v?i nhau, c?p d&ocirc;i di?n vi&ecirc;n h&agrave;i du?c kh&aacute;n gi? y&ecirc;u th&iacute;ch kh&ocirc;ng k&eacute;m. M?c d&ugrave; v?y, m?i khi nh?c d?n hai c&aacute;i t&ecirc;n V&acirc;n Son - B?o Li&ecirc;m, nhi?u ngu?i h&acirc;m m? v?n nh? t?i nh?ng ti?u ph?m h&agrave;i duy&ecirc;n d&aacute;ng c?a hai danh h&agrave;i n&agrave;y.</p>\r\n<p>B?o Li&ecirc;m (tr&aacute;i) v&agrave; V&acirc;n Son khi m?i d?n M? v&agrave;o d?u th?p ni&ecirc;n 1990. V&acirc;n Son k?, c? hai g?p l?i nhau \r\nnoi x? ngu?i nhu m?t d?nh m?nh. Sau m?t l?n di?n t?i h?i ch? T?t cho ngu?i Vi?t ? California, V&acirc;n Son nh?n du?c cu?c g?i t? m?t s? l?.</p>  \r\n<p>\"H&oacute;a ra d&oacute; l&agrave; B?o Li&ecirc;m - th?ng b?n n?i kh? c?a t&ocirc;i thu? c&ograve;n ? Vi?t Nam. Li&ecirc;m th?y h&igrave;nh t&ocirc;i tr&ecirc;n poster ? h?i ch? n&ecirc;n t&igrave;m c&aacute;ch li&ecirc;n l?c ban t? ch?c d? xin s? c?a t&ocirc;i\", anh k?.</p>\r\n<p>G?p l?i B?o Li&ecirc;m, V&acirc;n Son quy?t t&acirc;m l?p nh&oacute;m h&agrave;i, d&ugrave; tru?c d&oacute; anh d&atilde; di?n chung Quang Minh, Charlie Nguy?n (em h?)... L&uacute;c ?y, B?o Li&ecirc;m ? bang Arizona, v? dang mang b?u, cu?c s?ng d?n ?n d?nh. V&acirc;n Son r? anh chuy?n sang California ho?t d?ng v&igrave; noi d&acirc;y d&ocirc;ng kh&aacute;n gi? Vi?t. Hai c?p v? ch?ng V&acirc;n Son v&agrave; B?o Li&ecirc;m thu&ecirc; m?t can h? hai ph&ograve;ng ng? chung s?ng.</p>\r\n<p>Th?i gian d?u, h? di?n ? m?t s? d&aacute;m cu?i, vu tru?ng... v?i th? lo?i h&agrave;i song t?u (stand-up comedy). Ð&ocirc;i ngh? si l?t v&agrave;o m?t xanh m?t &ocirc;ng \"b?u\" v&agrave; du?c m?i quay video. Sau v&agrave;i s? d?u ph&aacute;t h&agrave;nh, h? n?i ti?ng trong c?ng d?ng ngu?i \r\nVi?t to&agrave;n nu?c M?.</p>\r\n<p>Nh?ng ti?u ph?m du?c y&ecirc;u th&iacute;ch c?a h? l&agrave; \"L?y ch?ng x? l?\", \"Oan gia d?i m?t\", \"C&ocirc; T?m ng&agrave;y nay\"... Ð&ocirc;i \r\nngh? si du?c m?i luu di?n t?i c&aacute;c bang ? M? l?n kh?p th? gi?i. V&acirc;n Son k?: \"L?n d?u, t&ocirc;i c?m nh?n du?c s?  (di&ecirc;n cu?ng) c?a kh&aacute;n gi?. H? h&acirc;m m? ch&uacute;ng t&ocirc;i nhu nh?ng ng&ocirc;i sao nh?c rock\"</p>\r\n<p>Bu?c ngo?t d?n v?i V&acirc;n Son - B?o Li&ecirc;m khi t? ph&aacute;t h&agrave;nh video h&agrave;i ri&ecirc;ng, b&aacute;n du?c hon 20.000 bang \r\nv?i s? d?u ti&ecirc;n, d?t doanh thu hon 100.000 USD. H? c&ograve;n k?t h?p v?i nhi?u ngh? si nhu Quang Minh (h&agrave;ng tr&ecirc;n), H?ng Ð&agrave;o, B?o Chung, L&ecirc; Hu?nh...</p>\r\n<p>Sau v&agrave;i nam h?p t&aacute;c, V&acirc;n Son - B?o Li&ecirc;m t&aacute;ch ri&ecirc;ng. V&acirc;n Son k?t h?p Ho&agrave;i Linh v&agrave; d?t du?c th&agrave;nh c&ocirc;ng tuong t?.</p>', 3, 4, 0, 'https://cdn.24h.com.vn/upload/3-2019/images/2019-07-27/1564221094-61-cap-doi-hai-dinh-dam-bao-liem---van-son-ra-sao-khi-khong-con-hop-tac-60338271_2273842209339041_2544536817416273920_n-1563529937-width960height720.jpg', 'https://cdn.24h.com.vn/upload/3-2019/images/2019-07-27/1564221094-61-cap-doi-hai-dinh-dam-bao-liem---van-son-ra-sao-khi-khong-con-hop-tac-60338271_2273842209339041_2544536817416273920_n-1563529937-width960height720.jpg', '2020-04-15', 501, 4, 1, NULL, 2),
(7, '', 'Cu?c hôn nhân 20 nam c?a ngh? si hài T?n Bo và ngu', '<h2 id=\"article_sapo\" class=\"ctTp tuht_show\">L?n hi?m hoi c&ugrave;ng b&agrave; x&atilde; l&ecirc;n s&oacute;ng truy?n h&igrave;nh, v? ch?ng em trai danh h&agrave;i T?n Beo tr?i l&ograve;ng v? cu?c s?ng hi?n t?i.</h2>\r\n<div class=\"sbNws\">S? ki?n:&nbsp;<a class=\"sbevt clrGr fs12\" title=\"Chuy?n c?a sao\" href=\"https://www.24h.com.vn/chuyen-cua-sao-c102e1244.html\">Chuy?n c?a sao</a>,&nbsp;<a class=\"sbevt clrGr\" title=\"H?u tru?ng nh?ng ng&ocirc;i sao\" href=\"https://www.24h.com.vn/hau-truong-nhung-ngoi-sao-c74e1231.html\">H?u tru?ng nh?ng ng&ocirc;i sao</a></div>\r\n<p>V?i nh?ng kh&aacute;n gi? y&ecirc;u th&iacute;ch h&agrave;i k?ch mi?n Nam, hai c&aacute;i t&ecirc;n kh&ocirc;ng th? kh&ocirc;ng nh?c d?n l&agrave; m?t \"c?p b&agrave;i tr&ugrave;ng\" tr&ecirc;n s&acirc;n kh?u ch&iacute;nh l&agrave; anh em T?n Beo - T?n Bo. Hi?n t?i, tuy c? hai d&atilde; kh&ocirc;ng c&ograve;n di?n chung, m?i ngu?i cung c&oacute; hu?ng l&agrave;m ngh? thu?t ri&ecirc;ng nhung cu?c s?ng c?a hai ngh? si v?n r?t du?c kh&aacute;n gi? quan t&acirc;m. L&agrave; kh&aacute;ch m?i c?a chuong tr&igrave;nh \"Gi?i m&atilde; tri k?\" tu?n n&agrave;y, ngh? si h&agrave;i T?n Bo \r\nd&atilde; c&ugrave;ng b&agrave; x&atilde; ti?t l? nhi?u di?u sau 20 nam k?t h&ocirc;n.&nbsp;</p>\r\n<p>R?t &iacute;t khi nh?c d?n b&agrave; x&atilde;, tuy nhi&ecirc;n v?i b?n b&egrave; hay nh?ng kh&aacute;n gi? d&atilde; quan t&acirc;m d?n ch?ng \r\ndu?ng l&agrave;m ngh? c?a T?n Bo t? l&acirc;u d?u bi?t d?n danh t&iacute;nh ngu?i ph? n? d?ng sau anh. V? T?n Bo g&acirc;y ch&uacute; &yacute; v?i kh? nang s&aacute;ng t&aacute;c, &iacute;t ngu?i bi?t r?ng c&aacute;i t&ecirc;n&nbsp;nh?c si Xu&acirc;n Nhi ch&iacute;nh l&agrave; v? T?n Bo. N? \r\nnh?c si d&atilde; g&acirc;y d?u ?n v?i h&agrave;ng lo?t ca kh&uacute;c du?c kh&aacute;n gi? 8X, 9X y&ecirc;u th&iacute;ch nhu: \"T&igrave;nh y&ecirc;u v&agrave; gi?t nu?c m?t\", \"K? da t&igrave;nh\", \"M?t l?i cho mai sau\", \"Y&ecirc;u trong l?m l?\"... Kh&ocirc;ng ch? c&oacute; kh? nang s&aacute;ng t&aacute;c, nh?c si Xu&acirc;n Nhi c&ograve;n mong mu?n tr? th&agrave;nh ca si, h&aacute;t c&aacute;c ca kh&uacute;c c?a m&igrave;nh. Tuy nhi&ecirc;n khi m?i 18 tu?i, c&ocirc; d&atilde; ch?n k?t h&ocirc;n, cham lo cho gia d&igrave;nh v&agrave; g&aacute;c l?i ni?m dam&nbsp;m&ecirc; v?i &acirc;m nh?c.&nbsp;</p>\r\n<p>B?t d?u vi?t nh?c t? nam 16 tu?i, n? nh?c si ti?t l? b?n th&acirc;n r?t may m?n khi c&aacute;c ca kh&uacute;c c?a m&igrave;nh du?c nhi?u ca si \r\nch?n d? th? hi?n. Th?m ch&iacute;, th?i di?m c&ocirc; c&ograve;n chua v?ng v? nh?c l&iacute; d&atilde; c&oacute; th? b&aacute;n du?c nh?c: \"Khi anh Vinh Thuy&ecirc;n l&agrave; qu?n l&yacute; c?a ch? Uy&ecirc;n Trang g?i cho t&ocirc;i, h?i t&ocirc;i&nbsp;c&oacute; b&agrave;i n&agrave;o kh&ocirc;ng th&igrave; t&ocirc;i&nbsp;dua cho anh 3 b&agrave;i. Ðu?c ch?n 1 b&agrave;i v?i t&ocirc;i&nbsp;cung vui r?i nhung anh ?y&nbsp;g?i l?i b?o t&ocirc;i&nbsp;ra k&yacute; h?p d?ng 3 b&agrave;i lu&ocirc;n, l&uacute;c d&oacute;&nbsp;th&igrave; th?c s? t&ocirc;i&nbsp;r?t vui\", Xu&acirc;n Nhi nh? l?i th?i di?m du?c ca si Uy&ecirc;n Trang li&ecirc;n h? mua b&agrave;i h&aacute;t.&nbsp;</p>\r\n<p>T?ng c&oacute; s? nghi?p \"s&aacute;ng\" t? khi m?i b?t d?u, nhung Xu&acirc;n Nhi v?n ch?n cu?c s?ng gia d&igrave;nh sau khi k?t h&ocirc;n. Nh&igrave;n l?i ch?ng du?ng 20 nam v?i T?n Bo c&ugrave;ng 4 ngu?i con, n? nh?c si v?n h?nh ph&uacute;c nhu thu? ban d?u. Chia s? v? l&iacute; do kh&ocirc;ng tham gia \"Gi?i m&atilde; tri k?\" v?i T?n Beo m&agrave; l?i cho v? xu?t hi?n tr&ecirc;n s&oacute;ng truy?n h&igrave;nh, ngh? si T?n Bo cung vui v? ti?t l?: \"B?n th&acirc;n t&ocirc;i&nbsp;s?ng kh&eacute;p k&iacute;n, ?n d?t v&igrave; c&oacute; nh?ng n?i ni?m ri&ecirc;ng tu n&ecirc;n kh&ocirc;ng th&iacute;ch n&oacute;i nhi?u v? b?n th&acirc;n m&igrave;nh. Ð&aacute;ng l? t&ocirc;i&nbsp;xu?t hi?n v?i anh Beo th&igrave; kh&aacute;n gi? s? bi?t nhi?u nhung sau m?t h?i suy nghi th&igrave; t&ocirc;i&nbsp;mu?n xu?t hi?n c&ugrave;ng b&agrave; x&atilde; d? m?i ngu?i du?c bi?t v? ngu?i ph? n? b&ecirc;n c?nh t&ocirc;i\".</p>\r\n<p>V? ph?n T?n Bo, c&oacute; h?u phuong v?ng ch?c l&agrave; b&agrave; x&atilde; t&agrave;i gi?i v&agrave; c&aacute;c con ngoan ngo&atilde;n, anh v?n cham ch? di di?n d? cham lo cho gia d&igrave;nh. Hi?n t?i khi t&igrave;nh h&igrave;nh s&acirc;n kh?u dang di xu?ng, l?p ngh? si tr? ng&agrave;y m?t da nang nhung T?n Bo cung kh&ocirc;ng lo l?ng v? t&ecirc;n tu?i c?a m&igrave;nh s? b? d&agrave;n em thay th?. \"T&ocirc;i&nbsp;kh&ocirc;ng s? \r\nt&ecirc;n tu?i b? mai m?t v&agrave; cho t?i th?i di?m b&acirc;y gi?, t&ocirc;i&nbsp;d&atilde; m&atilde;n nguy?n v?i v? tr&iacute; c?a m&igrave;nh. T&ocirc;i&nbsp;c&agrave;ng t? h&agrave;o hon v&igrave; c&oacute; nh?ng l?p d&agrave;n em t&agrave;i nang k? ti?p m&igrave;nh. Kh&aacute;n gi? c&oacute; th? kh&ocirc;ng th?y t&ocirc;i&nbsp;thu?ng xuy&ecirc;n nhung nh?c t?i t&ecirc;n T?n Bo ngu?i ta c&ograve;n nh? l&agrave; du?c r?i\", nam danh h&agrave;i chia s?.&nbsp;</p>\r\n<h2 id=\"article_sapo\" class=\"ctTp tuht_show\">L?n hi?m hoi c&ugrave;ng b&agrave; x&atilde; l&ecirc;n s&oacute;ng truy?n h&igrave;nh, v? ch?ng em trai danh h&agrave;i T?n Beo tr?i l&ograve;ng v? cu?c s?ng hi?n t?i.</h2>\r\n<div class=\"sbNws\">S? ki?n:&nbsp;<a class=\"sbevt clrGr fs12\" title=\"Chuy?n c?a sao\" href=\"https://www.24h.com.vn/chuyen-cua-sao-c102e1244.html\">Chuy?n c?a sao</a>,&nbsp;<a class=\"sbevt clrGr\" title=\"H?u tru?ng nh?ng ng&ocirc;i sao\" href=\"https://www.24h.com.vn/hau-truong-nhung-ngoi-sao-c74e1231.html\">H?u tru?ng nh?ng ng&ocirc;i sao</a></div>\r\n<p>V?i nh?ng kh&aacute;n gi? y&ecirc;u th&iacute;ch h&agrave;i k?ch mi?n Nam, hai c&aacute;i t&ecirc;n kh&ocirc;ng th? kh&ocirc;ng nh?c d?n l&agrave; m?t \"c?p b&agrave;i tr&ugrave;ng\" tr&ecirc;n s&acirc;n kh?u ch&iacute;nh l&agrave; anh em T?n Beo - T?n Bo. Hi?n t?i, tuy c? hai d&atilde; kh&ocirc;ng c&ograve;n di?n chung, m?i ngu?i cung c&oacute; hu?ng l&agrave;m ngh? thu?t ri&ecirc;ng nhung cu?c s?ng c?a hai ngh? si v?n r?t du?c kh&aacute;n gi? quan t&acirc;m. L&agrave; kh&aacute;ch m?i c?a chuong tr&igrave;nh \"Gi?i m&atilde; tri k?\" tu?n n&agrave;y, ngh? si h&agrave;i T?n Bo \r\nd&atilde; c&ugrave;ng b&agrave; x&atilde; ti?t l? nhi?u di?u sau 20 nam k?t h&ocirc;n.&nbsp;</p>\r\n<p>R?t &iacute;t khi nh?c d?n b&agrave; x&atilde;, tuy nhi&ecirc;n v?i b?n b&egrave; hay nh?ng kh&aacute;n gi? d&atilde; quan t&acirc;m d?n ch?ng \r\ndu?ng l&agrave;m ngh? c?a T?n Bo t? l&acirc;u d?u bi?t d?n danh t&iacute;nh ngu?i ph? n? d?ng sau anh. V? T?n Bo g&acirc;y ch&uacute; &yacute; v?i kh? nang s&aacute;ng t&aacute;c, &iacute;t ngu?i bi?t r?ng c&aacute;i t&ecirc;n&nbsp;nh?c si Xu&acirc;n Nhi ch&iacute;nh l&agrave; v? T?n Bo. N? \r\nnh?c si d&atilde; g&acirc;y d?u ?n v?i h&agrave;ng lo?t ca kh&uacute;c du?c kh&aacute;n gi? 8X, 9X y&ecirc;u th&iacute;ch nhu: \"T&igrave;nh y&ecirc;u v&agrave; gi?t nu?c m?t\", \"K? da t&igrave;nh\", \"M?t l?i cho mai sau\", \"Y&ecirc;u trong l?m l?\"... Kh&ocirc;ng ch? c&oacute; kh? nang s&aacute;ng t&aacute;c, nh?c si Xu&acirc;n Nhi c&ograve;n mong mu?n tr? th&agrave;nh ca si, h&aacute;t c&aacute;c ca kh&uacute;c c?a m&igrave;nh. Tuy nhi&ecirc;n khi m?i 18 tu?i, c&ocirc; d&atilde; ch?n k?t h&ocirc;n, cham lo cho gia d&igrave;nh v&agrave; g&aacute;c l?i ni?m dam&nbsp;m&ecirc; v?i &acirc;m nh?c.&nbsp;</p>\r\n<p>B?t d?u vi?t nh?c t? nam 16 tu?i, n? nh?c si ti?t l? b?n th&acirc;n r?t may m?n khi c&aacute;c ca kh&uacute;c c?a m&igrave;nh du?c nhi?u ca si \r\nch?n d? th? hi?n. Th?m ch&iacute;, th?i di?m c&ocirc; c&ograve;n chua v?ng v? nh?c l&iacute; d&atilde; c&oacute; th? b&aacute;n du?c nh?c: \"Khi anh Vinh Thuy&ecirc;n l&agrave; qu?n l&yacute; c?a ch? Uy&ecirc;n Trang g?i cho t&ocirc;i, h?i t&ocirc;i&nbsp;c&oacute; b&agrave;i n&agrave;o kh&ocirc;ng th&igrave; t&ocirc;i&nbsp;dua cho anh 3 b&agrave;i. Ðu?c ch?n 1 b&agrave;i v?i t&ocirc;i&nbsp;cung vui r?i nhung anh ?y&nbsp;g?i l?i b?o t&ocirc;i&nbsp;ra k&yacute; h?p d?ng 3 b&agrave;i lu&ocirc;n, l&uacute;c d&oacute;&nbsp;th&igrave; th?c s? t&ocirc;i&nbsp;r?t vui\", Xu&acirc;n Nhi nh? l?i th?i di?m du?c ca si Uy&ecirc;n Trang li&ecirc;n h? mua b&agrave;i h&aacute;t.&nbsp;</p>\r\n<p>T?ng c&oacute; s? nghi?p \"s&aacute;ng\" t? khi m?i b?t d?u, nhung Xu&acirc;n Nhi v?n ch?n cu?c s?ng gia d&igrave;nh sau khi k?t h&ocirc;n. Nh&igrave;n l?i ch?ng du?ng 20 nam v?i T?n Bo c&ugrave;ng 4 ngu?i con, n? nh?c si v?n h?nh ph&uacute;c nhu thu? ban d?u. Chia s? v? l&iacute; do kh&ocirc;ng tham gia \"Gi?i m&atilde; tri k?\" v?i T?n Beo m&agrave; l?i cho v? xu?t hi?n tr&ecirc;n s&oacute;ng truy?n h&igrave;nh, ngh? si T?n Bo cung vui v? ti?t l?: \"B?n th&acirc;n t&ocirc;i&nbsp;s?ng kh&eacute;p k&iacute;n, ?n d?t v&igrave; c&oacute; nh?ng n?i ni?m ri&ecirc;ng tu n&ecirc;n kh&ocirc;ng th&iacute;ch n&oacute;i nhi?u v? b?n th&acirc;n m&igrave;nh. Ð&aacute;ng l? t&ocirc;i&nbsp;xu?t hi?n v?i anh Beo th&igrave; kh&aacute;n gi? s? bi?t nhi?u nhung sau m?t h?i suy nghi th&igrave; t&ocirc;i&nbsp;mu?n xu?t hi?n c&ugrave;ng b&agrave; x&atilde; d? m?i ngu?i du?c bi?t v? ngu?i ph? n? b&ecirc;n c?nh t&ocirc;i\".</p>\r\n<p>V? ph?n T?n Bo, c&oacute; h?u phuong v?ng ch?c l&agrave; b&agrave; x&atilde; t&agrave;i gi?i v&agrave; c&aacute;c con ngoan ngo&atilde;n, anh v?n cham ch? di di?n d? cham lo cho gia d&igrave;nh. Hi?n t?i khi t&igrave;nh h&igrave;nh s&acirc;n kh?u dang di xu?ng, l?p ngh? si tr? ng&agrave;y m?t da nang nhung T?n Bo cung kh&ocirc;ng lo l?ng v? t&ecirc;n tu?i c?a m&igrave;nh s? b? d&agrave;n em thay th?. \"T&ocirc;i&nbsp;kh&ocirc;ng s? \r\nt&ecirc;n tu?i b? mai m?t v&agrave; cho t?i th?i di?m b&acirc;y gi?, t&ocirc;i&nbsp;d&atilde; m&atilde;n nguy?n v?i v? tr&iacute; c?a m&igrave;nh. T&ocirc;i&nbsp;c&agrave;ng t? h&agrave;o hon v&igrave; c&oacute; nh?ng l?p d&agrave;n em t&agrave;i nang k? ti?p m&igrave;nh. Kh&aacute;n gi? c&oacute; th? kh&ocirc;ng th?y t&ocirc;i&nbsp;thu?ng xuy&ecirc;n nhung nh?c t?i t&ecirc;n T?n Bo ngu?i ta c&ograve;n nh? l&agrave; du?c r?i\", nam danh h&agrave;i chia s?.&nbsp;</p>\r\n<p>Sau t?t c? nh?ng bi?n c? trong qu&aacute; kh? v&agrave; nh?ng kh&oacute; khan trong cu?c s?ng, di?u quan tr?ng nh?t ? v? ch?ng T?n Bo d&oacute; l&agrave; v?n g&igrave;n gi? du?c gia d&igrave;nh tr?n v?n cho c&aacute;c con. Cu?i chuong tr&igrave;nh, nh?c si Xu&acirc;n Nhi d&atilde; x&uacute;c d?ng g?i l?i d?n ch?ng: \"C?m on anh d&atilde; chung s?ng c&ugrave;ng em 20 nam, cho em m&oacute;n qu&agrave; l&agrave; 4 thi&ecirc;n th?n nh?. Ð&ocirc;i l&uacute;c em c?c c?n, n&oacute;ng t&iacute;nh khi?n anh bu?n l&ograve;ng. Anh an chay tru?ng em cung bi?t nhung em chua n?u cho anh du?c b?a an ngon n&ecirc;n em s? c? g?ng\". Ð&aacute;p l?i v?, T?n Bo cung n&oacute;i l?i c?m on v&igrave; su?t qu&atilde;ng th?i gian qua, c&ugrave;ng v?i d&oacute; l&agrave; s? hy sinh t? b&agrave; x&atilde; khi kh&ocirc;ng s? nguy hi?m, sinh cho anh d?n 4 ngu?i con.</p>', 2, 4, 0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJrXUuC5XmLYvOPASWUozf3FtRGeNgx4aHIhmvjtr1zkIB1IDK&s', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJrXUuC5XmLYvOPASWUozf3FtRGeNgx4aHIhmvjtr1zkIB1IDK&s', '2020-05-06', 751, 2, 1, NULL, 2),
(8, '', 'Nam MC g?p r?c r?i vì quá gi?ng Tu?n “kh?” b?n 5 n', '<h2 id=\"article_sapo\" class=\"ctTp tuht_show\">&ldquo;Qu&aacute; nhi?u ngu?i k?t b?n, th?i di?m nh?y c?m qu&aacute;&rdquo;, MC Ð&igrave;nh Hi?u chia s?.</h2>\r\n<div class=\"sbNws\">S? ki?n:&nbsp;<a class=\"sbevt clrGr fs12\" title=\"Chuy?n c?a sao\" href=\"https://www.24h.com.vn/chuyen-cua-sao-c102e1244.html\">Chuy?n c?a sao</a></div>\r\n<p><em>&ldquo;Ð&ocirc;i khi ngu?i gi?ng ngu?i cung kh?. Trong khi Tu?n &ldquo;kh?&rdquo; chua b? b?t, th&igrave; di?n vi&ecirc;n Ð&igrave;nh Hi?u \r\nd?ng n&ecirc;n ra du?ng ho?c di v? hu?ng C? Chi, T&acirc;y Ninh, ch? kh&ocirc;ng d? g&acirc;y hi?u l?m th&igrave; kh? nha&rdquo;,</em>&nbsp;l&agrave; b&agrave;i bi?t du?c nhi?u di?n d&agrave;n lan t?a r?ng r&atilde;i. K&egrave;m theo d&oacute; l&agrave; h&igrave;nh ?nh so s&aacute;nh gi?a MC, di?n vi&ecirc;n Ð&igrave;nh Hi?u v?i Tu?n &ldquo;kh?&rdquo; &ndash; d?i tu?ng dang b? c&ocirc;ng an truy n&atilde; sau khi b?n 5 ngu?i ch?t ? C? Chi, TP.HCM. Theo nhi?u d&acirc;n m?ng, di?n m?o c? hai c&oacute; nhi?u n&eacute;t tuong d?ng, n?u nh&igrave;n tho&aacute;ng qua th&igrave; r?t d? nh?m l?n.<em>&nbsp;&ldquo;T&ocirc;i th?y Ð&igrave;nh Hi?u gi?ng Tu?n &ldquo;kh?&rdquo; 99%&rdquo;,</em>&nbsp;m?t t&agrave;i kho?n d? l?i l?i b&igrave;nh.</p>\r\n<p>Trao d?i v?i ph&oacute;ng vi&ecirc;n, MC, di?n vi&ecirc;n Ð&igrave;nh Hi?u cho bi?t, nh?ng ng&agrave;y qua anh nh?n du?c r?t nhi?u l?i m?i k?t \r\nb?n, cung nhu th?y nhi?u h&igrave;nh ?nh c?a b?n th&acirc;n b? so s&aacute;nh v?i s&aacute;t th? nguy hi?m.&nbsp;<em>&ldquo;T&ocirc;i kh&ocirc;ng \r\nbi?t ai gh&eacute;p ?nh v&agrave; m?c d&iacute;ch c?a h? l&agrave; g&igrave;. T&ocirc;i kh&ocirc;ng quan t&acirc;m l?m. T&ocirc;i th?y m&igrave;nh ch? gi?ng Tu?n &ldquo;kh?&rdquo; ch&uacute;t n&agrave;o. T&ocirc;i d?p trai hon h?n nhi?u. T&ocirc;i bi?t c&oacute; ngu?i gi?ng h?n hon. B?n b&egrave; mang t&ocirc;i ra tr&ecirc;u r?i cung xong&rdquo;,&nbsp;</em>Ð&igrave;nh Hi?u b&agrave;y t?.</p>\r\n<div id=\"ADS_159_15s\" class=\"txtCent\">\r\n<div id=\"ADS_159_15stxtBnrHor\"></div>\r\n<div class=\"banner_inread\">&nbsp;</div>\r\n<span id=\"ADS_159_15s_0\" class=\"m_banner_show\"></span></div>\r\n<p>B?t ng? nh?n du?c nhi?u s? quan t&acirc;m t? c&ocirc;ng ch&uacute;ng, Ð&igrave;nh Hi?u th?a nh?n b?n th&acirc;n c&oacute; g?p ch&uacute;t phi?n to&aacute;i v&agrave; r?c r?i, song anh kh&ocirc;ng l&agrave;m v?n d? th&ecirc;m nghi&ecirc;m tr?ng.&nbsp;<em>&ldquo;T&ocirc;i s?ng l?c quan l?m. T&ocirc;i v?n ra du?ng di l&agrave;m, vui choi, ho?t d?ng th? thao b&igrave;nh thu?ng&rdquo;</em>, anh n&oacute;i.</p>\r\n<p>Ð&igrave;nh Hi?u sinh nam 1980, l&agrave; di?n vi&ecirc;n di?n ?nh, truy?n h&igrave;nh n?i ti?ng. Anh du?c bi?t d?n sau c&aacute;c b? phim nhu&nbsp;<em>Huong ph&ugrave; sa, Ngh? b&aacute;o, G?i gi?c mo v?, S&oacute;ng gi&oacute; cu?c d?i, C?ng m?t tr?i, &Ocirc;ng tr&ugrave;m,..</em></p>  \r\n<p>Ð&igrave;nh Hi?u choi th? thao&nbsp;r?t kh&aacute;, d?c bi?t l&agrave; b&oacute;ng d&aacute;&nbsp;v?i vai tr&ograve; ti?n d?o. V?i m&ocirc;n b&oacute;ng chuy?n, anh d?m nh?n&nbsp;v? tr&iacute; ch? c&ocirc;ng v&agrave; t?ng do?t nhi?u huy chuong V&agrave;ng khi c&ograve;n l&agrave; h?c sinh.</p>\r\n<p>Nam di?n vi&ecirc;n g?n b&oacute; v?i ngh? MC t? nam 2003. Anh t?ng d?n chuong tr&igrave;nh nhu&nbsp;<em>7 ng&agrave;y vui s?ng (VTV1), Chuy?n \r\nxe nh&acirc;n &aacute;i (TH Vinh Long), B?n c?a d?t (TH Ki&ecirc;n Giang)...</em></p>\r\n<p>Hi?n Ð&igrave;nh Hi?u c&ocirc;ng t&aacute;c ch? y?u ? d&agrave;i Vinh Long. Anh v?n tham gia d&oacute;ng phim, qu?n l&yacute; nh&agrave; h&agrave;ng ri&ecirc;ng ? S&agrave;i G&ograve;n.</p>', 2, 4, 0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtxIYJ9f4trvUioL0RGHk51uxbRrKP1VmZXxxyjz6Soha_jQM&s', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtxIYJ9f4trvUioL0RGHk51uxbRrKP1VmZXxxyjz6Soha_jQM&s', '2020-09-11', 654, 5, 1, NULL, 2),
(9, '', 'V?a nh?n th? du?i nu?c, v?a gi?i m?t lèo 6 kh?i ru', '<h2 id=\"article_sapo\" class=\"ctTp tuht_show\">M?t sinh vi&ecirc;n ? Gruzia d&atilde; gi?i th&agrave;nh c&ocirc;ng 6 kh?i rubik li&ecirc;n ti?p trong m?t l?n nh?n th? duy nh?t du?i nu?c.</h2>\r\n<p>K? l?c gi?i kh?i rubik du?i c?a c?a ch&agrave;ng thanh ni&ecirc;n Vako Marchilashvili, 18 tu?i, di?n ra ng&agrave;y 17.8 tru?c d&aacute;m d&ocirc;ng, t?i c&ocirc;ng vi&ecirc;n h?i duong Gino Paradise ? th&agrave;nh ph? Tbilisi, Gruzia.</p>\r\n<p>Trong th?i gian nh?n th? du?i nu?c trong th?i gian 1 ph&uacute;t 44 gi&acirc;y, sinh vi&ecirc;n 18 tu?i d&atilde; gi?i th&agrave;nh c&ocirc;ng \r\nt?ng c?ng 6 kh?i rubik tru?c s? c? vu nhi?t t&igrave;nh c?a kh&aacute;n gi?.</p>\r\n<p>K? l?c gi?i rubik du?i nu?c tru?c d&oacute; thu?c v? Anthony Brooks, v?i th&agrave;nh t&iacute;ch gi?i 5 kh?i rubik trong m?t l?n nh?n th? du?i nu?c t?i bang New Jersey, M?, v&agrave;o nam 2014.</p>\r\n<p>Marchilashvili d&atilde; d&agrave;nh 6 th&aacute;ng luy?n t?p v&agrave; tin tu?ng r?ng k? l?c m?i c?a c?u s? t?n t?i trong th?i gian d&agrave;i.</p>\r\n<p>&ldquo;T&ocirc;i luy?n t?p r?t nhi?u, l&ecirc;n k? ho?ch d? ph&aacute; k? l?c v&agrave; d?m b?o an to&agrave;n cho b?n th&acirc;n, b?i v&igrave; ngay c? m?t sai l?m nh? cung c&oacute; th? g&acirc;y nguy hi?m t?i t&iacute;nh m?ng&rdquo;, Marchilashvili n&oacute;i.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', 2, 7, 0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLUK-9ZhJ88pqqMxoE_1YqXTtVzv4hi9OdHSdY0xBfm4w0lKIb&s', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLUK-9ZhJ88pqqMxoE_1YqXTtVzv4hi9OdHSdY0xBfm4w0lKIb&s', '2020-04-16', 850, 1, 1, NULL, NULL),
(10, '', 'Chú bò may m?n nh?t th? gi?i, to b?ng m?t chi?c xe', '<h2 id=\"article_sapo\" class=\"ctTp tuht_show\">Ch&uacute; b&ograve; cao t?i g?n 2 m&eacute;t, n?ng ngang v?i m?t chi?c xe hoi n&ecirc;n d&oacute;n nh?n k?t c?c may m?n.</h2>\r\n<div class=\"sbNws\">S? ki?n:&nbsp;<a class=\"sbevt clrGr fs12\" title=\"Chuy?n l? Th? gi?i\" href=\"https://www.24h.com.vn/chuyen-la-the-gioi-c159e1080.html\">Chuy?n l? Th? gi?i</a></div>\r\n<div class=\"sbNws\">\r\n<p>Theo Daily Star, ch&uacute; b&ograve; n&agrave;y cao g?n ngang si&ecirc;u sao b&oacute;ng r? Michael Jordan v&agrave; c&oacute; tr?ng lu?ng l?n k? l?c.</p>\r\n<p>V&igrave; k&iacute;ch thu?c d? s? n&ecirc;n ch&uacute; b&ograve; tr?i qua m?i ng&agrave;y th?nh thoi di d?o tr&ecirc;n c&aacute;nh d?ng ? T&acirc;y &Uacute;c m&agrave; kh&ocirc;ng lo d?n chuy?n b? dua v&agrave;o l&ograve; m?.</p>\r\n<p>Ch&uacute; b&ograve; 7 nam tu?i tr&ocirc;ng ho&agrave;n to&agrave;n vu?t tr?i hon h?n c&aacute;c d?ng lo?i kh&aacute;c ? trang tr?i. Ch? trang \r\ntr?i, Geoff Pearson, n&oacute;i ch&iacute;nh v&igrave; k&iacute;ch thu?c to l?n d? thu?ng m&agrave; ch&uacute; b&ograve; n&agrave;y tho&aacute;t c?nh v&agrave;o l&ograve; m?.</p>\r\n<p>L&yacute; do don gi?n l&agrave; v&igrave; kh&ocirc;ng m?t l&ograve; m? d?a phuong n&agrave;o c&oacute; th? x? l&yacute; du?c con b&ograve; to nhu v?y.</p>\r\n<p>Geoff n&oacute;i: &ldquo;N&oacute; qu&aacute; to v&agrave; n?ng. Ch&uacute;ng t&ocirc;i kh&ocirc;ng th? dua n&oacute; qua d&acirc;y chuy?n gi?t m?. v?y n&ecirc;n t?t nh?t l&agrave; d? n&oacute; s?ng vui v? su?t d?i&rdquo;.</p>\r\n<p>Ch? nh&acirc;n n&oacute;i d&atilde; b? ra 225 b?ng Anh d? mua ch&uacute; b&ograve; khi n&oacute; c&ograve;n nh?. &ldquo;Tr?i qua nam th&aacute;ng, ch&uacute; b&ograve; ng&agrave;y c&agrave;ng l?n vu?t tr?i so v?i c&aacute;c d?ng lo?i kh&aacute;c&rdquo;.</p>\r\n<p>Trong khi nh?ng con b&ograve; b&igrave;nh thu?ng n?ng kho?ng 630kg, ch&uacute; b&ograve; cao l?n n&agrave;y n?ng t?i 1,4 t?n, t?c l&agrave; ngang xe hoi. Ch&uacute; b&ograve; cung c&oacute; m&agrave;u tr?ng n?i b?t so v?i nh?ng con b&ograve; kh&aacute;c m&agrave;u n&acirc;u.</p>\r\n<p>D&ugrave; c&oacute; k&iacute;ch thu?c d&aacute;ng k?, nhung ch&uacute; b&ograve; n&agrave;y chua ph?i l&agrave; con b&ograve; l?n nh?t t?ng du?c ghi nh?n. S&aacute;ch K? l?c Guinness ghi nh?n m?t con b&ograve; cao hon 2 m&eacute;t v&agrave; n?ng t?i 2.267kg.</p>\r\n</div>', 4, 4, 0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMm20OFsy9otXDsBIIt6I-fG2VjurrMQmL-cPKr6w6-7Zz8Cga&s', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMm20OFsy9otXDsBIIt6I-fG2VjurrMQmL-cPKr6w6-7Zz8Cga&s', '2020-02-16', 483, 6, 1, '3,5,8', NULL);
INSERT INTO `posts` (`PostID`, `Title`, `Abtract`, `PostContent`, `Author`, `CatID`, `SubCatID`, `HasAvatar`, `BigAvatar`, `PostDate`, `Views`, `Ranks`, `Status`, `TagID`, `Editor`) VALUES
(11, '', 'Can b?nh \"sát th? th?m l?ng\" g?n 30 tri?u ngu?i Vi', '<p><strong>G?n 30 tri?u ngu?i Vi?t b?&nbsp;<a class=\"TextlinkBaiviet\" title=\"gan nhi?m m?\" href=\"https://www.24h.com.vn/gan-nhiem-mo-c62e5209.html\">gan nhi?m m?</a>&nbsp;do d&acirc;u?</strong></p>\r\n<p>Th?ng k&ecirc; c?a B? Y t? t?i H?i th?o Gan m?t to&agrave;n qu?c v?a di?n ra, cho th?y, nu?c ta hi?n c&oacute; 20-30&nbsp; tri?u ngu?i (tuong duong 20-30% d&acirc;n s?) b? gan nhi?m m?.</p>\r\n<p>Th?ng k&ecirc; m?i d&acirc;y c?a B? Y t? d&atilde; khi?n nhi?u ngu?i ph?i gi?t m&igrave;nh: C&oacute; t?i 30-35% s? ca gan nhi?m m? s? ti?n tri?n th&agrave;nh xo gan. Ð?c bi?t, gan nhi?m m? do bia ru?u c&oacute; tr&ecirc;n 50% s? b? xo h&oacute;a, 25% s? ti?n tri?n d?n xo gan v&agrave; 14% s? b? ung thu gan.</p>\r\n<p>Ch&iacute;nh v&igrave; nh?ng l&yacute; do d&oacute; m&agrave; c&aacute;c chuy&ecirc;n gia gan m?t nu?c ta d&atilde; ph&aacute;t di c?nh b&aacute;o,&nbsp;<a class=\"TextlinkBaiviet\" title=\"ngu?i b? gan nhi?m m?\" href=\"https://www.24h.com.vn/gan-nhiem-mo-c62e5209.html\">ngu?i b? gan nhi?m m?</a>&nbsp;d&ugrave; ? giai do?n n&agrave;o cung tuy?t d?i kh&ocirc;ng th? ch? quan m&agrave; ph?i ch&uacute; tr?ng di?u tr?, ngan ch?n bi?n ch?ng s?m. Nu?c ta hi?n c&oacute; 20-30&nbsp; tri?u ngu?i (tuong duong 20-30% d&acirc;n s?) b? gan nhi?m m?.</p>\r\n<p>Ð&aacute;ng ch&uacute; &yacute;, c&oacute; t?i 90% ngu?i nghi?n ru?u b? gan nhi?m m? v&agrave; 10% c&ograve;n l?i l&agrave; do nh?ng v?n d? kh&aacute;c nhu ti?u du?ng tu&yacute;p 2, m? m&aacute;u cao, b&eacute;o ph&igrave;, &iacute;t v?n d?ng, s? d?ng thu?c qu&aacute; li?u ho?c r?i lo?n dinh du?ng&hellip;</p>\r\n<p>Trong d&oacute;, vi?c s? d?ng ru?u bia, ch? d? dinh du?ng, th&oacute;i quen an u?ng &ldquo;nhanh&rdquo; v&agrave; &iacute;t v?n d?ng l&agrave; \r\nnh?ng nguy&ecirc;n nh&acirc;n ph? bi?n trong x&atilde; h?i hi?n d?i, khi?n cho ngay c? ngu?i g?y cung m?c can b?nh n&agrave;y.</p>\r\n<p>Gan nhi?m m? r?t d? t&aacute;i ph&aacute;t v&agrave; du?c g?i l&agrave; k? gi?t ngu?i th?m l?ng b?i kh&ocirc;ng c&oacute; tri?u ch?ng c? th?, d? nh?m l?n v?i c&aacute;c b?nh kh&aacute;c. Hon n?a t&acirc;m l&yacute; ch? quan c?a ngu?i b?nh cho r?ng, b&aacute;c si kh&ocirc;ng k&ecirc; thu?c nghia l&agrave; b?nh nh? v&agrave; chua th?y kh&oacute; ch?u g&igrave; n&ecirc;n kh&ocirc;ng c?n quan t&acirc;m.</p>\r\n<p><strong>Gan nhi?m m? n&ecirc;n ki&ecirc;ng g&igrave; v&agrave; n&ecirc;n an g&igrave;?</strong></p>\r\n<p>Ths.Bs.Tr?n Th? Kh&aacute;nh Tu?ng khuy?n c&aacute;o, khi m?c gan nhi?m m?, tru?c ti&ecirc;n ngu?i b?nh c?n ki?m so&aacute;t c&aacute;c y?u t? \r\nnguy&ecirc;n nh&acirc;n nhu: T? b? ru?u bia (Ð?i v?i nguy&ecirc;n nh&acirc;n do ru?u), di?u tr? d&aacute;i th&aacute;o du?ng, gi?m c&acirc;n, tang cu?ng v?n d?ng v&agrave; duy tr&igrave; m?t ch? d? dinh du?ng h?p l&yacute;&hellip;d?i v?i nguy&ecirc;n nh&acirc;n kh&ocirc;ng do ru?u.</p>      \r\n<p>? g&oacute;c d? d&ocirc;ng y, TS.BS Ph?m Hung C?ng &ndash; Nguy&ecirc;n V? tru?ng V? y du?c h?c c? truy?n B? Y t? khuy?n c&aacute;o nh?ng ngu?i m?c gan nhi?m m? n&ecirc;n n&ecirc;n ki&ecirc;ng m? d?ng v?t, kh&ocirc;ng n&ecirc;n an qu&aacute; nhi?u th?t d?, ki&ecirc;ng gia v? cay n&oacute;ng. Ki&ecirc;ng c&aacute;c d? an cay n&oacute;ng nhu g?ng, t?i, ?t, h? ti&ecirc;u, c&agrave; ph&ecirc;, tr&aacute;nh an nh?ng th?c ph?m gi&agrave;u cholesterol; Tr&aacute;nh n?i t?ng d?ng v?t, l&ograve;ng d? tr?ng... ch?a m?t lu?ng cholesterol cao</p>\r\n<p>Nh?ng tru?ng h?p gan nhi?m m? c&oacute; k&egrave;m vi&ecirc;m gan v?a ho?c n?ng, n&ecirc;n c?n th?n khi an nh?ng lo?i tr&aacute;i c&acirc;y c&oacute; ch?a nhi?u nang lu?ng v&agrave; kh&oacute; ti&ecirc;u nhu s?u ri&ecirc;ng, m&iacute;t&hellip;</p>\r\n<p>M?i ngu?i n&ecirc;n an b? sung rau, c?, qu?: d&acirc;y l&agrave; nh?ng th?c ph?m l&yacute; tu?ng cho ngu?i b?nh gan nhi?m m? v&igrave; c&oacute; t&aacute;c d?ng h? cholesterol trong m&aacute;u v&agrave; t? b&agrave;o gan nhu: N?m huong, l&aacute; sen, rau c?n, d?u n&agrave;nh ch?a phospholipid, n?n ngh? ch?a saponin d?i d&agrave;o gi&uacute;p gi?m gan nhi?m m?,&hellip;..</p>\r\n<p>Nh?ng lo?i rau tuoi nhu c?i xanh, c?i c&uacute;c, rau mu?ng&hellip;ch?a vitamin C, nh?ng lo?i qu? nhu c&agrave; chua, mu?p d?ng, dua gang, dua \r\nchu?t cung gi&agrave;u vitamin v&agrave; kho&aacute;ng ch?t, c&oacute; c&ocirc;ng d?ng g?i nhi?t l&agrave;m m&aacute;t gan, thanh nhi?t.</p>      \r\n<p>Ð?c bi?t, d? h?n ch? s? ph&aacute;t tri?n c?a b?nh, m?i ngu?i n&ecirc;n t? b? ru?u bia, gi?m c&acirc;n v&agrave; t?p th? thao, thay d?i ch? d? \r\nsinh ho?t khoa h?c, l&agrave;nh m?nh&hellip;.</p>', 2, 7, 0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA-NtKqSnozE9Vfe6oHUlTdUPTh41YjtGVIR1_YJXUK5coU9KR&s', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA-NtKqSnozE9Vfe6oHUlTdUPTh41YjtGVIR1_YJXUK5coU9KR&s', '2020-03-15', 100, 11, 2, NULL, NULL),
(12, 'BabyShop Website', 'Mo asdfsdf', '<p>skjjkdskjsd</p>', 6, 5, 0, '', '3f900b08c55f5bc047dd3e21334347c8.png', '2020-08-07', 2, 10, 2, '1,2,3,6', NULL),
(13, 'BAFDqwer', 'w', '<p>wkerwe</p>', 6, 1, 0, '', 'fd2b2007f570bc48d1cccce335627594.png', '2020-08-07', 0, 10, 2, '4,5,6', NULL),
(14, 'GSDGSFG', 'HELLO MOTHER FUCKER', '<p>qewdfwg</p>', 6, 7, 0, '', '2546b946f29b153d277fd3a54a86e5f4.png', '2020-08-10', 0, 10, 2, '7,8,9', NULL),
(15, 'BabyShop Website', '', '<p>gaefg</p>', 6, 1, 0, '', '1597075379961.png.png', '2020-08-10', 0, 10, 2, '1,5,7', NULL),
(16, 'BabyShop Website', '', '<p>dfqw</p>', 6, 1, 0, '', '1597075496346.png.png', '2020-08-10', 0, 10, 2, '2,3,8,9', NULL),
(17, 'asdfqwdgwg', 'awfg', '<p>edwrg</p>', 6, 1, 0, '', '1597075612737.png', '2020-08-10', 0, 10, 2, '2,1,3', NULL),
(18, 'LONG BI', 'asdfwdf', '<p>fqwdf</p>', 6, 1, 0, '', '1597076364801.png', '2020-08-10', 0, 10, 2, NULL, NULL),
(19, 'jahdbfhk', '', '', 6, 1, 0, '', '', '2020-08-10', 0, 10, 2, NULL, NULL),
(20, 'BabyShop Website', 'Mo ta', '<p>wer</p>', 6, 1, 0, '', '1597076739176.png', '2020-08-10', 0, 10, 2, NULL, NULL),
(21, 'Ôn t?p QTCSDL GK', 'Mo ta', '<p>fawdfw</p>', 6, 1, 0, '', '1597076828464.png', '2020-08-10', 0, 10, 2, NULL, NULL),
(22, 'qwer', 'HELLO MOTHER FUCKER', '<p>qwersdg sdg&nbsp;</p>\r\n<p>qwdf</p>', 6, 1, 0, '', '1597076903857.png', '2020-08-10', 0, 10, 2, NULL, NULL),
(23, 'BabyShop Website', 'asdg', '<p>oaoigaoifg</p>', 6, 1, 0, '', '1597148584694.png', '2020-08-11', 0, 10, 2, NULL, NULL),
(24, 'jahdbfhk', 'Mo ta', '<p>kw fgjekf</p>', 6, 1, 0, '', '1597148661639.png', '2020-08-11', 0, 10, 2, NULL, NULL),
(25, 'BabyShop Website', 'HELLO MOTHER FUCKER', '<p>klgalksg</p>', 6, 7, 0, '', '1597148957471.png', '2020-08-11', 0, 10, 2, NULL, NULL),
(26, 'HELLO WORLD', 'Mo ta', '<p>dfqkedgnjwef</p>', 6, 1, 0, '', '1597149220537.png', '2020-08-11', 0, 10, 2, NULL, NULL),
(27, 'BabyShop Website', 'asdg', '<p>ioefnbiwnfg</p>', 6, 4, 0, '', '1597149283118.png', '2020-08-11', 0, 10, 2, NULL, NULL),
(29, 'BabyShop Website', 'asdg', '<p>wdgf</p>', 6, 1, 5, '', '1597151138082.png', '2020-08-11', 0, 10, 2, NULL, NULL),
(30, 'hot new', 'new posst', '<p>this is the new post</p>', 6, 1, 20, '', '1597151407225.png', '2020-08-11', 0, 10, 2, NULL, NULL),
(31, 'hieu th? 2', 'king of rap', '<p><em>adada<strong>d&acirc;dad</strong></em></p>', 3, 1, 2, '', '1597154393335.png', '2020-08-11', 0, 10, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `post_tag`
--

DROP TABLE IF EXISTS `post_tag`;
CREATE TABLE IF NOT EXISTS `post_tag` (
  `PostID` int(11) NOT NULL,
  `TagID` int(11) NOT NULL,
  PRIMARY KEY (`PostID`,`TagID`),
  KEY `fk_tag_post` (`TagID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `post_tag`
--

INSERT INTO `post_tag` (`PostID`, `TagID`) VALUES
(1, 1),
(1, 8),
(1, 10),
(2, 4),
(3, 10),
(4, 1),
(5, 1),
(6, 11),
(7, 11),
(8, 11),
(9, 12),
(10, 12),
(11, 10),
(13, 1),
(13, 3),
(14, 1),
(14, 3),
(16, 8),
(16, 10),
(17, 2),
(17, 4),
(18, 1),
(18, 2),
(18, 4),
(20, 2),
(20, 5),
(21, 2),
(21, 3),
(21, 5),
(23, 9),
(23, 11),
(24, 2),
(24, 4),
(25, 2),
(25, 4),
(26, 4),
(26, 7),
(27, 5),
(29, 9),
(30, 3),
(30, 4),
(31, 3),
(31, 4);

-- --------------------------------------------------------

--
-- Table structure for table `premiumusers`
--

DROP TABLE IF EXISTS `premiumusers`;
CREATE TABLE IF NOT EXISTS `premiumusers` (
  `UserID` int(11) NOT NULL,
  `TimeEnd` datetime NOT NULL,
  PRIMARY KEY (`UserID`,`TimeEnd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `premiumusers`
--

INSERT INTO `premiumusers` (`UserID`, `TimeEnd`) VALUES
(5, '2020-07-31 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `StatusID` int(11) NOT NULL AUTO_INCREMENT,
  `StatusName` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`StatusID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`StatusID`, `StatusName`) VALUES
(1, 'Ðã duy?t'),
(2, 'dang ch? duy?t'),
(3, 'Không du?c duy?t');

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

DROP TABLE IF EXISTS `sub_categories`;
CREATE TABLE IF NOT EXISTS `sub_categories` (
  `SubCatID` int(11) NOT NULL AUTO_INCREMENT,
  `CatID` int(11) NOT NULL,
  `SubCatName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`SubCatID`,`CatID`),
  KEY `fk_subcat_cat` (`CatID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sub_categories`
--

INSERT INTO `sub_categories` (`SubCatID`, `CatID`, `SubCatName`) VALUES
(1, 2, 'Ngo?i H?ng Anh'),
(2, 2, 'Laliga'),
(3, 2, 'Cup C1'),
(4, 2, 'Bóng dá Ý'),
(5, 5, 'Ði?m nóng'),
(6, 5, 'Quân S?'),
(7, 5, 'Th? gi?i d?ng v?t'),
(8, 1, 'Qu?c H?i'),
(9, 1, 'B?u c?'),
(10, 1, 'Th? Tu?ng'),
(11, 3, 's?c kh?e con em'),
(12, 3, 'S?c kh?e gia dình'),
(13, 4, 'Th? tru?ng 24h'),
(14, 4, 'giá c? hàng hóa'),
(15, 4, 'trung tâm mua s?m'),
(16, 6, 'Doanh nhân'),
(17, 6, 'Tài chính'),
(18, 6, 'B?t d?ng s?ng'),
(19, 7, 'B?nh dàn ông'),
(20, 7, 'B?nh ph? n?'),
(21, 7, 'S?c kh?e gioi tính');

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
CREATE TABLE IF NOT EXISTS `tag` (
  `TagID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`TagID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tag`
--

INSERT INTO `tag` (`TagID`, `Name`) VALUES
(1, 'Báo gia dình'),
(2, 'Chính tr? Vi?t nam'),
(3, 'bóng dá th? gi?i'),
(4, 'ronaldo'),
(5, 'd? an dinh du?ng cho bé'),
(6, 'hoai linh'),
(7, 'công d?ng c?a m?t ong'),
(8, 'lu?t hôn nhân'),
(9, 'lu?t lao d?ng'),
(10, 'S?c kh?e'),
(11, 'showbiz'),
(12, 'th? gi?i');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `EmailAdress` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `FullName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `DOB` date NOT NULL,
  `Permission` int(11) NOT NULL,
  `UserName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `HashPassword` varchar(512) COLLATE utf8_unicode_ci NOT NULL,
  `Ranks` int(11) NOT NULL,
  `NickName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Phone` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `Status` int(11) NOT NULL,
  `Avatar` text COLLATE utf8_unicode_ci NOT NULL,
  `otpverify` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  KEY `fk_user_per` (`Permission`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `EmailAdress`, `FullName`, `DOB`, `Permission`, `UserName`, `HashPassword`, `Ranks`, `NickName`, `Phone`, `Status`, `Avatar`, `otpverify`) VALUES
(1, 'baoan123@gmail.com', 'Lâm Nh?t Ty', '2020-06-28', 1, 'lmty', '$2a$08$h36seNYUEWZvbzrU2wrKCeUFtEGG/YVx9PyAWgeHoiXlYXXIbwQnK', 0, '', '123', 0, '', NULL),
(2, 'gialong123@gmail.com', 'ph?m gia long', '2019-06-04', 2, 'Long', '$2a$08$AsxKKhs3uxbj2li2MdKKKeETFVbJN0pSBueyHXaDRMO90lApo1/0S', 0, '', '1234', 0, '', NULL),
(3, 'ttmhieu08@gmail.com', 'hi?u123', '2020-07-28', 3, 'hieu1234', '$2a$10$d3jbwq6ki.8e.ulk3ovipe5/ELkPcZ5ns1PvZYIWnaDc/KK/56JFO', 0, '', '6789', 0, '', '240382'),
(4, 'nam123@gmail.com', 'nam', '2020-01-09', 4, 'nam', '$2a$08$LYRCeyUS9AxF0p.ZGb.Nle38aXKa7Ms4/yg38DgNsSYW8U0dgU.s2', 0, '', '54321', 0, '', NULL),
(5, 'lamnhatty@gmail.com', 'lâm nh?t ty', '2020-04-01', 5, 'lmtyy', '$2a$08$KXW2dH8vb4PP7.Be0Xb.zexSEBC625UWi4V5SoSaQUCvq./UrGHOi', 0, '', '123445', 0, '', NULL),
(6, 'hello@gmail.com', 'Mr Ty', '2020-08-19', 3, '123', '$2a$08$WvcF0EW46OK9Y8pyNoSinOyPY4vBS8jv9u63F4MtO1vF6CmPAFx/u', 0, '', '98239889', 1, '', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `posts`
--
ALTER TABLE `posts` ADD FULLTEXT KEY `Title_2` (`Title`,`Abtract`,`PostContent`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cat_editor`
--
ALTER TABLE `cat_editor`
  ADD CONSTRAINT `fk_categories` FOREIGN KEY (`CatID`) REFERENCES `categories` (`CatID`),
  ADD CONSTRAINT `fk_editor` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `censorship`
--
ALTER TABLE `censorship`
  ADD CONSTRAINT `fk_censor_post` FOREIGN KEY (`PostID`) REFERENCES `posts` (`PostID`),
  ADD CONSTRAINT `fk_censor_status` FOREIGN KEY (`StatusID`) REFERENCES `status` (`StatusID`),
  ADD CONSTRAINT `fk_censor_user` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comment_post` FOREIGN KEY (`PostID`) REFERENCES `posts` (`PostID`),
  ADD CONSTRAINT `fk_comment_user` FOREIGN KEY (`User`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_post_cat` FOREIGN KEY (`CatID`) REFERENCES `categories` (`CatID`),
  ADD CONSTRAINT `fk_post_status` FOREIGN KEY (`Status`) REFERENCES `status` (`StatusID`),
  ADD CONSTRAINT `fk_post_user` FOREIGN KEY (`Author`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `post_tag`
--
ALTER TABLE `post_tag`
  ADD CONSTRAINT `fk_post_tag` FOREIGN KEY (`PostID`) REFERENCES `posts` (`PostID`),
  ADD CONSTRAINT `fk_tag_post` FOREIGN KEY (`TagID`) REFERENCES `tag` (`TagID`);

--
-- Constraints for table `premiumusers`
--
ALTER TABLE `premiumusers`
  ADD CONSTRAINT `fk_pre_user` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD CONSTRAINT `fk_subcat_cat` FOREIGN KEY (`CatID`) REFERENCES `categories` (`CatID`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_user_per` FOREIGN KEY (`Permission`) REFERENCES `permission` (`PerID`);
COMMIT;
