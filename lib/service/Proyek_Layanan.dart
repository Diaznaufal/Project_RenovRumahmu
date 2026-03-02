import '../models/status_proyek.dart';

class ProyekLayanan {
  static Future<List<StatusProyek>> getProyek() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      StatusProyek(
        title: "Renovasi Kamar Mandi",
        id: "ID: #RV-260203-1",
        status: "Pengerjaan",
        progres: 0.9,
        tahap: "Pemasangan keramik dinding",
      ),
      StatusProyek(
        title: "Renovasi Dapur",
        id: "ID: #RV-260203-2",
        status: "Finishing",
        progres: 0.6,
        tahap: "Pengecatan plafon",
      ),
      StatusProyek(
        title: "Renovasi Ruang Tamu",
        id: "ID: #RV-260203-3",
        status: "Menunggu",
        progres: 0.3,
        tahap: "Persiapan material",
      ),
    ];
  }
}
