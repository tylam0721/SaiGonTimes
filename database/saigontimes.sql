-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 18, 2020 at 04:13 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `saigontimes`
--
CREATE DATABASE saigontime;
USE saigontime;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `CatID` int(11) NOT NULL,
  `CatName` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cat_editor`
--

CREATE TABLE `cat_editor` (
  `UserID` int(11) NOT NULL,
  `CatID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `censorship`
--

CREATE TABLE `censorship` (
  `PostID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Reason` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `User` int(11) NOT NULL,
  `PostID` int(11) NOT NULL,
  `CommentContent` text COLLATE utf8_unicode_ci NOT NULL,
  `CommentDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `PerID` int(11) NOT NULL,
  `PermissionName` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `PostID` int(11) NOT NULL,
  `Abtract` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `PostContent` text COLLATE utf8_unicode_ci NOT NULL,
  `Author` int(11) NOT NULL,
  `HasAvatar` text COLLATE utf8_unicode_ci NOT NULL,
  `BigAvatar` text COLLATE utf8_unicode_ci NOT NULL,
  `PostDate` date NOT NULL,
  `Views` int(11) NOT NULL,
  `Ranks` int(11) NOT NULL,
  `Status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_categories`
--

CREATE TABLE `post_categories` (
  `PostID` int(11) NOT NULL,
  `CatID` int(11) NOT NULL,
  `SubCatID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_tag`
--

CREATE TABLE `post_tag` (
  `PostID` int(11) NOT NULL,
  `TagID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `premiumusers`
--

CREATE TABLE `premiumusers` (
  `UserID` int(11) NOT NULL,
  `TimeEnd` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `StatusID` int(11) NOT NULL,
  `StatusName` varchar(30) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_categories`
--

CREATE TABLE `sub_categories` (
  `SubCatID` int(11) NOT NULL,
  `CatID` int(11) NOT NULL,
  `SubCatName` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE `tag` (
  `TagID` int(11) NOT NULL,
  `Name` varchar(30) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
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
  `Avatar` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`CatID`);

--
-- Indexes for table `cat_editor`
--
ALTER TABLE `cat_editor`
  ADD PRIMARY KEY (`UserID`,`CatID`),
  ADD KEY `fk_categories` (`CatID`);

--
-- Indexes for table `censorship`
--
ALTER TABLE `censorship`
  ADD PRIMARY KEY (`PostID`,`UserID`,`StatusID`,`Date`),
  ADD KEY `fk_censor_user` (`UserID`),
  ADD KEY `fk_censor_status` (`StatusID`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`User`,`PostID`,`CommentDate`),
  ADD KEY `fk_comment_post` (`PostID`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`PerID`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`PostID`),
  ADD KEY `fk_post_user` (`Author`),
  ADD KEY `fk_post_status` (`Status`);

--
-- Indexes for table `post_categories`
--
ALTER TABLE `post_categories`
  ADD PRIMARY KEY (`PostID`,`CatID`),
  ADD KEY `fk_cat_post` (`CatID`),
  ADD KEY `fk_subCat` (`SubCatID`);

--
-- Indexes for table `post_tag`
--
ALTER TABLE `post_tag`
  ADD PRIMARY KEY (`PostID`,`TagID`),
  ADD KEY `fk_tag_post` (`TagID`);

--
-- Indexes for table `premiumusers`
--
ALTER TABLE `premiumusers`
  ADD PRIMARY KEY (`UserID`,`TimeEnd`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`StatusID`);

--
-- Indexes for table `sub_categories`
--
ALTER TABLE `sub_categories`
  ADD PRIMARY KEY (`SubCatID`,`CatID`),
  ADD KEY `fk_subcat_cat` (`CatID`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`TagID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD KEY `fk_user_per` (`Permission`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `CatID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
  MODIFY `PerID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `PostID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `StatusID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tag`
--
ALTER TABLE `tag`
  MODIFY `TagID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `fk_post_status` FOREIGN KEY (`Status`) REFERENCES `status` (`StatusID`),
  ADD CONSTRAINT `fk_post_user` FOREIGN KEY (`Author`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `post_categories`
--
ALTER TABLE `post_categories`
  ADD CONSTRAINT `fk_cat_post` FOREIGN KEY (`CatID`) REFERENCES `categories` (`CatID`),
  ADD CONSTRAINT `fk_post_cat` FOREIGN KEY (`PostID`) REFERENCES `posts` (`PostID`),
  ADD CONSTRAINT `fk_subCat` FOREIGN KEY (`SubCatID`) REFERENCES `sub_categories` (`SubCatID`);

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


BEGIN;
-- insert categories
INSERT INTO `categories`(`CatID`, `CatName`) VALUES (Null,'Chính trị');
INSERT INTO `categories`(`CatID`, `CatName`) VALUES (Null,'Bóng đá');
INSERT INTO `categories`(`CatID`, `CatName`) VALUES (Null,'Gia Đình');
INSERT INTO `categories`(`CatID`, `CatName`) VALUES (Null,'Xã Hội');
INSERT INTO `categories`(`CatID`, `CatName`) VALUES (Null,'Thế giới');
INSERT INTO `categories`(`CatID`, `CatName`) VALUES (Null,'Kinh doanh');
INSERT INTO `categories`(`CatID`, `CatName`) VALUES (Null,'Sức Khỏe');

-- insert sub_categories
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('1','2','Ngoại Hạng Anh');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('2','2','Laliga');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('3','2','Cup C1');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('4','2','Bóng đá Ý');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('5','5','Điểm nóng');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('6','5','Quân Sự');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('7','5','Thế giới động vật');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('8','1','Quốc Hội');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('9','1','Bầu cử');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('10','1','Thủ Tướng');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('11','3','sức khỏe con em');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('12','3','Sức khỏe gia đình');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('13','4','Thị trường 24h');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('14','4','giá cả hàng hóa');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('15','4','trung tâm mua sắm');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('16','6','Doanh nhân');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('17','6','Tài chính');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('18','6','Bất động sảng');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('19','7','Bệnh đàn ông');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('20','7','Bệnh phụ nữ');
INSERT INTO `sub_categories`(`SubCatID`, `CatID`, `SubCatName`) VALUES ('21','7','Sức khỏe giơi tính');




-- insert permission
INSERT INTO `permission`(`PerID`, `PermissionName`) VALUES ('1','Quản trị viên');
INSERT INTO `permission`(`PerID`, `PermissionName`) VALUES ('2','Độc giả');
INSERT INTO `permission`(`PerID`, `PermissionName`) VALUES ('3','Biên tập viên');
INSERT INTO `permission`(`PerID`, `PermissionName`) VALUES ('4','Phóng viên');
INSERT INTO `permission`(`PerID`, `PermissionName`) VALUES ('5','Độc giả vãng lai');



-- insert users
INSERT INTO `users`(`UserID`, `EmailAdress`, `FullName`, `DOB`, `Permission`, `UserName`, `HashPassword`, `Ranks`, `NickName`, `Phone`, `Status`) 
VALUES ('1','baoan123@gmail.com','Lâm Nhật Ty','1999-2-1','1','lamnhatty','123','1','ty','012346789','1');

INSERT INTO `users`(`UserID`, `EmailAdress`, `FullName`, `DOB`, `Permission`, `UserName`, `HashPassword`, `Ranks`, `NickName`, `Phone`, `Status`) 
VALUES ('2','baoan123@gmail.com','Trần Bảo Ân','1999-3-1','2','tranbaoan','123','2','an','0123467895','1');

INSERT INTO `users`(`UserID`, `EmailAdress`, `FullName`, `DOB`, `Permission`, `UserName`, `HashPassword`, `Ranks`, `NickName`, `Phone`, `Status`) 
VALUES ('3','gialong123@gmail.com','Phạm Gia Long','1999-4-1','3','phamgialong','123','3','long','0123467894','1');

INSERT INTO `users`(`UserID`, `EmailAdress`, `FullName`, `DOB`, `Permission`, `UserName`, `HashPassword`, `Ranks`, `NickName`, `Phone`, `Status`) 
VALUES ('4','hieu123@gmail.com','Nguyễn Minh Hiếu','1999-5-1','4','nguyenminhhieu','123','4','hieu','0123467899','1');

INSERT INTO `users`(`UserID`, `EmailAdress`, `FullName`, `DOB`, `Permission`, `UserName`, `HashPassword`, `Ranks`, `NickName`, `Phone`, `Status`) 
VALUES ('5','nam123@gmail.com','Trần Đình Nam','1999-6-1','5','trandinhnam','123','5','nam','0123467892','1');


-- insert status
INSERT INTO `status`(`StatusID`, `StatusName`) VALUES ('1','Đã duyệt');
INSERT INTO `status`(`StatusID`, `StatusName`) VALUES ('2','đang chờ duyệt');
INSERT INTO `status`(`StatusID`, `StatusName`) VALUES ('3','Không được duyệt');


-- insert cat_editor
INSERT INTO `cat_editor`(`UserID`, `CatID`) VALUES ('1','1');
INSERT INTO `cat_editor`(`UserID`, `CatID`) VALUES ('1','2');
INSERT INTO `cat_editor`(`UserID`, `CatID`) VALUES ('1','3');
INSERT INTO `cat_editor`(`UserID`, `CatID`) VALUES ('1','4');


-- insert posts
INSERT INTO `posts`(`PostID`, `Abtract`, `PostContent`, `Author`, `HasAvatar`, `BigAvatar`, `PostDate`, `Views`, `Ranks`, `Status`) VALUES ('1','Lơ là chủ quan có thể khiến bạn “mất mạng như chơi” vì căn bệnh quen thuộc trong mùa mưa này','<div class="updTm updTmD mrT5">Thứ Năm, ng&agrave;y 18/06/2020 17:58 PM (GMT+7)</div>
<div class="bmTpSeoBlk bmTpSeoBlkD clF">
<div class="icoSocial icoSocialx txtRt flRt"><a class="icoSocialCm" title="Chia sẻ tr&ecirc;n Fanpage" href="http://www.facebook.com/fan24h" target="_blank" rel="noopener">&nbsp;</a></div>
<div class="clF">&nbsp;</div>
</div>
<h2 id="article_sapo" class="ctTp tuht_show">M&ugrave;a mưa đến cũng l&agrave; m&ugrave;a m&agrave; căn bệnh sốt xuất huyết lại bắt đầu xuất hiện 
v&agrave; g&acirc;y th&agrave;nh dịch. Căn bệnh n&agrave;y tuy kh&ocirc;ng mới nhưng c&oacute; thể g&acirc;y n&ecirc;n những hậu quả nghi&ecirc;m 
trọng nếu bạn chủ quan v&agrave; kh&ocirc;ng ph&ograve;ng ngừa. Việt Nam l&agrave; một trong những quốc gia c&oacute; tỉ lệ nhiễm sốt xuất huyết cao nhất thế giới. Vậy căn bệnh n&agrave;y l&agrave; g&igrave;, n&oacute; nguy hiểm như thế n&agrave;o? Bạn h&atilde;y t&igrave;m hiểu th&ocirc;ng 
qua b&agrave;i viết dưới đ&acirc;y nh&eacute;.</h2>
<p><strong>Bệnh sốt xuất huyết l&agrave; g&igrave;?</strong></p>
<p><a href="https://youmed.vn/tin-tuc/sot-xuat-huyet/" target="_blank" rel="nofollow noopener">Sốt xuất huyết</a>&nbsp;hay c&ograve;n gọi l&agrave; sốt xuất huyết Dengue l&agrave; một bệnh truyền nhiễm do virus Dengue g&acirc;y ra. Bệnh kh&ocirc;ng l&acirc;y trực tiếp từ người sang người nhưng được truyền sang người qua muỗi đốt. Muỗi vằn Aedes l&agrave; t&aacute;c nh&acirc;n truyền bệnh. Muỗi sẽ h&uacute;t m&aacute;u người mắc bệnh hoặc người đ&atilde; nhiễm phải virus nhưng kh&ocirc;ng c&oacute; triệu chứng rồi truyền n&oacute; cho người khỏe mạnh. Ăn uống, d&ugrave;ng chung 
đồ với người bệnh kh&ocirc;ng l&agrave;m l&acirc;y nhiễm sốt xuất huyết.</p>
<p>Virus Dengue c&oacute; 4 tu&yacute;p g&acirc;y bệnh được k&yacute; hiệu l&agrave; D1, D2, D3, D4. Cả 4 tu&yacute;p n&agrave;y đều gặp ở Việt Nam v&agrave; c&oacute; thể lu&acirc;n phi&ecirc;n g&acirc;y dịch. Do miễn dịch được tạo th&agrave;nh sau khi mắc bệnh chỉ đặc hiệu với từng tu&yacute;p virus n&ecirc;n người ta c&oacute; thể mắc sốt xuất huyết đến 4 lần trong đời, tuy nhi&ecirc;n rất hiếm khi mắc phải bệnh đến lần thứ 4.</p> 
','2','<img class="news-image initial loading" src="https://cdn.24h.com.vn/upload/2-2020/images/2020-06-18/Lo-la-chu-quan-co-the-khien-ban-mat-mang-nhu-choi-vi-can-benh-quen-thuoc-trong-mua-mua-nay-suc-khoe--1--1592467407-343-width660height413.jpg" alt="Lơ l&agrave; chủ quan c&oacute; thể khiến bạn &ldquo;mất mạng như chơi&rdquo; v&igrave; căn bệnh quen thuộc trong m&ugrave;a mưa n&agrave;y - 1" data-was-processed="true" />',
'<img class="news-image initial loading" src="https://cdn.24h.com.vn/upload/2-2020/images/2020-06-18/Lo-la-chu-quan-co-the-khien-ban-mat-mang-nhu-choi-vi-can-benh-quen-thuoc-trong-mua-mua-nay-suc-khoe--1--1592467407-343-width660height413.jpg" alt="Lơ l&agrave; chủ quan c&oacute; thể khiến bạn &ldquo;mất mạng như chơi&rdquo; v&igrave; căn bệnh quen thuộc trong m&ugrave;a mưa n&agrave;y - 1" data-was-processed="true" />','2020-06-18','250','10','1');


INSERT INTO `posts`(`PostID`, `Abtract`, `PostContent`, `Author`, `PostDate`, `Views`, `Ranks`, `Status`) VALUES ('2','"Đệ ruột" Ronaldo tính rời Juventus, "dọn nhà" đến MU xây mộng Euro 2021','<p>&nbsp;</p>
<p><strong>Tottenham tho&aacute;t "nạn" nhờ Covid-19</strong></p>
<p>Trước khi giải Ngoại hạng Anh phải ho&atilde;n lại v&igrave; dịch bệnh, Tottenham đang rơi tự do với chuỗi phong độ tương đối ngh&egrave;o n&agrave;n. Đo&agrave;n qu&acirc;n của Jose Mourinho đối mặt với lịch thi đấu d&agrave;y đặc v&agrave; c&oacute; phần nặng nề. Họ bị loại khỏi Champions League ở v&ograve;ng knock-out. Sau đ&oacute; l&agrave; bộ mặt thảm hại tại&nbsp;<a class="TextlinkBaiviet" title="Premier League" href="https://www.24h.com.vn/premier-league-2018-2019-c48e2367.html">Premier League</a>&nbsp;khi tụt xuống tận vị tr&iacute; thứ 8.</p>
<p><strong>Đối đầu kh&ocirc;ng khoan nhượng</strong></p>
<p>Lợi thế s&acirc;n nh&agrave; sẽ thuộc về Tottenham, nhưng cơ hội chen ch&acirc;n v&agrave;o nh&oacute;m dự&nbsp;<a href="https://www.24h.com.vn/cup-c1-champions-league-c153.html">UEFA Champions League</a>&nbsp;lại đang rộng mở d&agrave;nh cho MU. Bởi vậy, đ&acirc;y hứa hẹn sẽ l&agrave; một cuộc đối đầu kh&ocirc;ng khoan nhượng, trong lần t&aacute;i ngộ đội b&oacute;ng cũ của "Người đặc biệt" Jose Mourinho.</p>
<p><strong>Phả hơi n&oacute;ng v&agrave;o g&aacute;y Chelsea</strong></p>
<p>Ở ph&iacute;a b&ecirc;n kia chiến tuyến, MU cũng bước v&agrave;o trận đại chiến n&agrave;y bằng quyết t&acirc;m cao nhất. "Quỷ Đỏ" đang xếp thứ 5 với 3 điểm &iacute;t hơn&nbsp;<a class="TextlinkBaiviet" title="Chelsea" href="https://www.24h.com.vn/chelsea-c48e1505.html">Chelsea</a>, đội b&oacute;ng đứng thứ 4 l&uacute;c n&agrave;y. Một&nbsp;chiến thắng ở&nbsp;trận đấu sớm v&ograve;ng 30 c&oacute; thể gi&uacute;p họ tạo ra &aacute;p lực lớn l&ecirc;n "The Blues", đội b&oacute;ng&nbsp;sẽ phải l&agrave;m kh&aacute;ch trước Aston Villa v&agrave;o ng&agrave;y Chủ Nhật.</p>       
<table width="500" cellspacing="0" cellpadding="3" align="center">
<tbody>
<tr>
<td valign="top">
<p><strong>Th&ocirc;ng tin đội h&igrave;nh</strong></p>
<p>Tottenham: Dele Alli treo gi&ograve;. Tanganga, Parrott chấn thương. Lo Celso, Son bỏ ngỏ khả năng ra s&acirc;n.</p>
<p>MU: Phil Jones bị đau nhẹ, bỏ ngỏ khả năng ra s&acirc;n.</p>
<p><strong>Th&agrave;nh t&iacute;ch đối đầu</strong></p>
<p>Tottenham thắng 2, thua 3 trong 5 cuộc đối đầu gần nhất với MU tại Ngoại hạng Anh.</p>
</td>
</tr>
</tbody>
</table>
<h2 id="article_sapo" class="ctTp tuht_show">Federico Bernardeschi l&agrave; một trong những ng&ocirc;i sao kh&ocirc;ng được đ&aacute;nh gi&aacute; đ&uacute;ng khả năng ở Juventus, giữa những si&ecirc;u sao tầm cỡ thế giới của đội chủ s&acirc;n Turin. V&igrave; thế, tuyển thủ Italia đang t&iacute;nh đến Anh lập nghiệp.</h2>
<p><strong>Phương &aacute;n dự ph&ograve;ng của MU</strong></p>
<p>Kh&ocirc;ng c&ograve;n nghi ngờ g&igrave; nữa, Jadon Sancho l&agrave; mục ti&ecirc;u quan trọng của&nbsp;<a class="TextlinkBaiviet" title="MU" 
href="https://www.24h.com.vn/manchester-united-c48e1521.html">MU</a>&nbsp;trong phi&ecirc;n chợ h&egrave; 2020 n&agrave;y. Chỉ c&oacute; điều, khả năng hiện thực h&oacute;a tham vọng&nbsp;của "Quỷ đỏ" c&ograve;n bỏ ngỏ, khi m&agrave; Sancho l&agrave; c&aacute;i t&ecirc;n "hot" c&ograve;n t&agrave;i ch&iacute;nh MU lại kh&ocirc;ng thực sự đảm bảo.</p>
<p>Hậu đại dịch Covid-19, gi&aacute; của Sancho kh&ocirc;ng hề giảm. Theo dự đo&aacute;n của c&acirc;y viết thể thao kỳ cự Martin Samuel tr&ecirc;n Daily Mail, để c&oacute; sự phục vụ của Jadon Sancho, MU phải chi số tiền kh&ocirc;ng dưới 100 triệu bảng.</p>
<p>Đ&acirc;y l&agrave; r&agrave;o cản kh&ocirc;ng dễ vượt qua n&ecirc;n đội chủ s&acirc;n&nbsp;<a class="TextlinkBaiviet" title="Old Trafford" href="https://www.24h.com.vn/manchester-united-c48e1521.html">Old Trafford</a>&nbsp;buộc phải l&ecirc;n c&aacute;c phương &aacute;n dự ph&ograve;ng. 
Vẫn theo nguồn tin n&agrave;y, Ph&oacute; chủ tịch Ed Woodward cũng như bộ phận chuyển nhượng MU đang nhắm đến Federico Bernardeschi l&agrave;m phương &aacute;n B nếu thất bại ở thương vụ Sancho.</p>
<p>Trong l&uacute;c đ&oacute;, tờ Tutto Sport b&aacute;o tin vui cho đội b&oacute;ng nước Anh, khi m&agrave; ch&iacute;nh Juventus cũng sẵn s&agrarizio Sarri.</p>
<div id="ADS_159_15s" class="txtCent">
<div id="ADS_159_15stxtBnrHor"></div>
<div class="banner_inread">&nbsp;</div>
<span id="ADS_159_15s_0" class="m_banner_show"></span></div>
<p>Ở Serie A m&ugrave;a n&agrave;y, Bernardeschi mới c&oacute; 18 lần ra s&acirc;n, trong đ&oacute; c&oacute; 9 lần v&agrave;o s&acirc;n từ băng ghế dự bị. Vậy n&ecirc;n, Juventus hứa hẹn sẽ chấp thuận để Bernardeschi ra đi nếu nhận được đề nghị khoảng 30 triệu bảng - con số chỉ chưa đến 1/3 khoản tiền m&agrave; MU c&oacute; thể phải chi ra để c&oacute; Sancho.</p>
<p>Bernardeschi được Juventus chi&ecirc;u mộ từ Fiorentina hồi m&ugrave;a h&egrave; năm 2017 với mức gi&aacute; 40 triệu euro (tương đương 35,6 triệu bảng). Từ ng&agrave;y tới Turin, tiền vệ 26 tuổi n&agrave;y chưa thể hiện được nhiều như k&igrave; vọng. Dưới thời HLV Sarri, Bernardeschi ng&agrave;y c&agrave;ng c&oacute; &iacute;t cơ hội ra s&acirc;n. Anh vẫn c&ograve;n hợp đồng 2 năm với "B&agrave; đầm gi&agrave;" th&agrave;nh Turin.</p>
<p><strong>Tham vọng lớn trong chuyến x&ecirc; dịch</strong></p>
<p>Bản th&acirc;n Federico Bernardeschi cũng hiểu rằng, thời gian của anh tại s&acirc;n Allianz đang kh&eacute;p lại. HLV tiền nhiệm Max Alleri ưu ti&ecirc;n sử dụng Bernardeschi l&agrave;m vệ tinh hỗ trợ si&ecirc;u sao Ronaldo, thậm ch&iacute; sẵn s&agrave;ng gạt Dybala l&ecirc;n ghế dự bị.</p>
<p><br /><br /></p>
<h2 id="article_sapo" class="ctTp tuht_show">Federico Bernardeschi l&agrave; một trong những ng&ocirc;i sao kh&ocirc;ng được đ&aacute;nh gi&aacute; đ&uacute;ng khả năng ở Juventus, giữa những si&ecirc;u sao tầm cỡ thế giới của đội chủ s&acirc;n Turin. V&igrave; thế, tuyển thủ Italia đang t&iacute;nh đến Anh lập nghiệp.</h2>
<p><strong>Phương &aacute;n dự ph&ograve;ng của MU</strong></p>
<p>Kh&ocirc;ng c&ograve;n nghi ngờ g&igrave; nữa, Jadon Sancho l&agrave; mục ti&ecirc;u quan trọng của&nbsp;<a class="TextlinkBaiviet" title="MU" 
href="https://www.24h.com.vn/manchester-united-c48e1521.html">MU</a>&nbsp;trong phi&ecirc;n chợ h&egrave; 2020 n&agrave;y. Chỉ c&oacute; điều, khả năng hiện thực h&oacute;a tham vọng&nbsp;của "Quỷ đỏ" c&ograve;n bỏ ngỏ, khi m&agrave; Sancho l&agrave; c&aacute;i t&ecirc;n "hot" c&ograve;n t&agrave;i ch&iacute;nh MU lại kh&ocirc;ng thực sự đảm bảo.</p>
<p>Hậu đại dịch Covid-19, gi&aacute; của Sancho kh&ocirc;ng hề giảm. Theo dự đo&aacute;n của c&acirc;y viết thể thao kỳ cự Martin Samuel tr&ecirc;n Daily Mail, để c&oacute; sự phục vụ của Jadon Sancho, MU phải chi số tiền kh&ocirc;ng dưới 100 triệu bảng.</p>
<p>Đ&acirc;y l&agrave; r&agrave;o cản kh&ocirc;ng dễ vượt qua n&ecirc;n đội chủ s&acirc;n&nbsp;<a class="TextlinkBaiviet" title="Old Trafford" href="https://www.24h.com.vn/manchester-united-c48e1521.html">Old Trafford</a>&nbsp;buộc phải l&ecirc;n c&aacute;c phương &aacute;n dự ph&ograve;ng. 
Vẫn theo nguồn tin n&agrave;y, Ph&oacute; chủ tịch Ed Woodward cũng như bộ phận chuyển nhượng MU đang nhắm đến Federico Bernardeschi l&agrave;m phương &aacute;n B nếu thất bại ở thương vụ Sancho.</p>
<p>Trong l&uacute;c đ&oacute;, tờ Tutto Sport b&aacute;o tin vui cho đội b&oacute;ng nước Anh, khi m&agrave; ch&iacute;nh Juventus cũng sẵn s&agrave;ng để Bernardeschi ra đi trong m&ugrave;a h&egrave; 2020. Theo đ&oacute;, tiền vệ n&agrave;y kh&ocirc;ng nằm trong kế hoạch sử dụng của HLV Maurizio Sarri.</p>
<div id="ADS_159_15s" class="txtCent">
<div id="ADS_159_15stxtBnrHor"></div>
<div class="banner_inread">&nbsp;</div>
<span id="ADS_159_15s_0" class="m_banner_show"></span></div>
<p>Ở Serie A m&ugrave;a n&agrave;y, Bernardeschi mới c&oacute; 18 lần ra s&acirc;n, trong đ&oacute; c&oacute; 9 lần v&agrave;o s&acirc;n từ băng ghế dự bị. Vậy n&ecirc;n, Juventus hứa hẹn sẽ chấp thuận để Bernardeschi ra đi nếu nhận được đề nghị khoảng 30 triệu bảng - con số chỉ chưa đến 1/3 khoản tiền m&agrave; MU c&oacute; thể phải chi ra để c&oacute; Sancho.</p>
<p>Bernardeschi được Juventus chi&ecirc;u mộ từ Fiorentina hồi m&ugrave;a h&egrave; năm 2017 với mức gi&aacute; 40 triệu euro (tương đương 35,6 triệu bảng). Từ ng&agrave;y tới Turin, tiền vệ 26 tuổi n&agrave;y chưa thể hiện được nhiều như k&igrave; vọng. Dưới thời HLV Sarri, Bernardeschi ng&agrave;y c&agrave;ng c&oacute; &iacute;t cơ hội ra s&acirc;n. Anh vẫn c&ograve;n hợp đồng 2 năm với "B&agrave; đầm gi&agrave;" th&agrave;nh Turin.</p>
<p><strong>Tham vọng lớn trong chuyến x&ecirc; dịch</strong></p>
<p>Bản th&acirc;n Federico Bernardeschi cũng hiểu rằng, thời gian của anh tại s&acirc;n Allianz đang kh&eacute;p lại. HLV tiền nhiệm Max Alleri ưu ti&ecirc;n sử dụng Bernardeschi l&agrave;m vệ tinh hỗ trợ si&ecirc;u sao Ronaldo, thậm ch&iacute; sẵn s&agrave;ng gạt Dybala l&ecirc;n ghế dự bị.</p>','2','2020-06-17','300','9','1');




INSERT INTO `posts`(`PostID`, `Abtract`, `PostContent`, `Author`, `PostDate`, `Views`, `Ranks`, `Status`) VALUES ('3','Bộ Y tế công bố thêm 7 ca nhiễm COVID-19','<h2 id="article_sapo" class="ctTp tuht_show">Chiều 19/6, Bộ Y tế cho biết, Việt Nam vừa ghi nhận th&ecirc;m 7 ca nhiễm COVID-19, n&acirc;ng tổng số ca l&ecirc;n 349.</h2>
<p><strong>C&aacute;c bệnh nh&acirc;n bao gồm:</strong></p>
<p>BN343: bệnh nhân nữ, 27 tuổi, có địa chỉ tại Cẩm Thủy, Cẩm Phả, Quảng Ninh.</p>
<p>BN344: bệnh nhân nam, 52 tuổi, có địa chỉ tại Nghi Thủy, Cửa Lò, Nghệ An.</p>
<p>BN345: bệnh nhân nữ, 39 tuổi, có địa chỉ tại Cổ Nhuế 1, Bắc Từ Liêm, Hà Nội. BN346: bệnh nhân nam, 6 tuổi, có địa
 chỉ tại Cổ Nhuế 1, Bắc Từ Liêm, Hà Nội.</p>
<p>BN347: bệnh nhân nam, 6 tuổi, có địa chỉ tại Cổ Nhuế 1, Bắc Từ Liêm, Hà Nội.</p>
<p>BN348: bệnh nhân nam, 39 tuổi, có địa chỉ tại Cổ Nhuế 1, Bắc Từ Liêm, Hà Nội.</p>
<p>BN349: bệnh nhân nam, 12 tuổi, có địa chỉ tại Cổ Nhuế 1, Bắc Từ Liêm, Hà Nội.</p>
<p>Ngày 06/6 các bệnh nhân này từ châu Âu (Thụy Điển, Phần Lan) về Sân bay Quốc tế Nội Bài (Hà Nội) trên chuyến bay
 VN2, sau khi nhập cảnh được cách ly ngay tại Trường Cao đẳng nghề Công nghệ cao, Tây Mỗ, Nam Từ Liêm, Hà Nội.</p>     
<p>Ngày 07/6 được lấy mẫu xét nghiệm lần 1, kết quả đều âm tính. Ngày 18/6 được lấy mẫu xét nghiệm lần 2, kết q
uả 7 mẫu dương tính với&nbsp;<a class="TextlinkBaiviet" title="SARS-CoV-2" href="https://www.24h.com.vn/dich-covid-19-c62e6058.html">SARS-
CoV-2</a>. Hiện 7 bệnh nhân được cách ly, điều trị tại Bệnh viện Bệnh Nhiệt đới Trung ương cơ sở 2.</p>
<p>Bộ Y tế cho biết, cả 7 ca nhiễm COVID-19 được c&ocirc;ng bố chiều 19/6 đều kh&ocirc;ng c&oacute; nguy cơ l&acirc;y ra cộng đồng.</p>
<p>Như vậy, tính đến 18h ngày 19/6, Việt Nam có tổng cộng 209 ca nhiễm nhập cảnh được cách ly ngay, đã có 64 ngày liên 
tiếp không có ca nhiễm trong cộng đồng.</p>','3','2020-1-15','300','8','1');



INSERT INTO `posts`(`PostID`, `Abtract`, `PostContent`, `Author`, `PostDate`, `Views`, `Ranks`, `Status`) VALUES ('4','Ai ngờ trứng chim cút có tới 15 tác dụng chữa bệnh thần kỳ như thế này','<h1 id="article_title" class="clrTit bld tuht_show"><strong>1. Giảm nguy cơ mắc bệnh nan y</strong></h1>
<p>Lượng kali thấp trong cơ thể c&oacute; thể khiến bạn dễ mắc c&aacute;c bệnh nan y như bệnh tim, huyết &aacute;p cao, vi&ecirc;m khớp, đột quỵ, 
ung thư v&agrave; rối loạn ti&ecirc;u h&oacute;a. Trứng c&uacute;t bổ sung lượng kali cần thiết cho cơ thể, gi&uacute;p bạn khỏe mạnh.</p>        
<p><strong>2. Ngăn ngừa c&aacute;c bệnh m&atilde;n t&iacute;nh</strong></p>
<p>Trứng chim c&uacute;t chứa nhiều vitamin A v&agrave; vitamin C c&oacute; thể ngăn chặn sự khởi ph&aacute;t của nhiều bệnh m&atilde;n t&iacute;nh v&agrave; tăng cường sức khỏe tổng thể</p>
<p><strong>3. Điều trị dị ứng v&agrave; vi&ecirc;m</strong></p>
<p>Ovomucoid c&oacute; trong những quả trứng c&uacute;t nhỏ nhắn n&agrave;y hoạt động như một th&agrave;nh phần chống dị ứng tự nhi&ecirc;n. Vi&ecirc;m, xung huyết hoặc c&aacute;c triệu chứng kh&aacute;c của phản ứng dị ứng c&oacute; thể được giảm bớt với sự trợ gi&uacute;p của trứng c&uacute;t nếu bạn ti&ecirc;u thụ n&oacute;.</p>
<p><strong>4. Tăng cường trao đổi chất</strong></p>
<p>Vitamin B c&oacute; trong những quả trứng n&agrave;y c&oacute; thể tăng cường hoạt động trao đổi chất tr&ecirc;n to&agrave;n cơ thể bằng c&aacute;ch cải thiện chức năng của hormone v&agrave; enzyme</p>
<p><strong>5. Tăng cường khả năng miễn dịch</strong></p>
<p>Trứng chim c&uacute;t cải thiện hệ thống miễn dịch của bạn. Ch&uacute;ng l&agrave;m sạch m&aacute;u khỏi độc tố v&agrave; kim loại nặng, tăng cường độ tinh khiết của m&aacute;u, tăng cường tr&iacute; nhớ v&agrave; tăng hoạt động của n&atilde;o.</p>
<div id="ADS_159_15s" class="txtCent">
<div id="ADS_159_15stxtBnrHor"></div>
</div>
<p><strong>6. Tăng nồng độ huyết sắc tố trong m&aacute;u</strong></p>
<p>H&agrave;m lượng sắt cao trong trứng c&uacute;t c&oacute; thể gi&uacute;p người thiếu m&aacute;u ở mức độ lớn. Ăn trứng c&uacute;t thường xuy&ecirc;n cải thiện nồng độ hemoglobin.</p>
<p><strong>7. Cải thiện thị lực</strong></p>
<p>Vitamin A c&oacute; trong trứng chim c&uacute;t bảo vệ thị lực, gi&uacute;p giảm tho&aacute;i h&oacute;a điểm v&agrave;ng v&agrave; ngăn ngừa sự ph&aacute;t triển của đục thủy tinh thể.</p>
<p><strong>8. Kiểm so&aacute;t huyết &aacute;p</strong></p>
<p>Trứng chim c&uacute;t c&oacute; nhiều kali. Kho&aacute;ng chất n&agrave;y gi&uacute;p giảm căng thẳng cho c&aacute;c động mạch v&agrave; mạch m&aacute;u, do đ&oacute; giữ cho huyết &aacute;p trong tầm kiểm so&aacute;t</p>','2','2020-06-10','500','7','1');




INSERT INTO `posts`(`PostID`, `Abtract`, `PostContent`, `Author`, `PostDate`, `Views`, `Ranks`, `Status`) VALUES ('5','Ăn kiểu này vừa hại sức khỏe, vừa mất ngủ triền miên','<h2 id="article_sapo" class="ctTp tuht_show">Nếu bị mất ngủ nhưng chưa t&igrave;m được nguy&ecirc;n nh&acirc;n th&igrave; n&ecirc;n xem lại những 
th&oacute;i quen ăn uống, sinh hoạt v&agrave; đ&ocirc;i khi chỉ cần thay đổi th&oacute;i quen &ldquo;xấu&rdquo; n&agrave;y bạn c&oacute; thể khắc 
phục được.</h2>
<p><strong>D&ugrave;ng bữa tối qu&aacute; sớm hoặc qu&aacute; muộn</strong></p>
<p>Ăn qu&aacute; sớm hay qu&aacute; muộn c&oacute; thể ảnh hưởng đến&nbsp;giấc ngủ. Trong trường hợp đầu ti&ecirc;n bạn c&oacute; thể đ&oacute;i bụng khi đi ngủ, c&ograve;n trường hợp sau th&igrave; việc ti&ecirc;u h&oacute;a đ&atilde; ảnh hưởng đến giấc ngủ. Nếu bạn ăn qu&aacute; sớm n&ecirc;n bổ sung th&ecirc;m b&aacute;t bột ngũ cốc với sữa v&agrave; cơ thể cần &iacute;t nhất 2 giờ để ti&ecirc;u h&oacute;a hết thức ăn.</p>
<p><strong>Uống nhiều thức uống c&oacute; cồn hay c&agrave; ph&ecirc;</strong></p>
<p>Thức uống c&oacute; cồn gi&uacute;p bạn ch&igrave;m v&agrave;o giấc ngủ rất nhanh nhưng đ&ocirc;i khi g&acirc;y mất nước v&agrave; c&oacute; thể g&acirc;y rối loạn v&agrave;i giai đoạn của giấc ngủ khiến bạn lại tỉnh giấc.</p>
<p>Lưu &yacute; kh&ocirc;ng n&ecirc;n uống c&agrave; ph&ecirc; v&agrave;o buổi tối. Theo trang web Reader&rsquo;s Digest-Mỹ. th&igrave; uống cốc c&agrave; ph&ecirc; v&agrave;o buổi chiều gi&uacute;p tập trung tư tưởng l&agrave;m việc nhưng đ&ocirc;i khi l&agrave;m bạn tỉnh t&aacute;o v&agrave;o ban đ&ecirc;m, kh&ocirc;ng n&ecirc;n uống qu&aacute; 3-4 cốc c&agrave; ph&ecirc; mỗi ng&agrave;y.</p>
<p><strong>Lượng thức ăn qu&aacute; nhiều</strong></p>
<p>V&agrave;o buổi tối ăn qu&aacute; nhiều sẽ kh&ocirc;ng tốt cho cơ thể v&igrave; hệ ti&ecirc;u h&oacute;a phải l&agrave;m việc nhiều hơn so với 
khi ch&uacute;ng ta đứng hay ngồi. Tuy vậy nếu ăn qu&aacute; &iacute;t cũng kh&ocirc;ng n&ecirc;n v&igrave; khi đi ngủ với cảm gi&aacute;c đ&oacute;i khiến bạn lo &acirc;u v&agrave; đau dạ d&agrave;y... N&ecirc;n c&oacute; chế độ ăn uống hợp l&yacute; để c&oacute; thể ch&igrave;m v&agrave;o 
giấc ngủ ngon.</p>
<div id="ADS_159_15s" class="txtCent">
<div id="ADS_159_15stxtBnrHor"></div>
<div class="banner_inread">&nbsp;</div>
<span id="ADS_159_15s_0" class="m_banner_show"></span></div>
<p><strong>D&ugrave;ng nhiều chất b&eacute;o, đường&hellip;</strong></p>
<p>Nếu bạn th&iacute;ch ăn cay th&igrave; n&ecirc;n d&agrave;nh cho buổi ăn trưa. Ti&ecirc;u h&oacute;a c&aacute;c chất n&agrave;y g&acirc;y cảm gi&aacute;c n&oacute;ng r&aacute;t dạ d&agrave;y hay tr&agrave;o ngược v&agrave; g&acirc;y cảm gi&aacute;c kh&oacute; chịu về đ&ecirc;m. Những thực phẩm nhiều chất đường, b&eacute;o cũng ảnh hưởng đến giấc ngủ.&nbsp;</p>
<p><strong>Những thực phẩm kh&ocirc;ng n&ecirc;n v&agrave;o buổi tối</strong></p>
<p><strong>Thực phẩm cay</strong></p>
<p>Thực phẩm cay thường được khuyến kh&iacute;ch trong thực đơn giảm c&acirc;n nhưng n&oacute; cũng c&oacute; thể khiến bạn kh&oacute; ngủ v&igrave; g&acirc;y ra chứng ợ n&oacute;ng. Thức ăn cay cũng l&agrave;m tăng nhiệt độ cơ thể, khiến bạn kh&oacute; đi v&agrave;o giấc ngủ.</p>
<p><strong>Thực phẩm chế biến sẵn</strong></p>
<p><strong>Thịt x&ocirc;ng kh&oacute;i, x&uacute;c x&iacute;ch hay c&aacute;c sản phẩm chế biến sẵn thường chứa h&agrave;m lượng lớn tyramine, một axit amin gi&uacute;p sản sinh ra chất k&iacute;ch th&iacute;ch n&atilde;o norepinephrine c&ugrave;ng h&agrave;m lượng cao chất b&eacute;o v&agrave; protein ti&ecirc;u h&oacute;a rất chậm. V&igrave; vậy, nếu bạn ăn thịt x&ocirc;ng kh&oacute;i ngay trước khi đi ngủ, bạn sẽ cảm thấy kh&ocirc;ng thoải m&aacute;i v&agrave; sẽ kh&ocirc;ng thể ngủ được v&igrave; n&atilde;o v&agrave; dạ d&agrave;y của bạn vẫn sẽ hoạt động.</strong></p>     
<p><strong>H&agrave;nh t&acirc;y</strong></p>
<p>H&agrave;nh t&acirc;y c&oacute; thể g&acirc;y đầy hơi v&igrave; ch&uacute;ng chứa chất xơ h&ograve;a tan gọi l&agrave; fructans. Điều n&agrave;y sẽ ảnh hưởng &iacute;t nhiều tới giấc ngủ. V&igrave; vậy, nếu bạn muốn ngủ ngon, h&atilde;y đảm bảo rằng bữa tối kh&ocirc;ng chứa nhiều h&agrave;nh t&acirc;y.</p>','4','2020-5-16','500','3','1');



INSERT INTO `posts`(`PostID`, `Abtract`, `PostContent`, `Author`, `PostDate`, `Views`, `Ranks`, `Status`) VALUES ('6','Những hình ảnh một thời của cặp đôi Vân Sơn - Bảo Liêm','<h2 id="article_sapo" class="ctTp tuht_show">Mới đ&acirc;y, danh h&agrave;i V&acirc;n Sơn chia sẻ loạt ảnh c&ugrave;ng Bảo Li&ecirc;m thuở đầu mưu sinh ở Mỹ, th&agrave;nh lập nh&oacute;m h&agrave;i v&agrave; th&agrave;nh c&ocirc;ng vang dội.</h2>
<div class="sbNws">Sự kiện:&nbsp;<a class="sbevt clrGr fs12" title="H&agrave;i V&Acirc;N SƠN BẢO LI&Ecirc;M" href="https://www.24h.com.vn/hai-van-son-bao-liem-c746e2562.html">H&agrave;i V&Acirc;N SƠN BẢO LI&Ecirc;M</a></div>
<p>V&agrave;o những năm 90, tr&ecirc;n c&aacute;c s&acirc;n khấu hải ngoại, V&acirc;n Sơn &ndash; Bảo Li&ecirc;m c&ugrave;ng MC Việt Thảo từng l&agrave; cặp diễn vi&ecirc;n h&agrave;i được y&ecirc;u th&iacute;ch nhất nh&igrave;, kh&ocirc;ng k&eacute;m cạnh Ho&agrave;i Linh &ndash; Ch&iacute; T&agrave;i. Thế nhưng sau đ&oacute; kh&ocirc;ng l&acirc;u, danh h&agrave;i Bảo Li&ecirc;m đ&atilde; bất ngờ t&aacute;ch nh&oacute;m.</p>
<p>Thời điểm n&agrave;y, nghệ sĩ h&agrave;i Bảo Chung sang Mỹ định cư n&ecirc;n anh v&agrave; V&acirc;n Sơn kết hợp với nhau, cặp đ&ocirc;i diễn vi&ecirc;n h&agrave;i được kh&aacute;n giả y&ecirc;u th&iacute;ch kh&ocirc;ng k&eacute;m. Mặc d&ugrave; vậy, mỗi khi nhắc đến hai c&aacute;i t&ecirc;n V&acirc;n Sơn - Bảo Li&ecirc;m, nhiều người h&acirc;m mộ vẫn nhớ tới những tiểu phẩm h&agrave;i duy&ecirc;n d&aacute;ng của hai danh h&agrave;i n&agrave;y.</p>
<p>Bảo Li&ecirc;m (tr&aacute;i) v&agrave; V&acirc;n Sơn khi mới đến Mỹ v&agrave;o đầu thập ni&ecirc;n 1990. V&acirc;n Sơn kể, cả hai gặp lại nhau 
nơi xứ người như một định mệnh. Sau một lần diễn tại hội chợ Tết cho người Việt ở California, V&acirc;n Sơn nhận được cuộc gọi từ một số lạ.</p>  
<p>"H&oacute;a ra đ&oacute; l&agrave; Bảo Li&ecirc;m - thằng bạn nối khố của t&ocirc;i thuở c&ograve;n ở Việt Nam. Li&ecirc;m thấy h&igrave;nh t&ocirc;i tr&ecirc;n poster ở hội chợ n&ecirc;n t&igrave;m c&aacute;ch li&ecirc;n lạc ban tổ chức để xin số của t&ocirc;i", anh kể.</p>
<p>Gặp lại Bảo Li&ecirc;m, V&acirc;n Sơn quyết t&acirc;m lập nh&oacute;m h&agrave;i, d&ugrave; trước đ&oacute; anh đ&atilde; diễn chung Quang Minh, Charlie Nguyễn (em họ)... L&uacute;c ấy, Bảo Li&ecirc;m ở bang Arizona, vợ đang mang bầu, cuộc sống dần ổn định. V&acirc;n Sơn rủ anh chuyển sang California hoạt động v&igrave; nơi đ&acirc;y đ&ocirc;ng kh&aacute;n giả Việt. Hai cặp vợ chồng V&acirc;n Sơn v&agrave; Bảo Li&ecirc;m thu&ecirc; một căn hộ hai ph&ograve;ng ngủ chung sống.</p>
<p>Thời gian đầu, họ diễn ở một số đ&aacute;m cưới, vũ trường... với thể loại h&agrave;i song tấu (stand-up comedy). Đ&ocirc;i nghệ sĩ lọt v&agrave;o mắt xanh một &ocirc;ng "bầu" v&agrave; được mời quay video. Sau v&agrave;i số đầu ph&aacute;t h&agrave;nh, họ nổi tiếng trong cộng đồng người 
Việt to&agrave;n nước Mỹ.</p>
<p>Những tiểu phẩm được y&ecirc;u th&iacute;ch của họ l&agrave; "Lấy chồng xứ lạ", "Oan gia đối mặt", "C&ocirc; Tấm ng&agrave;y nay"... Đ&ocirc;i 
nghệ sĩ được mời lưu diễn tại c&aacute;c bang ở Mỹ lẫn khắp thế giới. V&acirc;n Sơn kể: "Lần đầu, t&ocirc;i cảm nhận được sự  (đi&ecirc;n cuồng) của kh&aacute;n giả. Họ h&acirc;m mộ ch&uacute;ng t&ocirc;i như những ng&ocirc;i sao nhạc rock"</p>
<p>Bước ngoặt đến với V&acirc;n Sơn - Bảo Li&ecirc;m khi tự ph&aacute;t h&agrave;nh video h&agrave;i ri&ecirc;ng, b&aacute;n được hơn 20.000 băng 
với số đầu ti&ecirc;n, đạt doanh thu hơn 100.000 USD. Họ c&ograve;n kết hợp với nhiều nghệ sĩ như Quang Minh (h&agrave;ng tr&ecirc;n), Hồng Đ&agrave;o, Bảo Chung, L&ecirc; Huỳnh...</p>
<p>Sau v&agrave;i năm hợp t&aacute;c, V&acirc;n Sơn - Bảo Li&ecirc;m t&aacute;ch ri&ecirc;ng. V&acirc;n Sơn kết hợp Ho&agrave;i Linh v&agrave; đạt được th&agrave;nh c&ocirc;ng tương tự.</p>','3','2020-04-15','500','4','1');



INSERT INTO `posts`(`PostID`, `Abtract`, `PostContent`, `Author`, `PostDate`, `Views`, `Ranks`, `Status`) VALUES ('7','Cuộc hôn nhân 20 năm của nghệ sĩ hài Tấn Bo và người vợ tài năng kín tiếng','<h2 id="article_sapo" class="ctTp tuht_show">Lần hiếm hoi c&ugrave;ng b&agrave; x&atilde; l&ecirc;n s&oacute;ng truyền h&igrave;nh, vợ chồng em trai danh h&agrave;i Tấn Beo trải l&ograve;ng về cuộc sống hiện tại.</h2>
<div class="sbNws">Sự kiện:&nbsp;<a class="sbevt clrGr fs12" title="Chuyện của sao" href="https://www.24h.com.vn/chuyen-cua-sao-c102e1244.html">Chuyện của sao</a>,&nbsp;<a class="sbevt clrGr" title="Hậu trường những ng&ocirc;i sao" href="https://www.24h.com.vn/hau-truong-nhung-ngoi-sao-c74e1231.html">Hậu trường những ng&ocirc;i sao</a></div>
<p>Với những kh&aacute;n giả y&ecirc;u th&iacute;ch h&agrave;i kịch miền Nam, hai c&aacute;i t&ecirc;n kh&ocirc;ng thể kh&ocirc;ng nhắc đến l&agrave; một "cặp b&agrave;i tr&ugrave;ng" tr&ecirc;n s&acirc;n khấu ch&iacute;nh l&agrave; anh em Tấn Beo - Tấn Bo. Hiện tại, tuy cả hai đ&atilde; kh&ocirc;ng c&ograve;n diễn chung, mỗi người cũng c&oacute; hướng l&agrave;m nghệ thuật ri&ecirc;ng nhưng cuộc sống của hai nghệ sĩ vẫn rất được kh&aacute;n giả quan t&acirc;m. L&agrave; kh&aacute;ch mời của chương tr&igrave;nh "Giải m&atilde; tri kỷ" tuần n&agrave;y, nghệ sĩ h&agrave;i Tấn Bo 
đ&atilde; c&ugrave;ng b&agrave; x&atilde; tiết lộ nhiều điều sau 20 năm kết h&ocirc;n.&nbsp;</p>
<p>Rất &iacute;t khi nhắc đến b&agrave; x&atilde;, tuy nhi&ecirc;n với bạn b&egrave; hay những kh&aacute;n giả đ&atilde; quan t&acirc;m đến chặng 
đường l&agrave;m nghề của Tấn Bo từ l&acirc;u đều biết đến danh t&iacute;nh người phụ nữ đứng sau anh. Vợ Tấn Bo g&acirc;y ch&uacute; &yacute; với khả năng s&aacute;ng t&aacute;c, &iacute;t người biết rằng c&aacute;i t&ecirc;n&nbsp;nhạc sĩ Xu&acirc;n Nhi ch&iacute;nh l&agrave; vợ Tấn Bo. Nữ 
nhạc sĩ đ&atilde; g&acirc;y dấu ấn với h&agrave;ng loạt ca kh&uacute;c được kh&aacute;n giả 8X, 9X y&ecirc;u th&iacute;ch như: "T&igrave;nh y&ecirc;u v&agrave; giọt nước mắt", "Kẻ đa t&igrave;nh", "Một lời cho mai sau", "Y&ecirc;u trong lầm lỡ"... Kh&ocirc;ng chỉ c&oacute; khả năng s&aacute;ng t&aacute;c, nhạc sĩ Xu&acirc;n Nhi c&ograve;n mong muốn trở th&agrave;nh ca sĩ, h&aacute;t c&aacute;c ca kh&uacute;c của m&igrave;nh. Tuy nhi&ecirc;n khi mới 18 tuổi, c&ocirc; đ&atilde; chọn kết h&ocirc;n, chăm lo cho gia đ&igrave;nh v&agrave; g&aacute;c lại niềm đam&nbsp;m&ecirc; với &acirc;m nhạc.&nbsp;</p>
<p>Bắt đầu viết nhạc từ năm 16 tuổi, nữ nhạc sĩ tiết lộ bản th&acirc;n rất may mắn khi c&aacute;c ca kh&uacute;c của m&igrave;nh được nhiều ca sĩ 
chọn để thể hiện. Thậm ch&iacute;, thời điểm c&ocirc; c&ograve;n chưa vững về nhạc l&iacute; đ&atilde; c&oacute; thể b&aacute;n được nhạc: "Khi anh Vĩnh Thuy&ecirc;n l&agrave; quản l&yacute; của chị Uy&ecirc;n Trang gọi cho t&ocirc;i, hỏi t&ocirc;i&nbsp;c&oacute; b&agrave;i n&agrave;o kh&ocirc;ng th&igrave; t&ocirc;i&nbsp;đưa cho anh 3 b&agrave;i. Được chọn 1 b&agrave;i với t&ocirc;i&nbsp;cũng vui rồi nhưng anh ấy&nbsp;gọi lại bảo t&ocirc;i&nbsp;ra k&yacute; hợp đồng 3 b&agrave;i lu&ocirc;n, l&uacute;c đ&oacute;&nbsp;th&igrave; thực sự t&ocirc;i&nbsp;rất vui", Xu&acirc;n Nhi nhớ lại thời điểm được ca sĩ Uy&ecirc;n Trang li&ecirc;n hệ mua b&agrave;i h&aacute;t.&nbsp;</p>
<p>Từng c&oacute; sự nghiệp "s&aacute;ng" từ khi mới bắt đầu, nhưng Xu&acirc;n Nhi vẫn chọn cuộc sống gia đ&igrave;nh sau khi kết h&ocirc;n. Nh&igrave;n lại chặng đường 20 năm với Tấn Bo c&ugrave;ng 4 người con, nữ nhạc sĩ vẫn hạnh ph&uacute;c như thuở ban đầu. Chia sẻ về l&iacute; do kh&ocirc;ng tham gia "Giải m&atilde; tri kỷ" với Tấn Beo m&agrave; lại cho vợ xuất hiện tr&ecirc;n s&oacute;ng truyền h&igrave;nh, nghệ sĩ Tấn Bo cũng vui vẻ tiết lộ: "Bản th&acirc;n t&ocirc;i&nbsp;sống kh&eacute;p k&iacute;n, ẩn dật v&igrave; c&oacute; những nỗi niềm ri&ecirc;ng tư n&ecirc;n kh&ocirc;ng th&iacute;ch n&oacute;i nhiều về bản th&acirc;n m&igrave;nh. Đ&aacute;ng lẽ t&ocirc;i&nbsp;xuất hiện với anh Beo th&igrave; kh&aacute;n giả sẽ biết nhiều nhưng sau một hồi suy nghĩ th&igrave; t&ocirc;i&nbsp;muốn xuất hiện c&ugrave;ng b&agrave; x&atilde; để mọi người được biết về người phụ nữ b&ecirc;n cạnh t&ocirc;i".</p>
<p>Về phần Tấn Bo, c&oacute; hậu phương vững chắc l&agrave; b&agrave; x&atilde; t&agrave;i giỏi v&agrave; c&aacute;c con ngoan ngo&atilde;n, anh vẫn chăm chỉ đi diễn để chăm lo cho gia đ&igrave;nh. Hiện tại khi t&igrave;nh h&igrave;nh s&acirc;n khấu đang đi xuống, lớp nghệ sĩ trẻ ng&agrave;y một đa năng nhưng Tấn Bo cũng kh&ocirc;ng lo lắng về t&ecirc;n tuổi của m&igrave;nh sẽ bị đ&agrave;n em thay thế. "T&ocirc;i&nbsp;kh&ocirc;ng sợ 
t&ecirc;n tuổi bị mai một v&agrave; cho tới thời điểm b&acirc;y giờ, t&ocirc;i&nbsp;đ&atilde; m&atilde;n nguyện với vị tr&iacute; của m&igrave;nh. T&ocirc;i&nbsp;c&agrave;ng tự h&agrave;o hơn v&igrave; c&oacute; những lớp đ&agrave;n em t&agrave;i năng kế tiếp m&igrave;nh. Kh&aacute;n giả c&oacute; thể kh&ocirc;ng thấy t&ocirc;i&nbsp;thường xuy&ecirc;n nhưng nhắc tới t&ecirc;n Tấn Bo người ta c&ograve;n nhớ l&agrave; được rồi", nam danh h&agrave;i chia sẻ.&nbsp;</p>
<h2 id="article_sapo" class="ctTp tuht_show">Lần hiếm hoi c&ugrave;ng b&agrave; x&atilde; l&ecirc;n s&oacute;ng truyền h&igrave;nh, vợ chồng em trai danh h&agrave;i Tấn Beo trải l&ograve;ng về cuộc sống hiện tại.</h2>
<div class="sbNws">Sự kiện:&nbsp;<a class="sbevt clrGr fs12" title="Chuyện của sao" href="https://www.24h.com.vn/chuyen-cua-sao-c102e1244.html">Chuyện của sao</a>,&nbsp;<a class="sbevt clrGr" title="Hậu trường những ng&ocirc;i sao" href="https://www.24h.com.vn/hau-truong-nhung-ngoi-sao-c74e1231.html">Hậu trường những ng&ocirc;i sao</a></div>
<p>Với những kh&aacute;n giả y&ecirc;u th&iacute;ch h&agrave;i kịch miền Nam, hai c&aacute;i t&ecirc;n kh&ocirc;ng thể kh&ocirc;ng nhắc đến l&agrave; một "cặp b&agrave;i tr&ugrave;ng" tr&ecirc;n s&acirc;n khấu ch&iacute;nh l&agrave; anh em Tấn Beo - Tấn Bo. Hiện tại, tuy cả hai đ&atilde; kh&ocirc;ng c&ograve;n diễn chung, mỗi người cũng c&oacute; hướng l&agrave;m nghệ thuật ri&ecirc;ng nhưng cuộc sống của hai nghệ sĩ vẫn rất được kh&aacute;n giả quan t&acirc;m. L&agrave; kh&aacute;ch mời của chương tr&igrave;nh "Giải m&atilde; tri kỷ" tuần n&agrave;y, nghệ sĩ h&agrave;i Tấn Bo 
đ&atilde; c&ugrave;ng b&agrave; x&atilde; tiết lộ nhiều điều sau 20 năm kết h&ocirc;n.&nbsp;</p>
<p>Rất &iacute;t khi nhắc đến b&agrave; x&atilde;, tuy nhi&ecirc;n với bạn b&egrave; hay những kh&aacute;n giả đ&atilde; quan t&acirc;m đến chặng 
đường l&agrave;m nghề của Tấn Bo từ l&acirc;u đều biết đến danh t&iacute;nh người phụ nữ đứng sau anh. Vợ Tấn Bo g&acirc;y ch&uacute; &yacute; với khả năng s&aacute;ng t&aacute;c, &iacute;t người biết rằng c&aacute;i t&ecirc;n&nbsp;nhạc sĩ Xu&acirc;n Nhi ch&iacute;nh l&agrave; vợ Tấn Bo. Nữ 
nhạc sĩ đ&atilde; g&acirc;y dấu ấn với h&agrave;ng loạt ca kh&uacute;c được kh&aacute;n giả 8X, 9X y&ecirc;u th&iacute;ch như: "T&igrave;nh y&ecirc;u v&agrave; giọt nước mắt", "Kẻ đa t&igrave;nh", "Một lời cho mai sau", "Y&ecirc;u trong lầm lỡ"... Kh&ocirc;ng chỉ c&oacute; khả năng s&aacute;ng t&aacute;c, nhạc sĩ Xu&acirc;n Nhi c&ograve;n mong muốn trở th&agrave;nh ca sĩ, h&aacute;t c&aacute;c ca kh&uacute;c của m&igrave;nh. Tuy nhi&ecirc;n khi mới 18 tuổi, c&ocirc; đ&atilde; chọn kết h&ocirc;n, chăm lo cho gia đ&igrave;nh v&agrave; g&aacute;c lại niềm đam&nbsp;m&ecirc; với &acirc;m nhạc.&nbsp;</p>
<p>Bắt đầu viết nhạc từ năm 16 tuổi, nữ nhạc sĩ tiết lộ bản th&acirc;n rất may mắn khi c&aacute;c ca kh&uacute;c của m&igrave;nh được nhiều ca sĩ 
chọn để thể hiện. Thậm ch&iacute;, thời điểm c&ocirc; c&ograve;n chưa vững về nhạc l&iacute; đ&atilde; c&oacute; thể b&aacute;n được nhạc: "Khi anh Vĩnh Thuy&ecirc;n l&agrave; quản l&yacute; của chị Uy&ecirc;n Trang gọi cho t&ocirc;i, hỏi t&ocirc;i&nbsp;c&oacute; b&agrave;i n&agrave;o kh&ocirc;ng th&igrave; t&ocirc;i&nbsp;đưa cho anh 3 b&agrave;i. Được chọn 1 b&agrave;i với t&ocirc;i&nbsp;cũng vui rồi nhưng anh ấy&nbsp;gọi lại bảo t&ocirc;i&nbsp;ra k&yacute; hợp đồng 3 b&agrave;i lu&ocirc;n, l&uacute;c đ&oacute;&nbsp;th&igrave; thực sự t&ocirc;i&nbsp;rất vui", Xu&acirc;n Nhi nhớ lại thời điểm được ca sĩ Uy&ecirc;n Trang li&ecirc;n hệ mua b&agrave;i h&aacute;t.&nbsp;</p>
<p>Từng c&oacute; sự nghiệp "s&aacute;ng" từ khi mới bắt đầu, nhưng Xu&acirc;n Nhi vẫn chọn cuộc sống gia đ&igrave;nh sau khi kết h&ocirc;n. Nh&igrave;n lại chặng đường 20 năm với Tấn Bo c&ugrave;ng 4 người con, nữ nhạc sĩ vẫn hạnh ph&uacute;c như thuở ban đầu. Chia sẻ về l&iacute; do kh&ocirc;ng tham gia "Giải m&atilde; tri kỷ" với Tấn Beo m&agrave; lại cho vợ xuất hiện tr&ecirc;n s&oacute;ng truyền h&igrave;nh, nghệ sĩ Tấn Bo cũng vui vẻ tiết lộ: "Bản th&acirc;n t&ocirc;i&nbsp;sống kh&eacute;p k&iacute;n, ẩn dật v&igrave; c&oacute; những nỗi niềm ri&ecirc;ng tư n&ecirc;n kh&ocirc;ng th&iacute;ch n&oacute;i nhiều về bản th&acirc;n m&igrave;nh. Đ&aacute;ng lẽ t&ocirc;i&nbsp;xuất hiện với anh Beo th&igrave; kh&aacute;n giả sẽ biết nhiều nhưng sau một hồi suy nghĩ th&igrave; t&ocirc;i&nbsp;muốn xuất hiện c&ugrave;ng b&agrave; x&atilde; để mọi người được biết về người phụ nữ b&ecirc;n cạnh t&ocirc;i".</p>
<p>Về phần Tấn Bo, c&oacute; hậu phương vững chắc l&agrave; b&agrave; x&atilde; t&agrave;i giỏi v&agrave; c&aacute;c con ngoan ngo&atilde;n, anh vẫn chăm chỉ đi diễn để chăm lo cho gia đ&igrave;nh. Hiện tại khi t&igrave;nh h&igrave;nh s&acirc;n khấu đang đi xuống, lớp nghệ sĩ trẻ ng&agrave;y một đa năng nhưng Tấn Bo cũng kh&ocirc;ng lo lắng về t&ecirc;n tuổi của m&igrave;nh sẽ bị đ&agrave;n em thay thế. "T&ocirc;i&nbsp;kh&ocirc;ng sợ 
t&ecirc;n tuổi bị mai một v&agrave; cho tới thời điểm b&acirc;y giờ, t&ocirc;i&nbsp;đ&atilde; m&atilde;n nguyện với vị tr&iacute; của m&igrave;nh. T&ocirc;i&nbsp;c&agrave;ng tự h&agrave;o hơn v&igrave; c&oacute; những lớp đ&agrave;n em t&agrave;i năng kế tiếp m&igrave;nh. Kh&aacute;n giả c&oacute; thể kh&ocirc;ng thấy t&ocirc;i&nbsp;thường xuy&ecirc;n nhưng nhắc tới t&ecirc;n Tấn Bo người ta c&ograve;n nhớ l&agrave; được rồi", nam danh h&agrave;i chia sẻ.&nbsp;</p>
<p>Sau tất cả những biến cố trong qu&aacute; khứ v&agrave; những kh&oacute; khăn trong cuộc sống, điều quan trọng nhất ở vợ chồng Tấn Bo đ&oacute; l&agrave; vẫn g&igrave;n giữ được gia đ&igrave;nh trọn vẹn cho c&aacute;c con. Cuối chương tr&igrave;nh, nhạc sĩ Xu&acirc;n Nhi đ&atilde; x&uacute;c động gửi lời đến chồng: "Cảm ơn anh đ&atilde; chung sống c&ugrave;ng em 20 năm, cho em m&oacute;n qu&agrave; l&agrave; 4 thi&ecirc;n thần nhỏ. Đ&ocirc;i l&uacute;c em cộc cằn, n&oacute;ng t&iacute;nh khiến anh buồn l&ograve;ng. Anh ăn chay trường em cũng biết nhưng em chưa nấu cho anh được bữa ăn ngon n&ecirc;n em sẽ cố gắng". Đ&aacute;p lại vợ, Tấn Bo cũng n&oacute;i lời cảm ơn v&igrave; suốt qu&atilde;ng thời gian qua, c&ugrave;ng với đ&oacute; l&agrave; sự hy sinh từ b&agrave; x&atilde; khi kh&ocirc;ng sợ nguy hiểm, sinh cho anh đến 4 người con.</p>','2','2020-5-06','750','2','1');




INSERT INTO `posts`(`PostID`, `Abtract`, `PostContent`, `Author`, `PostDate`, `Views`, `Ranks`, `Status`) VALUES ('8','Nam MC gặp rắc rối vì quá giống Tuấn “khỉ” bắn 5 người chết đang bị truy nã','<h2 id="article_sapo" class="ctTp tuht_show">&ldquo;Qu&aacute; nhiều người kết bạn, thời điểm nhạy cảm qu&aacute;&rdquo;, MC Đ&igrave;nh Hiếu chia sẻ.</h2>
<div class="sbNws">Sự kiện:&nbsp;<a class="sbevt clrGr fs12" title="Chuyện của sao" href="https://www.24h.com.vn/chuyen-cua-sao-c102e1244.html">Chuyện của sao</a></div>
<p><em>&ldquo;Đ&ocirc;i khi người giống người cũng khổ. Trong khi Tuấn &ldquo;khỉ&rdquo; chưa bị bắt, th&igrave; diễn vi&ecirc;n Đ&igrave;nh Hiếu 
đừng n&ecirc;n ra đường hoặc đi về hướng Củ Chi, T&acirc;y Ninh, chứ kh&ocirc;ng dễ g&acirc;y hiểu lầm th&igrave; khổ nha&rdquo;,</em>&nbsp;l&agrave; b&agrave;i biết được nhiều diễn đ&agrave;n lan tỏa rộng r&atilde;i. K&egrave;m theo đ&oacute; l&agrave; h&igrave;nh ảnh so s&aacute;nh giữa MC, diễn vi&ecirc;n Đ&igrave;nh Hiếu với Tuấn &ldquo;khỉ&rdquo; &ndash; đối tượng đang bị c&ocirc;ng an truy n&atilde; sau khi bắn 5 người chết ở Củ Chi, TP.HCM. Theo nhiều d&acirc;n mạng, diện mạo cả hai c&oacute; nhiều n&eacute;t tương đồng, nếu nh&igrave;n tho&aacute;ng qua th&igrave; rất dễ nhầm lẫn.<em>&nbsp;&ldquo;T&ocirc;i thấy Đ&igrave;nh Hiếu giống Tuấn &ldquo;khỉ&rdquo; 99%&rdquo;,</em>&nbsp;một t&agrave;i khoản để lại lời b&igrave;nh.</p>
<p>Trao đổi với ph&oacute;ng vi&ecirc;n, MC, diễn vi&ecirc;n Đ&igrave;nh Hiếu cho biết, những ng&agrave;y qua anh nhận được rất nhiều lời mời kết 
bạn, cũng như thấy nhiều h&igrave;nh ảnh của bản th&acirc;n bị so s&aacute;nh với s&aacute;t thủ nguy hiểm.&nbsp;<em>&ldquo;T&ocirc;i kh&ocirc;ng 
biết ai gh&eacute;p ảnh v&agrave; mục đ&iacute;ch của họ l&agrave; g&igrave;. T&ocirc;i kh&ocirc;ng quan t&acirc;m lắm. T&ocirc;i thấy m&igrave;nh chả giống Tuấn &ldquo;khỉ&rdquo; ch&uacute;t n&agrave;o. T&ocirc;i đẹp trai hơn hắn nhiều. T&ocirc;i biết c&oacute; người giống hắn hơn. Bạn b&egrave; mang t&ocirc;i ra tr&ecirc;u rồi cũng xong&rdquo;,&nbsp;</em>Đ&igrave;nh Hiếu b&agrave;y tỏ.</p>
<div id="ADS_159_15s" class="txtCent">
<div id="ADS_159_15stxtBnrHor"></div>
<div class="banner_inread">&nbsp;</div>
<span id="ADS_159_15s_0" class="m_banner_show"></span></div>
<p>Bất ngờ nhận được nhiều sự quan t&acirc;m từ c&ocirc;ng ch&uacute;ng, Đ&igrave;nh Hiếu thừa nhận bản th&acirc;n c&oacute; gặp ch&uacute;t phiền to&aacute;i v&agrave; rắc rối, song anh kh&ocirc;ng l&agrave;m vấn đề th&ecirc;m nghi&ecirc;m trọng.&nbsp;<em>&ldquo;T&ocirc;i sống lạc quan lắm. T&ocirc;i vẫn ra đường đi l&agrave;m, vui chơi, hoạt động thể thao b&igrave;nh thường&rdquo;</em>, anh n&oacute;i.</p>
<p>Đ&igrave;nh Hiếu sinh năm 1980, l&agrave; diễn vi&ecirc;n điện ảnh, truyền h&igrave;nh nổi tiếng. Anh được biết đến sau c&aacute;c bộ phim như&nbsp;<em>Hương ph&ugrave; sa, Nghề b&aacute;o, Gọi giấc mơ về, S&oacute;ng gi&oacute; cuộc đời, Cổng mặt trời, &Ocirc;ng tr&ugrave;m,..</em></p>  
<p>Đ&igrave;nh Hiếu chơi thể thao&nbsp;rất kh&aacute;, đặc biệt l&agrave; b&oacute;ng đ&aacute;&nbsp;với vai tr&ograve; tiền đạo. Với m&ocirc;n b&oacute;ng chuyền, anh đảm nhận&nbsp;vị tr&iacute; chủ c&ocirc;ng v&agrave; từng đoạt nhiều huy chương V&agrave;ng khi c&ograve;n l&agrave; học sinh.</p>
<p>Nam diễn vi&ecirc;n gắn b&oacute; với nghề MC từ năm 2003. Anh từng dẫn chương tr&igrave;nh như&nbsp;<em>7 ng&agrave;y vui sống (VTV1), Chuyến 
xe nh&acirc;n &aacute;i (TH Vĩnh Long), Bạn của đất (TH Ki&ecirc;n Giang)...</em></p>
<p>Hiện Đ&igrave;nh Hiếu c&ocirc;ng t&aacute;c chủ yếu ở đ&agrave;i Vĩnh Long. Anh vẫn tham gia đ&oacute;ng phim, quản l&yacute; nh&agrave; h&agrave;ng ri&ecirc;ng ở S&agrave;i G&ograve;n.</p>','2','2020-09-11','650','5','1');




INSERT INTO `posts`(`PostID`, `Abtract`, `PostContent`, `Author`, `PostDate`, `Views`, `Ranks`, `Status`) VALUES ('9','Vừa nhịn thở dưới nước, vừa giải một lèo 6 khối rubik','<h2 id="article_sapo" class="ctTp tuht_show">Một sinh vi&ecirc;n ở Gruzia đ&atilde; giải th&agrave;nh c&ocirc;ng 6 khối rubik li&ecirc;n tiếp trong một lần nhịn thở duy nhất dưới nước.</h2>
<p>Kỷ lục giải khối rubik dưới của của ch&agrave;ng thanh ni&ecirc;n Vako Marchilashvili, 18 tuổi, diễn ra ng&agrave;y 17.8 trước đ&aacute;m đ&ocirc;ng, tại c&ocirc;ng vi&ecirc;n hải dương Gino Paradise ở th&agrave;nh phố Tbilisi, Gruzia.</p>
<p>Trong thời gian nhịn thở dưới nước trong thời gian 1 ph&uacute;t 44 gi&acirc;y, sinh vi&ecirc;n 18 tuổi đ&atilde; giải th&agrave;nh c&ocirc;ng 
tổng cộng 6 khối rubik trước sự cổ vũ nhiệt t&igrave;nh của kh&aacute;n giả.</p>
<p>Kỷ lục giải rubik dưới nước trước đ&oacute; thuộc về Anthony Brooks, với th&agrave;nh t&iacute;ch giải 5 khối rubik trong một lần nhịn thở dưới nước tại bang New Jersey, Mỹ, v&agrave;o năm 2014.</p>
<p>Marchilashvili đ&atilde; d&agrave;nh 6 th&aacute;ng luyện tập v&agrave; tin tưởng rằng kỷ lục mới của cậu sẽ tồn tại trong thời gian d&agrave;i.</p>
<p>&ldquo;T&ocirc;i luyện tập rất nhiều, l&ecirc;n kế hoạch để ph&aacute; kỷ lục v&agrave; đảm bảo an to&agrave;n cho bản th&acirc;n, bởi v&igrave; ngay cả một sai lầm nhỏ cũng c&oacute; thể g&acirc;y nguy hiểm tới t&iacute;nh mạng&rdquo;, Marchilashvili n&oacute;i.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>','2','2020-04-16','800','1','2');



INSERT INTO `posts`(`PostID`, `Abtract`, `PostContent`, `Author`, `PostDate`, `Views`, `Ranks`, `Status`) VALUES ('10','Chú bò may mắn nhất thế giới, to bằng một chiếc xe hơi','<h2 id="article_sapo" class="ctTp tuht_show">Ch&uacute; b&ograve; cao tới gần 2 m&eacute;t, nặng ngang với một chiếc xe hơi n&ecirc;n đ&oacute;n nhận kết cục may mắn.</h2>
<div class="sbNws">Sự kiện:&nbsp;<a class="sbevt clrGr fs12" title="Chuyện lạ Thế giới" href="https://www.24h.com.vn/chuyen-la-the-gioi-c159e1080.html">Chuyện lạ Thế giới</a></div>
<div class="sbNws">
<p>Theo Daily Star, ch&uacute; b&ograve; n&agrave;y cao gần ngang si&ecirc;u sao b&oacute;ng rổ Michael Jordan v&agrave; c&oacute; trọng lượng lớn kỷ lục.</p>
<p>V&igrave; k&iacute;ch thước đồ sộ n&ecirc;n ch&uacute; b&ograve; trải qua mỗi ng&agrave;y thảnh thơi đi dạo tr&ecirc;n c&aacute;nh đồng ở T&acirc;y &Uacute;c m&agrave; kh&ocirc;ng lo đến chuyện bị đưa v&agrave;o l&ograve; mổ.</p>
<p>Ch&uacute; b&ograve; 7 năm tuổi tr&ocirc;ng ho&agrave;n to&agrave;n vượt trội hơn hẳn c&aacute;c đồng loại kh&aacute;c ở trang trại. Chủ trang 
trại, Geoff Pearson, n&oacute;i ch&iacute;nh v&igrave; k&iacute;ch thước to lớn dị thường m&agrave; ch&uacute; b&ograve; n&agrave;y tho&aacute;t cảnh v&agrave;o l&ograve; mổ.</p>
<p>L&yacute; do đơn giản l&agrave; v&igrave; kh&ocirc;ng một l&ograve; mổ địa phương n&agrave;o c&oacute; thể xử l&yacute; được con b&ograve; to như vậy.</p>
<p>Geoff n&oacute;i: &ldquo;N&oacute; qu&aacute; to v&agrave; nặng. Ch&uacute;ng t&ocirc;i kh&ocirc;ng thể đưa n&oacute; qua d&acirc;y chuyền giết mổ. vậy n&ecirc;n tốt nhất l&agrave; để n&oacute; sống vui vẻ suốt đời&rdquo;.</p>
<p>Chủ nh&acirc;n n&oacute;i đ&atilde; bỏ ra 225 bảng Anh để mua ch&uacute; b&ograve; khi n&oacute; c&ograve;n nhỏ. &ldquo;Trải qua năm th&aacute;ng, ch&uacute; b&ograve; ng&agrave;y c&agrave;ng lớn vượt trội so với c&aacute;c đồng loại kh&aacute;c&rdquo;.</p>
<p>Trong khi những con b&ograve; b&igrave;nh thường nặng khoảng 630kg, ch&uacute; b&ograve; cao lớn n&agrave;y nặng tới 1,4 tấn, tức l&agrave; ngang xe hơi. Ch&uacute; b&ograve; cũng c&oacute; m&agrave;u trắng nổi bật so với những con b&ograve; kh&aacute;c m&agrave;u n&acirc;u.</p>
<p>D&ugrave; c&oacute; k&iacute;ch thước đ&aacute;ng kể, nhưng ch&uacute; b&ograve; n&agrave;y chưa phải l&agrave; con b&ograve; lớn nhất từng được ghi nhận. S&aacute;ch Kỷ lục Guinness ghi nhận một con b&ograve; cao hơn 2 m&eacute;t v&agrave; nặng tới 2.267kg.</p>','4','2020-02-16','450','6','2');




INSERT INTO `posts`(`PostID`, `Abtract`, `PostContent`, `Author`, `PostDate`, `Views`, `Ranks`, `Status`) VALUES ('11','Căn bệnh "sát thủ thầm lặng" gần 30 triệu người Việt mắc dễ biến chứng thành ung thư gan','<p><strong>Gần 30 triệu người Việt bị&nbsp;<a class="TextlinkBaiviet" title="gan nhiễm mỡ" href="https://www.24h.com.vn/gan-nhiem-mo-c62e5209.html">gan nhiễm mỡ</a>&nbsp;do đ&acirc;u?</strong></p>
<p>Thống k&ecirc; của Bộ Y tế tại Hội thảo Gan mật to&agrave;n quốc vừa diễn ra, cho thấy, nước ta hiện c&oacute; 20-30&nbsp; triệu người (tương đương 20-30% d&acirc;n số) bị gan nhiễm mỡ.</p>
<p>Thống k&ecirc; mới đ&acirc;y của Bộ Y tế đ&atilde; khiến nhiều người phải giật m&igrave;nh: C&oacute; tới 30-35% số ca gan nhiễm mỡ sẽ tiến triển th&agrave;nh xơ gan. Đặc biệt, gan nhiễm mỡ do bia rượu c&oacute; tr&ecirc;n 50% sẽ bị xơ h&oacute;a, 25% sẽ tiến triển đến xơ gan v&agrave; 14% sẽ bị ung thư gan.</p>
<p>Ch&iacute;nh v&igrave; những l&yacute; do đ&oacute; m&agrave; c&aacute;c chuy&ecirc;n gia gan mật nước ta đ&atilde; ph&aacute;t đi cảnh b&aacute;o,&nbsp;<a class="TextlinkBaiviet" title="người bị gan nhiễm mỡ" href="https://www.24h.com.vn/gan-nhiem-mo-c62e5209.html">người bị gan nhiễm mỡ</a>&nbsp;d&ugrave; ở giai đoạn n&agrave;o cũng tuyệt đối kh&ocirc;ng thể chủ quan m&agrave; phải ch&uacute; trọng điều trị, ngăn chặn biến chứng sớm. Nước ta hiện c&oacute; 20-30&nbsp; triệu người (tương đương 20-30% d&acirc;n số) bị gan nhiễm mỡ.</p>
<p>Đ&aacute;ng ch&uacute; &yacute;, c&oacute; tới 90% người nghiện rượu bị gan nhiễm mỡ v&agrave; 10% c&ograve;n lại l&agrave; do những vấn đề kh&aacute;c như tiểu đường tu&yacute;p 2, mỡ m&aacute;u cao, b&eacute;o ph&igrave;, &iacute;t vận động, sử dụng thuốc qu&aacute; liều hoặc rối loạn dinh dưỡng&hellip;</p>
<p>Trong đ&oacute;, việc sử dụng rượu bia, chế độ dinh dưỡng, th&oacute;i quen ăn uống &ldquo;nhanh&rdquo; v&agrave; &iacute;t vận động l&agrave; 
những nguy&ecirc;n nh&acirc;n phổ biến trong x&atilde; hội hiện đại, khiến cho ngay cả người gầy cũng mắc căn bệnh n&agrave;y.</p>
<p>Gan nhiễm mỡ rất dễ t&aacute;i ph&aacute;t v&agrave; được gọi l&agrave; kẻ giết người thầm lặng bởi kh&ocirc;ng c&oacute; triệu chứng cụ thể, dễ nhầm lẫn với c&aacute;c bệnh kh&aacute;c. Hơn nữa t&acirc;m l&yacute; chủ quan của người bệnh cho rằng, b&aacute;c sĩ kh&ocirc;ng k&ecirc; thuốc nghĩa l&agrave; bệnh nhẹ v&agrave; chưa thấy kh&oacute; chịu g&igrave; n&ecirc;n kh&ocirc;ng cần quan t&acirc;m.</p>
<p><strong>Gan nhiễm mỡ n&ecirc;n ki&ecirc;ng g&igrave; v&agrave; n&ecirc;n ăn g&igrave;?</strong></p>
<p>Ths.Bs.Trần Thị Kh&aacute;nh Tường khuyến c&aacute;o, khi mắc gan nhiễm mỡ, trước ti&ecirc;n người bệnh cần kiểm so&aacute;t c&aacute;c yếu tố 
nguy&ecirc;n nh&acirc;n như: Từ bỏ rượu bia (Đối với nguy&ecirc;n nh&acirc;n do rượu), điều trị đ&aacute;i th&aacute;o đường, giảm c&acirc;n, tăng cường vận động v&agrave; duy tr&igrave; một chế độ dinh dưỡng hợp l&yacute;&hellip;đối với nguy&ecirc;n nh&acirc;n kh&ocirc;ng do rượu.</p>      
<p>Ở g&oacute;c độ đ&ocirc;ng y, TS.BS Phạm Hưng Củng &ndash; Nguy&ecirc;n Vụ trưởng Vụ y dược học cổ truyền Bộ Y tế khuyến c&aacute;o những người mắc gan nhiễm mỡ n&ecirc;n n&ecirc;n ki&ecirc;ng mỡ động vật, kh&ocirc;ng n&ecirc;n ăn qu&aacute; nhiều thịt đỏ, ki&ecirc;ng gia vị cay n&oacute;ng. Ki&ecirc;ng c&aacute;c đồ ăn cay n&oacute;ng như gừng, tỏi, ớt, hồ ti&ecirc;u, c&agrave; ph&ecirc;, tr&aacute;nh ăn những thực phẩm gi&agrave;u cholesterol; Tr&aacute;nh nội tạng động vật, l&ograve;ng đỏ trứng... chứa một lượng cholesterol cao</p>
<p>Những trường hợp gan nhiễm mỡ c&oacute; k&egrave;m vi&ecirc;m gan vừa hoặc nặng, n&ecirc;n cẩn thận khi ăn những loại tr&aacute;i c&acirc;y c&oacute; chứa nhiều năng lượng v&agrave; kh&oacute; ti&ecirc;u như sầu ri&ecirc;ng, m&iacute;t&hellip;</p>
<p>Mọi người n&ecirc;n ăn bổ sung rau, củ, quả: đ&acirc;y l&agrave; những thực phẩm l&yacute; tưởng cho người bệnh gan nhiễm mỡ v&igrave; c&oacute; t&aacute;c dụng hạ cholesterol trong m&aacute;u v&agrave; tế b&agrave;o gan như: Nấm hương, l&aacute; sen, rau cần, đậu n&agrave;nh chứa phospholipid, nần nghệ chứa saponin dồi d&agrave;o gi&uacute;p giảm gan nhiễm mỡ,&hellip;..</p>
<p>Những loại rau tươi như cải xanh, cải c&uacute;c, rau muống&hellip;chứa vitamin C, những loại quả như c&agrave; chua, mướp đắng, dưa gang, dưa 
chuột cũng gi&agrave;u vitamin v&agrave; kho&aacute;ng chất, c&oacute; c&ocirc;ng dụng gải nhiệt l&agrave;m m&aacute;t gan, thanh nhiệt.</p>      
<p>Đặc biệt, để hạn chế sự ph&aacute;t triển của bệnh, mọi người n&ecirc;n từ bỏ rượu bia, giảm c&acirc;n v&agrave; tập thể thao, thay đổi chế độ 
sinh hoạt khoa học, l&agrave;nh mạnh&hellip;.</p>','2','2020-03-15','100','11','2');




-- insert tags
INSERT INTO `tag`(`TagID`, `Name`) VALUES ('1','Báo gia đình');
INSERT INTO `tag`(`TagID`, `Name`) VALUES ('2','Chính trị Việt nam');
INSERT INTO `tag`(`TagID`, `Name`) VALUES ('3','bóng đá thế giới');
INSERT INTO `tag`(`TagID`, `Name`) VALUES ('4','ronaldo');
INSERT INTO `tag`(`TagID`, `Name`) VALUES ('5','đồ ăn dinh dưỡng cho bé');
INSERT INTO `tag`(`TagID`, `Name`) VALUES ('6','hoai linh');
INSERT INTO `tag`(`TagID`, `Name`) VALUES ('7','công dụng của mật ong');
INSERT INTO `tag`(`TagID`, `Name`) VALUES ('8','luật hôn nhân');
INSERT INTO `tag`(`TagID`, `Name`) VALUES ('9','luật lao động');
INSERT INTO `tag`(`TagID`, `Name`) VALUES ('10','Sức khỏe');
INSERT INTO `tag`(`TagID`, `Name`) VALUES ('11','showbiz');
INSERT INTO `tag`(`TagID`, `Name`) VALUES ('12','thế giới');



-- insert post_tags
INSERT INTO `post_tag`(`PostID`, `TagID`) VALUES ('1','10');
INSERT INTO `post_tag`(`PostID`, `TagID`) VALUES ('2','4');
INSERT INTO `post_tag`(`PostID`, `TagID`) VALUES ('3','10');
INSERT INTO `post_tag`(`PostID`, `TagID`) VALUES ('4','1');
INSERT INTO `post_tag`(`PostID`, `TagID`) VALUES ('5','1');
INSERT INTO `post_tag`(`PostID`, `TagID`) VALUES ('6','11');
INSERT INTO `post_tag`(`PostID`, `TagID`) VALUES ('7','11');
INSERT INTO `post_tag`(`PostID`, `TagID`) VALUES ('8','11');
INSERT INTO `post_tag`(`PostID`, `TagID`) VALUES ('9','12');
INSERT INTO `post_tag`(`PostID`, `TagID`) VALUES ('10','12');
INSERT INTO `post_tag`(`PostID`, `TagID`) VALUES ('11','10');



-- insert premiumusers
INSERT INTO `premiumusers`(`UserID`, `TimeEnd`) VALUES ('2','5040');



-- insert post-categories
INSERT INTO `post_categories`(`PostID`, `CatID`, `SubCatID`) VALUES ('1','3','12');
INSERT INTO `post_categories`(`PostID`, `CatID`, `SubCatID`) VALUES ('2','2','2');
INSERT INTO `post_categories`(`PostID`, `CatID`, `SubCatID`) VALUES ('3','3','12');
INSERT INTO `post_categories`(`PostID`, `CatID`, `SubCatID`) VALUES ('4','3','11');
INSERT INTO `post_categories`(`PostID`, `CatID`, `SubCatID`) VALUES ('5','3','12');
INSERT INTO `post_categories`(`PostID`, `CatID`, `SubCatID`) VALUES ('9','5','5');
INSERT INTO `post_categories`(`PostID`, `CatID`, `SubCatID`) VALUES ('10','5','5');
INSERT INTO `post_categories`(`PostID`, `CatID`, `SubCatID`) VALUES ('11','7','19');



-- insert censorship
INSERT INTO `censorship`(`PostID`, `UserID`, `StatusID`, `Date`, `Reason`) VALUES ('1','2','1','2020-06-19','pass');
INSERT INTO `censorship`(`PostID`, `UserID`, `StatusID`, `Date`, `Reason`) VALUES ('2','1','1','2020-06-19','pass');
INSERT INTO `censorship`(`PostID`, `UserID`, `StatusID`, `Date`, `Reason`) VALUES ('3','2','1','2020-06-19','pass');



-- update avatar
UPDATE `posts` SET `BigAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOwLqQLZR8WxMWJy9VGrnkFvZHbODKH1tSEyDCKIa-o6X79o0&s' WHERE `PostID`='1';

UPDATE `posts` SET `HasAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOwLqQLZR8WxMWJy9VGrnkFvZHbODKH1tSEyDCKIa-o6X79o0&s' WHERE `PostID`='1';

UPDATE `posts` SET `BigAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaQS8Vi58O4M7YpNDKKNjfJywIjdFVmLkTGtfSAzLbLI3L29Hj&s' WHERE `PostID`='2';

UPDATE `posts` SET `HasAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaQS8Vi58O4M7YpNDKKNjfJywIjdFVmLkTGtfSAzLbLI3L29Hj&s' WHERE `PostID`='2';

UPDATE `posts` SET `BigAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJylmR1TzlCGOudXjT8CiD6Ur8HWefR9VLcoYk_8_GhaXkKXi&s' WHERE `PostID`='3';

UPDATE `posts` SET `HasAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShJylmR1TzlCGOudXjT8CiD6Ur8HWefR9VLcoYk_8_GhaXkKXi&s' WHERE `PostID`='3';

UPDATE `posts` SET `BigAvatar`='https://cdn.24h.com.vn/upload/3-2019/images/2019-07-24/Ai-ngo-trung-chim-cut-co-the-chua-duoc-15-benh-cuc-hieu-qua-the-nay-1-1563963555-824-width600height450.jpg' WHERE `PostID`='4';

UPDATE `posts` SET `HasAvatar`='https://cdn.24h.com.vn/upload/3-2019/images/2019-07-24/Ai-ngo-trung-chim-cut-co-the-chua-duoc-15-benh-cuc-hieu-qua-the-nay-1-1563963555-824-width600height450.jpg' WHERE `PostID`='4';

UPDATE `posts` SET `BigAvatar`='https://cdn.24h.com.vn/upload/3-2020/images/2020-07-01/1593572341-1d7d65be37e500291e307977404da0e7.jpg' WHERE `PostID`='5';

UPDATE `posts` SET `HasAvatar`='https://cdn.24h.com.vn/upload/3-2020/images/2020-07-01/1593572341-1d7d65be37e500291e307977404da0e7.jpg' WHERE `PostID`='5';

UPDATE `posts` SET `BigAvatar`='https://cdn.24h.com.vn/upload/3-2019/images/2019-07-27/1564221094-61-cap-doi-hai-dinh-dam-bao-liem---van-son-ra-sao-khi-khong-con-hop-tac-60338271_2273842209339041_2544536817416273920_n-1563529937-width960height720.jpg' WHERE `PostID`='6';

UPDATE `posts` SET `HasAvatar`='https://cdn.24h.com.vn/upload/3-2019/images/2019-07-27/1564221094-61-cap-doi-hai-dinh-dam-bao-liem---van-son-ra-sao-khi-khong-con-hop-tac-60338271_2273842209339041_2544536817416273920_n-1563529937-width960height720.jpg' WHERE `PostID`='6';

UPDATE `posts` SET `BigAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJrXUuC5XmLYvOPASWUozf3FtRGeNgx4aHIhmvjtr1zkIB1IDK&s' WHERE `PostID`='7';

UPDATE `posts` SET `HasAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJrXUuC5XmLYvOPASWUozf3FtRGeNgx4aHIhmvjtr1zkIB1IDK&s' WHERE `PostID`='7';

UPDATE `posts` SET `BigAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtxIYJ9f4trvUioL0RGHk51uxbRrKP1VmZXxxyjz6Soha_jQM&s' WHERE `PostID`='8';

UPDATE `posts` SET `HasAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtxIYJ9f4trvUioL0RGHk51uxbRrKP1VmZXxxyjz6Soha_jQM&s' WHERE `PostID`='8';

UPDATE `posts` SET `BigAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLUK-9ZhJ88pqqMxoE_1YqXTtVzv4hi9OdHSdY0xBfm4w0lKIb&s' WHERE `PostID`='9';

UPDATE `posts` SET `HasAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLUK-9ZhJ88pqqMxoE_1YqXTtVzv4hi9OdHSdY0xBfm4w0lKIb&s' WHERE `PostID`='9';

UPDATE `posts` SET `BigAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMm20OFsy9otXDsBIIt6I-fG2VjurrMQmL-cPKr6w6-7Zz8Cga&s' WHERE `PostID`='10';

UPDATE `posts` SET `HasAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMm20OFsy9otXDsBIIt6I-fG2VjurrMQmL-cPKr6w6-7Zz8Cga&s' WHERE `PostID`='10';

UPDATE `posts` SET `BigAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA-NtKqSnozE9Vfe6oHUlTdUPTh41YjtGVIR1_YJXUK5coU9KR&s' WHERE `PostID`='11';

UPDATE `posts` SET `HasAvatar`='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA-NtKqSnozE9Vfe6oHUlTdUPTh41YjtGVIR1_YJXUK5coU9KR&s' WHERE `PostID`='11';
COMMIT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

