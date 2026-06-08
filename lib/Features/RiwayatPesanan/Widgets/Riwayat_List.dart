import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/DetailPesanan/Pages/Detailpesanan2_page.dart';
import 'package:flutter_application_1/Features/DetailPesanan/Pages/Detailpesanan_Page.dart';
import 'package:flutter_application_1/Features/StatusPesanan/Renovasi/Pages/Status_Proyek.dart';
import 'package:flutter_application_1/Features/RiwayatPesanan/Provider/Riwayat_Provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../Models/Riwayat_Model.dart';
import 'package:provider/provider.dart';

String getServiceIconPath(OrderType type) {
  switch (type) {
    case OrderType.material:
      return "assets/icon/shop_bag.svg";
    case OrderType.renovasi:
      return "assets/icon/solid_tools.svg";
    case OrderType.bangunBaru:
      return "assets/icon/House.svg";
    case OrderType.perawatan:
      return "assets/icon/Broom.svg";
  }
}

Color getServiceColor(OrderType type) {
  switch (type) {
    case OrderType.material:
      return Color(0xFFFFC107);
    case OrderType.renovasi:
      return Color(0xFF2E9B4F);
    case OrderType.bangunBaru:
      return Color(0xFF1C87EB);
    case OrderType.perawatan:
      return Color(0xFFF29900);
  }
}

Color getStatusMaterialColor(OrderStatuss status) {
  switch (status) {
    case OrderStatuss.disiapkan:
      return Color(0xff3B82F6);
    case OrderStatuss.dikirim:
      return Color(0xff3B82F6);
    case OrderStatuss.menunggupembayaran:
      return Color(0xffF59E0B);
    case OrderStatuss.dibatalkan:
      return Color(0xFFF53A0B);
    case OrderStatuss.selesai:
      return Color(0xff009236);
  }
}

String getStatusLabelMaterial(OrderStatuss status) {
  switch (status) {
    case OrderStatuss.disiapkan:
      return "Dibuat";
    case OrderStatuss.dikirim:
      return "Dikirim";
    case OrderStatuss.selesai:
      return "Selesai";
    case OrderStatuss.dibatalkan:
      return "Dibatalkan";
    case OrderStatuss.menunggupembayaran:
      return "Menunggu Pembayaran";
  }
}

String getStatusLabelRenovasi(RenovasiStatus status) {
  switch (status) {
    case RenovasiStatus.menunggupembayaran:
      return "Menunggu pembayaran";
    case RenovasiStatus.survey:
      return "Survey";
    case RenovasiStatus.berjalan:
      return "Berjalan";
    case RenovasiStatus.selesai:
      return "Selesai";
  }
}

Color getStatusRenovasiColor(RenovasiStatus status) {
  switch (status) {
    case RenovasiStatus.menunggupembayaran:
      return Color(0xffF59E0B);
    case RenovasiStatus.survey:
      return Color(0xff3B82F6);
    case RenovasiStatus.berjalan:
      return Color(0xff3B82F6);
    case RenovasiStatus.selesai:
      return Color(0xff009236);
  }
}

List<Widget> _buildMaterialButtons(BuildContext context, RiwayatModel item) {
  final status = item.orderStatuss;

  if (status == null) {
    return [];
  }

  switch (status) {
    case OrderStatuss.menunggupembayaran:
      return [
        _buildSecondaryButton("Bayar Sekarang", onPressed: () {}),

        SizedBox(width: 8),

        _buildPrimaryButton(
          "Detail",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailpesananPage(order: item),
              ),
            );
          },
        ),
      ];

    case OrderStatuss.disiapkan:
      return [
        _buildPrimaryButton(
          "Detail",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailpesananPage(order: item),
              ),
            );
          },
        ),
      ];

    case OrderStatuss.dikirim:
      return [
        _buildSecondaryButton(
          "Lacak Pengiriman",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Detailpesanan2Page(order: item),
              ),
            );
          },
        ),

        SizedBox(width: 8),

        _buildPrimaryButton(
          "Detail",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailpesananPage(order: item),
              ),
            );
          },
        ),
      ];

    case OrderStatuss.selesai:
      return [
        _buildPrimaryButton(
          "Detail",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailpesananPage(order: item),
              ),
            );
          },
        ),
      ];

    case OrderStatuss.dibatalkan:
      return [
        _buildSecondaryButton("Beli Lagi", onPressed: () {}),

        SizedBox(width: 8),

        _buildPrimaryButton(
          "Detail",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailpesananPage(order: item),
              ),
            );
          },
        ),
      ];
  }
}

