import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Home_Page.dart';
import 'package:flutter_application_1/models/Riwayat_Model.dart';
import 'package:flutter_application_1/widgets/Header_Statuspesanan.dart';
import 'package:flutter_application_1/widgets/Rincian_Pesanan.dart';
import 'package:flutter_application_1/widgets/Riwayat_status.dart';
import '../models/Order_status.dart';
import 'package:provider/provider.dart';
import '../Provider/Addres_Provider.dart';


class StatusPesanan extends StatelessWidget {
  final RiwayatModel order;
  StatusPesanan({super.key, required this.order});

  final List<OrderStatus> statuses = [
    OrderStatus(
      title: "Pesanan Dibuat",
      subtitle: "20 Feb 2026, 14:00 - Pembayaran Terverifikasi",
    
    ),
    OrderStatus(
      title: "Pesanan Disiapkan",
      subtitle: "20 Feb 2026, 16:00 - Diproses Gudang",
    ),
    OrderStatus(
      title: "Pesanan Dikirim",
      subtitle: "Estimasi pengiriman: 22 Feb, 10:00 - 12:00",
    ),
    OrderStatus(
      title: "Pesanan Diterima",
      subtitle: "Estimasi tiba: 23 - 24 Feb",
    ),
  ];

  final int currentStep = 2;

  @override
  Widget build(BuildContext context) {
    final address = context.watch<AddressProvider>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) =>  HomePage()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          shadowColor: Colors.black.withAlpha(77),
          titleSpacing: 1,
          toolbarHeight: 60,
          title:  Text(
            "STATUS PESANAN",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) =>  HomePage()),
              );
            },
            icon:  Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderStatuspesanan(),
                   SizedBox(height: 15),

                  //Card Status + Alamat
                  Container(
                    padding:  EdgeInsets.all(20),
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
                          style: TextStyle(fontSize: 16),
                        ),
                         SizedBox(height: 15),

                        Column(
                          children: List.generate(
                            statuses.length,
                            (index) => RiwayatStatus(
                              status: statuses[index],
                              index: index,
                              currentStep: currentStep,
                              isLast: index == statuses.length - 1,
                            ),
                          ),
                        ),

                         SizedBox(height: 15),
                         Text(
                          "Alamat Tujuan",
                          style: TextStyle(fontSize: 16),
                        ),
                         SizedBox(height: 5),

                        Row(
                          children: [
                             Icon(
                              Icons.location_pin,
                              size: 15,
                              color: Color(0xff045097),
                            ),
                             SizedBox(width: 4),
                            Text(
                              address.selectedAddress?.name ?? "",
                              style:  TextStyle(
                                fontSize: 12,
                                color: Color(0xff045097),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          address.selectedAddress?.phone ?? "",
                          style:  TextStyle(fontSize: 10),
                        ),
                         SizedBox(height: 5),
                        Text(
                          address.selectedAddress?.fullAddress ?? "",
                          style:  TextStyle(fontSize: 10),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                   SizedBox(height: 15),

                  //Rincian Pesanan
                   Text("Rincian Pesanan", style: TextStyle(fontSize: 16)),
                   SizedBox(height: 8),

                  if (order.items == null || order.items!.isEmpty)
                     Text("Tidak ada produk")
                  else
                    ...order.items!.map((item) => RincianPesanan(item: item)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
