-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 20 Sep 2020 pada 11.22
-- Versi server: 10.1.37-MariaDB
-- Versi PHP: 7.1.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbbril_agen`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `agen`
--

CREATE TABLE `agen` (
  `id` int(11) NOT NULL,
  `no_lisensi` mediumint(4) NOT NULL,
  `nama_agen` varchar(100) NOT NULL,
  `id_agen_level` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `status_tgl` date NOT NULL,
  `wilayah_kerja` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `agen`
--

INSERT INTO `agen` (`id`, `no_lisensi`, `nama_agen`, `id_agen_level`, `status`, `status_tgl`, `wilayah_kerja`) VALUES
(1, 1002, 'Endang', 1, 1, '2020-09-19', 'DKI JAKARTA'),
(2, 1001, 'Agung', 2, 1, '2020-09-19', 'DKI JAKARTA'),
(3, 1003, 'Perdana', 3, 1, '2020-09-19', 'DKI JAKARTA'),
(4, 1004, 'Gumelar', 4, 1, '2020-09-19', 'DKI JAKARTA'),
(5, 1005, 'Tegar', 4, 1, '2020-09-20', 'Jawa Barat'),
(6, 1006, 'Mahesa', 3, 1, '2020-09-20', 'Jawa Barat'),
(7, 1007, 'Pamungkas', 2, 1, '2020-09-20', 'Jawa Barat'),
(8, 1008, 'Akbar', 1, 1, '2020-09-20', 'Jawa Barat'),
(9, 1010, 'Mahendra', 1, 1, '2020-09-20', 'Aceh'),
(11, 1012, 'Dimas', 3, 1, '2020-09-20', 'Aceh'),
(12, 1013, 'Rendi', 1, 1, '2020-09-20', 'Aceh'),
(14, 1014, 'Radit', 4, 1, '2020-09-20', 'Aceh'),
(15, 1014, 'Bima', 2, 1, '2020-09-20', 'Aceh');

-- --------------------------------------------------------

--
-- Struktur dari tabel `agen_level`
--

CREATE TABLE `agen_level` (
  `id` int(11) NOT NULL,
  `level` char(5) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `urutan` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `agen_level`
--

INSERT INTO `agen_level` (`id`, `level`, `keterangan`, `urutan`) VALUES
(1, 'FU', 'Field Underwriter', 4),
(2, 'UM', 'Unit Manajer', 3),
(3, 'SM', 'Sales Manajer', 2),
(4, 'RM', 'Regional Manajer', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `agen_struktur`
--

CREATE TABLE `agen_struktur` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `id_agen` int(11) NOT NULL,
  `berlaku_mulai` date NOT NULL,
  `berlaku_akhir` date NOT NULL,
  `status` char(1) NOT NULL,
  `keterangan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `agen_struktur`
--

INSERT INTO `agen_struktur` (`id`, `parent_id`, `id_agen`, `berlaku_mulai`, `berlaku_akhir`, `status`, `keterangan`) VALUES
(3, 2, 1, '2020-09-19', '2020-09-22', 'A', ''),
(4, 3, 2, '2020-09-19', '2020-09-24', 'A', ''),
(5, 6, 7, '2020-09-19', '2020-09-29', 'A', ''),
(6, 15, 9, '2020-09-19', '2020-09-13', 'N', '');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `agen`
--
ALTER TABLE `agen`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `agen_level`
--
ALTER TABLE `agen_level`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `agen_struktur`
--
ALTER TABLE `agen_struktur`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `agen`
--
ALTER TABLE `agen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `agen_level`
--
ALTER TABLE `agen_level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `agen_struktur`
--
ALTER TABLE `agen_struktur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