List<Widget> _buildRenovasiButton(BuildContext context, RiwayatModel item) {
  final status = item.renovasiStatus;

  if (status == null) {
    return [];
  }

  switch (status) {
    case RenovasiStatus.menunggupembayaran:
      return [
        _buildPrimaryButton(
          "Lanjutkan Pembayaran",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatusProyek(order: item),
              ),
            );
          },
        ),
      ];
    case RenovasiStatus.survey:
      return [_buildPrimaryButton("Lanjutkan Pembayaran", onPressed: () {})];

    case RenovasiStatus.berjalan:
      return [
        _buildPrimaryButton(
          "Lihat Progres",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatusProyek(order: item),
              ),
            );
          },
        ),
      ];

    case RenovasiStatus.selesai:
      return [
        _buildPrimaryButton(
          "Detail",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatusProyek(order: item),
              ),
            );
          },
        ),
      ];
  }
}

class RiwayatList extends StatelessWidget {
  final OrderType? type;

  const RiwayatList({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    final riwayatProvider = Provider.of<RiwayatProvider>(context);
    final List<RiwayatModel> allData = riwayatProvider.riwayat;

    final filteredData = type == null
        ? allData
        : allData.where((item) => item.type == type).toList();

    if (filteredData.isEmpty) {
      return Center(
        child: Text(
          "Belum ada riwayat",
          style: TextStyle(fontSize: 16, fontFamily: "Inria Sans"),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final item = filteredData[index];
        final products = item.items ?? [];

        print("IMAGE RENOVASI: ${item.imagePath}");

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
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
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ===== TOP SECTION =====
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// ===== HEADER =====
                            Row(
                              children: [
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: getServiceColor(
                                      item.type,
                                    ).withAlpha(90),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: SvgPicture.asset(
                                      getServiceIconPath(item.type),
                                      colorFilter: ColorFilter.mode(
                                        getServiceColor(item.type),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 8),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: item.type == OrderType.renovasi
                                        ? getStatusRenovasiColor(
                                            item.renovasiStatus!,
                                          )
                                        : getStatusMaterialColor(
                                            item.orderStatuss!,
                                          ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    item.type == OrderType.renovasi
                                        ? getStatusLabelRenovasi(
                                            item.renovasiStatus!,
                                          )
                                        : getStatusLabelMaterial(
                                            item.orderStatuss!,
                                          ),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "Inria Sans",
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 10),

                                Text(
                                  DateFormat('dd MMM yyyy').format(item.date),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontFamily: "Inria Sans",
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 10),

                            /// ===== TITLE =====
                            Text(
                              item.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: "Inria Sans",
                              ),
                            ),

                            /// ===== MATERIAL =====
                            if (item.type == OrderType.material) ...[
                              ...products
                                  .take(2)
                                  .map(
                                    (cartItem) => Padding(
                                      padding: EdgeInsets.only(right: 80),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            cartItem.product.name,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Inria Sans",
                                            ),
                                          ),

                                          Text(
                                            "x${cartItem.quantity}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Inria Sans",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                              if (products.length > 2)
                                Padding(
                                  padding: EdgeInsets.only(right: 80),
                                  child: Text(
                                    "${products.length - 2} item lainnya",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Inria Sans",
                                    ),
                                  ),
                                ),
                            ],

                            /// ===== RENOVASI =====
                            if (item.type == OrderType.renovasi &&
                                item.progress != null)
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info,
                                      size: 18,
                                      color: Color(0xff6D6D6D),
                                    ),

                                    SizedBox(width: 5),

                                    Text(
                                      "Tahap : ${item.tahap ?? '-'}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        fontFamily: "Inria Sans",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),

                      SizedBox(width: 10),

                      /// ===== IMAGE MATERIAL =====
                      if (item.type == OrderType.material &&
                          products.isNotEmpty)
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              products.first.product.imageUrl,
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                      /// ===== IMAGE RENOVASI =====
                      if (item.type == OrderType.renovasi &&
                          item.imagePath != null)
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(item.imagePath!.first),
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 1),

                  /// ===== TOTAL =====
                  if (item.type == OrderType.material &&
                      item.totalPrice != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Pesanan",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inria Sans",
                            fontSize: 14,
                          ),
                        ),

                        Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp',
                            decimalDigits: 0,
                          ).format(item.totalPrice),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inria Sans",
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                  /// ===== PROGRESS RENOVASI =====
                  if (item.type == OrderType.renovasi && item.progress != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: "Inria Sans",
                                ),
                              ),

                              Text(
                                "${((item.progress ?? 0) * 100).toInt()}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: "Inria Sans",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 5),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: (item.progress ?? 0).toDouble(),
                              minHeight: 6,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff045097),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 5),

                  /// ===== BUTTON =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: item.type == OrderType.renovasi
                        ? _buildRenovasiButton(context, item)
                        : _buildMaterialButtons(context, item),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildPrimaryButton(String text, {required VoidCallback onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      minimumSize: Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: Color(0xff045097),
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    onPressed: onPressed,
    child: Text(text, style: TextStyle(fontSize: 12, fontFamily: "Inria Sans")),
  );
}

Widget _buildSecondaryButton(String text, {required VoidCallback onPressed}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      minimumSize: Size(0, 0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(color: Color(0xff045097)),
      foregroundColor: Color(0xff045097),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    onPressed: onPressed,
    child: Text(text, style: TextStyle(fontSize: 12, fontFamily: "Inria Sans")),
  );
}
