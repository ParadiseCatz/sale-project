-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 12, 2016 at 11:37 AM
-- Server version: 10.1.10-MariaDB
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `iton_marketplace`
--

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` int(32) NOT NULL,
  `id_pembeli` int(32) NOT NULL,
  `quantity` int(32) NOT NULL,
  `cosignee` varchar(50) NOT NULL,
  `full_address` varchar(100) NOT NULL,
  `postal_code` int(32) NOT NULL,
  `phone_number` bigint(64) NOT NULL,
  `creditcard_number` bigint(32) NOT NULL,
  `creditcard_verification` int(4) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `harga_barang` bigint(64) NOT NULL,
  `foto` mediumtext NOT NULL,
  `id_penjual` int(32) NOT NULL,
  `waktu_transaksi` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `id_pembeli`, `quantity`, `cosignee`, `full_address`, `postal_code`, `phone_number`, `creditcard_number`, `creditcard_verification`, `nama_barang`, `harga_barang`, `foto`, `id_penjual`, `waktu_transaksi`) VALUES
(3, 2, 1, 'asd', 'tubagus ismail ', 12345, 81122445566, 123123123123, 321, 'XBOX', 5000000, 'image\\57f79f2c4e71b.png', 1, '2016-10-07 15:13:30'),
(4, 3, 3, 'william', 'akakaak', 12345, 8111111115, 123456789999, 123, 'XBOX', 5000000, 'image\\57f79f2c4e71b.png', 1, '2016-10-19 11:30:13'),
(5, 2, 1, 'asd', 'tubagus ismail ', 12345, 81122445566, 123456789000, 123, 'ps5', 12350000, 'image\\58073ddb9077a.png', 1, '2016-10-19 11:38:33');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
