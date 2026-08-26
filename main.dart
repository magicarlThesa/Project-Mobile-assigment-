// Mengimpor library Flutter untuk membuat tampilan aplikasi
import 'package:flutter/material.dart';

// Mengimpor data buku dan halaman detail dari file buku.dart
import 'buku.dart';


// Fungsi utama untuk menjalankan aplikasi
void main() {
  runApp(const PerpustakaanApp());
}


// Widget utama aplikasi
// StatelessWidget digunakan karena bagian ini tidak memiliki data yang berubah
class PerpustakaanApp extends StatelessWidget {
  const PerpustakaanApp({super.key});

  @override
  Widget build(BuildContext context) {

    // MaterialApp digunakan sebagai dasar aplikasi Flutter
    return MaterialApp(
      // Menghilangkan tulisan DEBUG di pojok kanan atas
      debugShowCheckedModeBanner: false,

      // Nama aplikasi
      title: 'Perpustakaan Mini',

      // Mengatur tema warna utama aplikasi
      theme: ThemeData(primarySwatch: Colors.blue),

      // Menentukan halaman pertama yang ditampilkan
      home: const PerpustakaanPage(),
    );
  }
}


// Halaman utama perpustakaan
// StatefulWidget digunakan karena isi halaman dapat berubah saat melakukan pencarian
class PerpustakaanPage extends StatefulWidget {
  const PerpustakaanPage({super.key});

  @override
  State<PerpustakaanPage> createState() => _PerpustakaanPageState();
}


// State dari halaman perpustakaan
class _PerpustakaanPageState extends State<PerpustakaanPage> {

  // Menyimpan kata yang dimasukkan pengguna pada kolom pencarian
  String kataKunci = '';

  @override
  Widget build(BuildContext context) {

    // Menyaring daftar buku berdasarkan judul
    // Hanya buku yang judulnya mengandung kataKunci yang ditampilkan
    final bukuTersaring = daftarBuku
        .where(
          (buku) => buku['judul']
              .toString()
              .toLowerCase()
              .contains(kataKunci.toLowerCase()),
        )
        .toList();


    // Mengambil semua genre dari daftar buku
    // toSet() digunakan agar genre yang sama tidak muncul berulang
    final Set<String> genreUnik =
        daftarBuku.map((buku) => buku['genre'] as String).toSet();


    // Scaffold adalah struktur dasar halaman Flutter
    return Scaffold(

      // Bagian atas aplikasi
      appBar: AppBar(
        title: const Text('Katalog Buku Perpustakaan'),
      ),

      // Isi utama halaman
      body: Column(
        children: [

          // Memberikan jarak di sekitar kolom pencarian
          Padding(
            padding: const EdgeInsets.all(12),

            // Kolom untuk memasukkan kata pencarian
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Cari judul buku',

                // Ikon pencarian
                prefixIcon: Icon(Icons.search),

                // Membuat garis kotak pada TextField
                border: OutlineInputBorder(),
              ),

              // Dipanggil setiap kali isi TextField berubah
              onChanged: (value) {

                // Memperbarui kataKunci
                // setState membuat tampilan diperbarui kembali
                setState(() {
                  kataKunci = value;
                });
              },
            ),
          ),


          // Menampilkan daftar genre dalam bentuk Chip
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),

            // Wrap membuat Chip dapat berpindah ke baris berikutnya
            // jika ruang tidak cukup
            child: Wrap(
              spacing: 8,

              // Mengubah setiap genre menjadi sebuah Chip
              children: genreUnik
                  .map((genre) => Chip(label: Text(genre)))
                  .toList(),
            ),
          ),


          // Memberikan jarak vertikal
          const SizedBox(height: 8),


          // Expanded membuat daftar buku menggunakan sisa ruang layar
          Expanded(

            // Menampilkan buku dalam bentuk list
            child: ListView.builder(

              // Jumlah item yang ditampilkan sesuai hasil pencarian
              itemCount: bukuTersaring.length,

              // Membuat setiap item buku
              itemBuilder: (context, index) {

                // Mengambil data buku berdasarkan index
                final buku = bukuTersaring[index];


                // Card digunakan agar setiap buku terlihat seperti kartu
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  // ListTile digunakan untuk menampilkan informasi buku
                  child: ListTile(

                    // Ketika buku diklik, buka halaman detail
                    onTap: () {
                      Navigator.push(
                        context,

                        // Membuat perpindahan ke halaman DetailBukuPage
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailBukuPage(buku: buku),
                        ),
                      );
                    },


                    // Menampilkan judul buku
                    title: Text(
                      buku['judul'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    // Menampilkan informasi tambahan buku
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Menampilkan nama pengarang
                        Text('Pengarang: ${buku['pengarang']}'),

                        // Menampilkan tahun terbit
                        Text('Tahun: ${buku['tahunTerbit']}'),

                        // Menampilkan rating buku
                        Text('Rating: ${buku['rating']}'),

                        // Menampilkan kategori berdasarkan rating
                        Text(
                          'Kategori: ${kategoriRating(buku['rating'])}',
                        ),

                        const SizedBox(height: 4),


                        // Menampilkan status ketersediaan buku
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),

                          // Hijau jika tersedia, merah jika sedang dipinjam
                          color: buku['tersedia']
                              ? Colors.green
                              : Colors.red,

                          child: Text(

                            // Menentukan teks berdasarkan nilai tersedia
                            buku['tersedia']
                                ? 'Tersedia'
                                : 'Dipinjam',

                            // Warna tulisan putih
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}