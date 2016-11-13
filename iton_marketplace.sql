-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 13, 2016 at 07:31 AM
-- Server version: 10.1.16-MariaDB
-- PHP Version: 7.0.9

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
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id` int(32) NOT NULL,
  `id_penjual` int(32) NOT NULL,
  `username` varchar(100) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `harga` bigint(64) NOT NULL,
  `deskripsi` varchar(1000) NOT NULL,
  `waktu_ditambahkan` datetime NOT NULL,
  `jumlah_like` int(32) NOT NULL,
  `jumlah_dibeli` int(32) NOT NULL,
  `foto` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id`, `id_penjual`, `username`, `nama_barang`, `harga`, `deskripsi`, `waktu_ditambahkan`, `jumlah_like`, `jumlah_dibeli`, `foto`) VALUES
(3, 2, 'rome', 'Talia', 32131, 'fweagbvawbaewbwa', '2016-11-23 00:00:00', 3, 1, ''),
(40, 1, 'root', 'PS4', 4500000, 'PS4 Console master race', '2016-10-07 20:06:11', 1, 0, ''),
(48, 1, 'root', 'ps5', 12350000, 'asdlasjdaskl', '2016-10-19 16:33:15', 0, 1, ''),
(49, 3, '3', '3', 3, '3', '0000-00-00 00:00:00', 3, 3, '3'),
(50, 4, '12', '21', 323, '32', '2016-11-12 00:50:16', 0, 0, '4231'),
(51, 1, 'asd', 'asd', 123, 'asd', '2016-11-12 20:28:34', 0, 0, 'asd');

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
  `creeditcard_verification` int(4) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `harga_barang` bigint(64) NOT NULL,
  `path_foto` varchar(100) NOT NULL,
  `id_penjual` int(32) NOT NULL,
  `waktu_transaksi` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `id_pembeli`, `quantity`, `cosignee`, `full_address`, `postal_code`, `phone_number`, `creditcard_number`, `creeditcard_verification`, `nama_barang`, `harga_barang`, `path_foto`, `id_penjual`, `waktu_transaksi`) VALUES
(3, 2, 1, 'asd', 'tubagus ismail ', 12345, 81122445566, 123123123123, 321, 'XBOX', 5000000, 'image\\57f79f2c4e71b.png', 1, '2016-10-07 15:13:30'),
(4, 3, 3, 'william', 'akakaak', 12345, 8111111115, 123456789999, 123, 'XBOX', 5000000, 'image\\57f79f2c4e71b.png', 1, '2016-10-19 11:30:13'),
(5, 2, 1, 'asd', 'tubagus ismail ', 12345, 81122445566, 123456789000, 123, 'ps5', 12350000, 'image\\58073ddb9077a.png', 1, '2016-10-19 11:38:33');

-- --------------------------------------------------------

--
-- Table structure for table `user_liked`
--

CREATE TABLE `user_liked` (
  `id_user` int(32) NOT NULL,
  `id_barang` int(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_liked`
--

INSERT INTO `user_liked` (`id_user`, `id_barang`) VALUES
(2, 13),
(2, 14),
(2, 40),
(2, 46),
(3, 46),
(4, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id`,`id_penjual`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_liked`
--
ALTER TABLE `user_liked`
  ADD PRIMARY KEY (`id_user`,`id_barang`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barang`
--
ALTER TABLE `barang`
  MODIFY `id` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;
--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
