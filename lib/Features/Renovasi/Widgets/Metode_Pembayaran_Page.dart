import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/Remote/Metode_Proyek_Opsi.dart';
import 'package:flutter_application_1/Features/Checkout/Providers/Order_Provider.dart';
import 'package:flutter_application_1/Core/Helpers/Dialog_Error.dart';
import 'package:flutter_application_1/Features/Renovasi/Widgets/Elemens/Metode_pembayaran_Proyek.dart';
import 'package:flutter_application_1/Features/Renovasi/Widgets/Elemens/Rincian_Estimasi_Harga_Renov.dart';
import 'package:provider/provider.dart';
import '../Providers/Renovasi_Provider.dart';
import '../../../Data/Remote/Renovasi_Form/Kebutuhan_Options.dart';
import '../../../Data/Remote/Renovasi_Form/Area_Options.dart';
import '../../../Data/Remote/Renovasi_Form/Pekerjaan_Options.dart';
import '../../../Data/Remote/Renovasi_Form/Pengerjaan_Options.dart';
import '../Models/Renovasi_OpsiPilih.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Elemens/Pembayaran_Card.dart';
import '../../../Data/Remote/Pembayaran_Data.dart';
import '../../Checkout/Pages/Detail_Pembayaran.dart';
import '../../Konfirmasi/Models/Pembayaran_Model.dart';
import '../../RiwayatPesanan/Provider/Riwayat_Provider.dart';
import '../../RiwayatPesanan/Models/Riwayat_Model.dart';

class MetodePembayaranPage extends StatefulWidget {
  @override
  State<MetodePembayaranPage> createState() => _MetodePembayaranPageState();
}

