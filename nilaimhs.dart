void main() {
  List<Map<String, dynamic>> mahasiswa = [
    {
      'nama': 'muthia',
      'nilai': [80, 90, 75, 85],
      'absensi': 3,
    },
    {
      'nama': 'Ilham',
      'nilai': [85, 92, 71, 83],
      'absensi': 2,
    },
    {
      'nama': 'ody',
      'nilai': [70, 80, 71, 86],
      'absensi': 2,
    },
    {
      'nama': 'dean',
      'nilai': [50, 60, 55, 65],
      'absensi': 1,
    },
    {
      'nama': 'buna',
      'nilai': [90, 91, 78, 83],
      'absensi': 2,
    },
  ];

  print('\n=== LAPORAN NILAI MAHASISWA ===');
  mahasiswa.forEach((data) {
    final nama = data['nama'];
    final nilai = data['nilai'] as List<int>;
    final absensi = data['absensi'] as int;

    final rataRata = hitungRataRata(nilai);
    final grade = tentukanGrade(rataRata);
    final lulus = cekKelulusan(rataRata: rataRata, absensi: absensi);

    print('\nNama     : $nama');
    print('Nilai      : $nilai');
    print('Rata-rata  : ${rataRata.toStringAsFixed(1)}');
    print('Grade      : $grade');
    print('Status     : ${lulus ? 'LULUS' : 'TIDAK LULUS'}');
  });

  final semuaNilai = mahasiswa
      .expand((data) => data['nilai'] as List<int>)
      .toList();

  final semuaRataRata = mahasiswa
      .map((data) => hitungRataRata(data['nilai'] as List<int>))
      .toList();

  final nilaiTertinggi = semuaNilai.reduce((a, b) => a > b ? a : b);

  final nilaiTerendah = semuaNilai.reduce((a, b) => a < b ? a : b);

  final rataKelas =
      semuaRataRata.reduce((a, b) => a + b) / semuaRataRata.length;

  print('\n=== STATISTIK KELAS ===');
  print('Nilai tertinggi      : $nilaiTertinggi');
  print('Nilai Terendah       : $nilaiTerendah');
  print('Rata-rata Kelas       : $rataKelas');
}
//baris fungsi
double hitungRataRata(List<int> nilai) =>
    nilai.reduce((a, b) => a + b) / nilai.length;

String tentukanGrade(double rataRata) {
  if (rataRata >= 85) {
    return 'A';
  } else if (rataRata >= 75) {
    return 'B';
  } else if (rataRata > -65) {
    return 'C';
  } else if (rataRata >= 50) {
    return 'D';
  } else {
    return 'E';
  }
}

bool cekKelulusan({required double rataRata, required int absensi}) =>
    rataRata >= 60 && absensi <= 3;
