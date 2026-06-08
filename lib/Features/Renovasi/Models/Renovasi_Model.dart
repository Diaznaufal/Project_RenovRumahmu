class RenovasiModel {
  // step 1
  String? kebutuhan;
  String? area;
  String? tingkatKerusakan;

  // step 2
  String? alamat;
  String? catatanLokasi;
  List<String>? media;
  String? deskripsi;

  // step 3
  DateTime? tanggalKunjungan;
  String? catatan;
  String? jamKunjungan;
  String? pengerjaan;

  RenovasiModel({
    this.kebutuhan,
    this.area,
    this.tingkatKerusakan,
    this.alamat,
    this.catatanLokasi,
    this.media,
    this.deskripsi,
    this.tanggalKunjungan,
    this.catatan,
    this.jamKunjungan,
    this.pengerjaan,
  });
}
