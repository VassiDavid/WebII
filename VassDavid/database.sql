-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Gép: localhost
-- Létrehozás ideje: 2018. Máj 06. 22:19
-- Kiszolgáló verziója: 10.1.30-MariaDB
-- PHP verzió: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `database`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `accounts`
--

CREATE TABLE `accounts` (
  `account_id` int(11) NOT NULL,
  `account_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `account_password` varchar(126) NOT NULL,
  `account_email` varchar(64) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `account_permission` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `menu`
--

CREATE TABLE `menu` (
  `menu_id` int(11) NOT NULL,
  `menu_parent_id` int(11) NOT NULL DEFAULT '0',
  `menu_title` varchar(32) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `menu_file` varchar(32) CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `menu_permission` tinyint(1) NOT NULL,
  `menu_order` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `menu`
--

INSERT INTO `menu` (`menu_id`, `menu_parent_id`, `menu_title`, `menu_file`, `menu_permission`, `menu_order`) VALUES
(1, 0, 'Home', 'home', 0, 1),
(2, 0, 'Vehicles', '', 0, 2),
(3, 2, 'Cars', '', 0, 1),
(4, 2, 'Motorbike', '', 0, 2),
(5, 0, 'News', 'news', 1, 3),
(6, 3, 'Tesla', 'tesla', 0, 1),
(7, 3, 'Audi', 'audi', 0, 2),
(8, 3, 'BMW', 'bmw', 0, 3),
(9, 4, 'Suzuki', 'suzuki', 0, 1),
(10, 4, 'Kawasaki', 'kawasaki', 0, 2),
(11, 4, 'Honda', 'honda', 0, 3),
(12, 4, 'Yamaha', 'yamaha', 0, 4),
(14, 0, 'Information', 'information', 0, 3);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `news`
--

CREATE TABLE `news` (
  `news_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `news_title` text CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `news_text` text CHARACTER SET utf8 COLLATE utf8_hungarian_ci NOT NULL,
  `news_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`account_id`);

--
-- A tábla indexei `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`menu_id`);

--
-- A tábla indexei `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`news_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `accounts`
--
ALTER TABLE `accounts`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `menu`
--
ALTER TABLE `menu`
  MODIFY `menu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT a táblához `news`
--
ALTER TABLE `news`
  MODIFY `news_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
