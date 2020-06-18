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
  `HasAvatar` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `BigAvatar` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
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
  `Status` int(11) NOT NULL
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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
