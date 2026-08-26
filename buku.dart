import 'package:flutter/material.dart';

final List<Map<String, dynamic>> daftarBuku = [
  {
    'judul': 'Laskar Pelangi',
    'pengarang': 'Andrea Hirata',
    'tahunTerbit': 2005,
    'rating': 4.8,
    'tersedia': true,
    'genre': 'Novel',
    'catatanPeminjam': null,
  },
  {
    'judul': 'Bumi',
    'pengarang': 'Tere Liye',
    'tahunTerbit': 2014,
    'rating': 4.6,
    'tersedia': true,
    'genre': 'Fantasi',
    'catatanPeminjam': 'Akan dikembalikan minggu depan',
  },
  {
    'judul': '3726 mdpl',
    'pengarang': 'Nurwina sari',
    'tahunTerbit': 2025,
    'rating': 4.5,
    'tersedia': false,
    'genre': 'Novel',
    'catatanPeminjam': 'Sedang dipinjam',
  },
  {
    'judul': 'Atomic Habits',
    'pengarang': 'James Clear',
    'tahunTerbit': 2018,
    'rating': 4.7,
    'tersedia': true,
    'genre': 'Pengembangan Diri',
    'catatanPeminjam': null,
  },
  {
    'judul': '0 mdpl(sekuens 3726)',
    'pengarang': 'Nurwina Sari',
    'tahunTerbit': 2026,
    'rating': 4.7,
    'tersedia': false,
    'genre': 'Romantic',
    'catatanPeminjam': 'Dipinjam oleh mahasiswa',
  },
  {
    'judul': 'Filosofi Teras',
    'pengarang': 'Henry Manampiring',
    'tahunTerbit': 2018,
    'rating': 4.5,
    'tersedia': true,
    'genre': 'Filsafat',
    'catatanPeminjam': null,
  },
];

String kategoriRating(double rating) {
  if (rating >= 4.5) {
    return 'Sangat Baik';
  } else if (rating >= 3.5) {
    return 'Baik';
  } else {
    return 'Cukup';
  }
}


class DetailBukuPage extends StatefulWidget {
  final Map<String, dynamic> buku;


  const DetailBukuPage({super.key, required this.buku});


  @override
  State<DetailBukuPage> createState() => _DetailBukuPageState();
}


class _DetailBukuPageState extends State<DetailBukuPage> {
  @override
  Widget build(BuildContext context) {
    String? catatanPeminjam = widget.buku['catatanPeminjam'];


    return Scaffold(
      appBar: AppBar(title: Text(widget.buku['judul'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.buku['judul'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('Pengarang: ${widget.buku['pengarang']}'),
            Text('Tahun Terbit: ${widget.buku['tahunTerbit']}'),
            Text('Rating: ${widget.buku['rating']}'),
            Text('Kategori: ${kategoriRating(widget.buku['rating'])}'),
            Text(
              'Status: ${widget.buku['tersedia'] ? 'Tersedia' : 'Dipinjam'}',
            ),
            const SizedBox(height: 16),
            Text(
              'Catatan Peminjam:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(catatanPeminjam ?? 'Tidak ada catatan'),
          ],
        ),
      ),
    );
  }
}


