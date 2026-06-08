import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Home/Pages/Home_Page.dart';
import 'package:flutter_application_1/Features/Checkout/Providers/Order_Provider.dart';
import 'package:flutter_application_1/Features/Renovasi/Providers/Renovasi_Provider.dart';
import 'package:flutter_application_1/Features/RiwayatPesanan/Models/Riwayat_Model.dart';
import 'package:flutter_application_1/Features/DetailPesanan/widgets/Alamat_user.dart';
import 'package:flutter_application_1/Features/StatusPesanan/Material/Widgets/Header_Statuspesanan.dart';
import 'package:flutter_application_1/Features/DetailPesanan/widgets/Rincian_Pesanan.dart';
import 'package:flutter_application_1/Features/StatusPesanan/Material/Widgets/Tracking_Timeline_material.dart';
import 'package:provider/provider.dart';

class StatusPesanan extends StatefulWidget {
  final RiwayatModel order;
  StatusPesanan({super.key, required this.order});

  @override
  State<StatusPesanan> createState() => _StatusPesananState();
}

class _StatusPesananState extends State<StatusPesanan> {
  final int currentStep = 2;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RenovasiProvider>().reset();
      context.read<OrderProvider>().resetPayment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          shadowColor: Colors.black.withAlpha(77),
          titleSpacing: 1,
          toolbarHeight: 60,
          title: Text(
            "STATUS PESANAN",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: "Inria Sans",
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderStatuspesanan(),
                  SizedBox(height: 15),

                  //Card Status + Alamat
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(44),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status Pesanan",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Inria Sans",
                          ),
                        ),
                        SizedBox(height: 15),

                        TrackingTimeline(currentStep: 2),

                        SizedBox(height: 15),
                        Text(
                          "Alamat Tujuan",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Inria Sans",
                          ),
                        ),
                        SizedBox(height: 5),

                        AlamatUser(),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),

                  //Rincian Pesanan
                  Text(
                    "Rincian Pesanan",
                    style: TextStyle(fontSize: 16, fontFamily: "Inria Sans"),
                  ),
                  SizedBox(height: 8),

                  if (widget.order.items == null || widget.order.items!.isEmpty)
                    Text("Tidak ada produk")
                  else
                    ...widget.order.items!.map(
                      (item) =>
                          RincianPesanan(item: item, product: item.product),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
