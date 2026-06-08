import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Home/Pages/Home_Page.dart';
import 'package:flutter_application_1/Features/Renovasi/Providers/Renovasi_Provider.dart';
import 'package:flutter_application_1/Features/Renovasi/Widgets/Estimasi_Bayar.dart';
import 'package:flutter_application_1/Features/Renovasi/Widgets/Jadwal_Preferensi.dart';
import 'package:flutter_application_1/Features/Renovasi/Widgets/Lokasi_Kondisi.dart';
import 'package:flutter_application_1/Features/Renovasi/Widgets/Metode_Pembayaran_Page.dart';
import 'package:flutter_application_1/Features/Renovasi/Widgets/Pembayaran.dart';
import 'package:flutter_application_1/Features/Renovasi/Widgets/Renovasi_Perbaikan.dart';
import 'package:provider/provider.dart';
import '../../Checkout/Providers/Order_Provider.dart';
import 'package:intl/intl.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
  decimalDigits: 0,
);

class RenovasiPage extends StatefulWidget {
  @override
  State<RenovasiPage> createState() => _RenovasiPageState();
}

class _RenovasiPageState extends State<RenovasiPage> {
  final List<Map<String, String>> stepData = [
    {"title": "RENOVASI DAN PERBAIKAN", "step": "Step 1 of 6"},
    {"title": "LOKASI DAN KONDISI", "step": "Step 2 of 6"},
    {"title": "JADWAL DAN PREFERENSI", "step": "Step 3 of 6"},
    {"title": "ESTIMASI BIAYA", "step": "Step 4 of 6"},
    {"title": "METODE PEMBAYARAN", "step": "Step 5 of 6"},
    {"title": "PEMBAYARAN", "step": "Step 6 of 6"},
  ];

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<RenovasiProvider>();
    final order = context.watch<OrderProvider>();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;

        if (prov.currentStep == 5) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
            (route) => false,
          );

          return;
        }

        if (prov.currentStep > 0) {
          prov.prevStep();
          order.resetPayment();
        } else {
          prov.reset();
          order.resetPayment();
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Column(children: [Expanded(child: _buildStepContent())]),
        bottomNavigationBar: _buildActionbutton(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final prov = context.watch<RenovasiProvider>();
    final data = stepData[prov.currentStep];

    return AppBar(
      elevation: 1,
      shadowColor: Colors.black87,
      automaticallyImplyLeading: false,
      toolbarHeight: 63,
      title: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            splashRadius: 10,
            onPressed: () {
              if (prov.currentStep == 5) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                  (route) => false,
                );

                return;
              }
              if (prov.currentStep > 0) {
                setState(() {
                  prov.prevStep();
                });
              } else {
                prov.reset();
                context.read<OrderProvider>().resetPayment();
                Navigator.pop(context);
              }
            },
            icon: Transform.translate(
              offset: Offset(-9, 0),
              child: Icon(Icons.arrow_back, size: 24),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data["title"]!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                ),
              ),
              Text(
                data["step"]!,
                style: TextStyle(fontSize: 12, fontFamily: "Inria Sans"),
              ),
            ],
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(3),
        child: LinearProgressIndicator(
          value: (prov.currentStep + 1) / stepData.length,
          backgroundColor: Colors.grey.shade300,
          color: Color(0xff003466),
          minHeight: 3,
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    final prov = context.watch<RenovasiProvider>();

    switch (prov.currentStep) {
      case 0:
        return RenovasiPerbaikan();
      case 1:
        return LokasiKondisi();
      case 2:
        return JadwalPreferensi();
      case 3:
        return EstimasiBayar();
      case 4:
        return MetodePembayaranPage();
      case 5:
        return Pembayaran(order: prov.currentOrder!);
      default:
        return Container();
    }
  }

  Widget? _buildActionbutton() {
    final prov = context.watch<RenovasiProvider>();
    switch (prov.currentStep) {
      case 0:
      case 1:
      case 2:
        return _defaultBottomButton();
      case 3:
        return _estimasitBottomButton();
      case 4:
        return null;
      case 5:
        return null;
      default:
        return null;
    }
  }

  Widget _defaultBottomButton() {
    final prov = context.watch<RenovasiProvider>();

    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff0369C8),
            disabledBackgroundColor: Colors.grey.shade400,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          onPressed: prov.isStepValid(prov.currentStep) ? prov.nextStep : null,

          child: Text(
            _buttonText(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Inria Sans",
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  String _buttonText() {
    final prov = context.watch<RenovasiProvider>();

    switch (prov.currentStep) {
      case 0:
        return "Tentukan Lokasi Proyek";

      case 1:
        return "Tentukan Jadwal dan Preferensi";

      case 2:
        return "Review Estimasi Biaya";

      case 3:
        return "Lanjut Ke Pembayaran";

      default:
        return "Next";
    }
  }

  Widget _estimasitBottomButton() {
    final prov = context.watch<RenovasiProvider>();

    final total = prov.estimasiHarga;

    return Container(
      height: 115,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ESTIMASI TOTAL",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                formatRupiah.format(total),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xff045097),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff0369C8),
                disabledBackgroundColor: Colors.grey.shade400,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              onPressed: prov.isStepValid(prov.currentStep)
                  ? () {
                      final renovasi = context.read<RenovasiProvider>();

                      final order = context.read<OrderProvider>();

                      order.checkoutRenovasi(
                        data: renovasi.formData,
                        total: renovasi.estimasiHarga,
                      );

                      renovasi.nextStep();
                    }
                  : null,

              child: Text(
                _buttonText(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inria Sans",
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