class _MetodePembayaranPageState extends State<MetodePembayaranPage> {
  String getPreviewText(PembayaranKategori kategori) {
    final list = MetodePembayaran.where(
      (e) => e.category == kategori,
    ).take(3).map((e) => e.id).toList();

    return "${list.join(", ")}, dll";
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<RenovasiProvider>();
    final order = context.watch<OrderProvider>();
    final selectedPayment = order.selectedPayment;
    final isValid = prov.isMetodePembayaranValid(order);
    final isHarian = prov.formData.pengerjaan == "harian";
    if (isHarian && order.paymentType != "full") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<OrderProvider>().setPaymentType("full");
      });
    }
    final metodePembayaran = isHarian
        ? OpsiMetodeProyek.where((e) => e.code == "full").toList()
        : OpsiMetodeProyek;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ringkasan Proyek",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 65,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(30),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.handyman,
                          size: 30,
                          color: Color(0xff004597),
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: Consumer<RenovasiProvider>(
                        builder: (context, provider, child) {
                          final data = provider.formData;

                          final kebutuhanTitle = kebutuhanOptions
                              .firstWhere(
                                (item) => item.value == data.kebutuhan,
                                orElse: () =>
                                    RenovasiOpsipilih(value: '', title: '-'),
                              )
                              .title;

                          final areaTitle = areaOptions
                              .firstWhere(
                                (item) => item.value == data.area,
                                orElse: () =>
                                    RenovasiOpsipilih(value: '', title: '-'),
                              )
                              .title;

                          final tingkatTitle = pekerjaanOptions
                              .firstWhere(
                                (item) => item.value == data.tingkatKerusakan,
                                orElse: () =>
                                    RenovasiOpsipilih(value: '', title: '-'),
                              )
                              .title;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$kebutuhanTitle ・ $areaTitle",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inria Sans",
                                  color: Color(0xff045097),
                                ),
                              ),

                              Text(
                                tingkatTitle,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Inria Sans",
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inria Sans",
                          color: Color(0xff0369C8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 65,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(30),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 28,
                          height: 30,
                          child: SizedBox(
                            width: 27,
                            height: 29,
                            child: SvgPicture.asset(
                              "assets/icon/Kalender_Jam.svg",
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                Color(0xff045097),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: Consumer<RenovasiProvider>(
                        builder: (context, provider, child) {
                          final data = provider.formData;

                          final tanggal = DateFormat(
                            'dd MM yyyy',
                          ).format(data.tanggalKunjungan!);

                          final jam = data.jamKunjungan;

                          final pengerjaanTitle = pengerjaanOptions
                              .firstWhere(
                                (item) => item.value == data.pengerjaan,
                                orElse: () =>
                                    RenovasiOpsipilih(value: '', title: '-'),
                              )
                              .title;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Kunjungan: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inria Sans",
                                        color: Color(0xff045097),
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "$tanggal ・ $jam",
                                      style: TextStyle(
                                        fontFamily: "Inria Sans",
                                        color: Color(0xff045097),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                pengerjaanTitle,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Inria Sans",
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inria Sans",
                          color: Color(0xff0369C8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              if (!isHarian) ...[
                Text(
                  "Metode Pembayaran Proyek",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inria Sans",
                  ),
                ),
                SizedBox(height: 10),

                MetodePembayaranProyek(
                  metodeList: metodePembayaran,

                  selectedCode: order.paymentType,

                  onSelected: (index, metode) {
                    context.read<OrderProvider>().setPaymentType(metode);
                  },
                ),

                SizedBox(height: 16),
              ],
              Text(
                "Metode Transaksi",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(40),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ...PembayaranKategorii.asMap().entries.map((entry) {
                      final index = entry.key;
                      final category = entry.value;

                      final isActive =
                          selectedPayment != null &&
                          selectedPayment.category == category.type;

                      return Column(
                        children: [
                          PembayaranCard(
                            category: category,
                            subtitle: isActive
                                ? selectedPayment.id
                                : getPreviewText(category.type),
                            isSelected: isActive,
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailPembayaran(category: category.type),
                                ),
                              );

                              if (result != null) {
                                context.read<OrderProvider>().selectPayment(
                                  result,
                                );
                              }
                            },
                          ),
                          if (index != PembayaranKategorii.length - 1)
                            Divider(height: 1),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Rincian Estimasi Biaya",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
              SizedBox(height: 12),
              RincianEstimasiHarga(),
              SizedBox(height: 16),
              InkWell(
                onTap: isValid
                    ? () {
                        final orderProvider = context.read<OrderProvider>();

                        final riwayatProvider = context.read<RiwayatProvider>();

                        final renovasiProvider = context
                            .read<RenovasiProvider>();
                        final data = renovasiProvider.formData;

                        final kebutuhanTitle = kebutuhanOptions
                            .firstWhere(
                              (item) => item.value == data.kebutuhan,
                              orElse: () =>
                                  RenovasiOpsipilih(value: '', title: '-'),
                            )
                            .title;

                        final areaTitle = areaOptions
                            .firstWhere(
                              (item) => item.value == data.area,
                              orElse: () =>
                                  RenovasiOpsipilih(value: '', title: '-'),
                            )
                            .title;

                        final tingkatTitle = pekerjaanOptions
                            .firstWhere(
                              (item) => item.value == data.tingkatKerusakan,
                              orElse: () =>
                                  RenovasiOpsipilih(value: '', title: '-'),
                            )
                            .title;

                        /// =========================
                        /// STEP BIASA
                        /// =========================
                        if (prov.currentStep < 4) {
                          prov.nextStep();
                          return;
                        }

                        /// =========================
                        /// STEP 5 (CHECKOUT)
                        /// BUAT ORDER
                        /// =========================

                        final selectedPayment = orderProvider.selectedPayment;
                        final paymentType = orderProvider.paymentType;
                        final bayarSekrang = orderProvider.bayarSekarang;
                        final sisaPembayaran = orderProvider.sisaPembayaran;
                        final biayaJasa = renovasiProvider.biayaJasa;
                        final biayaMaterial = renovasiProvider.biayaMaterial;

                        /// VALIDASI PAYMENT
                        if (selectedPayment == null) {
                          showErrorDialog(
                            context,
                            "Silakan pilih metode pembayaran terlebih dahulu.",
                            title: "Metode Pembayaran",
                          );
                          return;
                        }
                        print(paymentType);
                        print(selectedPayment);
                        final newOrder = RiwayatModel(
                          id: orderProvider.invoice!,
                          type: OrderType.renovasi,
                          title: "Renovasi $areaTitle",
                          imagePath: renovasiProvider.formData.media,
                          date: DateTime.now(),
                          area: areaTitle,
                          kebutuhan: kebutuhanTitle,
                          tingkatKerusakan: tingkatTitle,
                          tanggalKunjungan: data.tanggalKunjungan,
                          jamKunjungan: data.jamKunjungan,
                          pengerjaan: data.pengerjaan,
                          media: data.media,
                          deskripsi: data.deskripsi,
                          metodePembayaranProyek: paymentType,
                          bayarSekarang: bayarSekrang,
                          sisaPembayaran: sisaPembayaran,
                          biayaJasa: biayaJasa,
                          biayaMaterial: biayaMaterial,
                          promoCode: renovasiProvider.appliedPromo?.code,
                          diskonPromo: renovasiProvider.diskonPromo,

                          /// STATUS AWAL
                          renovasiStatus: RenovasiStatus.menunggupembayaran,
                          renovasiStep: RenovasiStep.pembayaranBelumSelesai,
                          paymenMethod: selectedPayment,

                          /// PROGRESS AWAL
                          progress: 0.1,
                          tahap: "Renovasi sedang dilakukan",

                          totalPrice: orderProvider.total,

                          serviceLabel: "Renovasi",
                        );

                        /// SIMPAN RIWAYAT
                        riwayatProvider.tambahRiwayat(newOrder);

                        renovasiProvider.setCurrentOrder(newOrder);

                        /// START PAYMENT TIMER
                        orderProvider.startPaymentCountdown();

                        /// LANJUT STEP 6
                        /// (KONFIRMASI PEMBAYARAN)
                        prov.nextStep();
                      }
                    : null,

                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isValid ? Color(0xff0369C8) : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Lanjutkan Pembayaran",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inria Sans",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
