enum PembayaranKategori { ewallet, bank, kartu }

class PembayaranKategoriModel {
  final PembayaranKategori type;
  final String title;
  final String iconPath;

  PembayaranKategoriModel({
    required this.type,
    required this.title,
    required this.iconPath,
  });
}

class PembayaranModel {
  final String id;
  final String title;
  final PembayaranKategori category;

  PembayaranModel({
    required this.id,
    required this.title,
    required this.category,
  });
}
