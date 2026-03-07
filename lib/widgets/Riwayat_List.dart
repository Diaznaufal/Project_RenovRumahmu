import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Detailpesanan_Page.dart';
import 'package:flutter_application_1/Provider/Riwayat_Provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../models/Riwayat_Model.dart';
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

Color getStatusColor(OrderStatuss status) {
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

String getStatusLabel(OrderStatuss status) {
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

List<Widget> _buildActionButtons(BuildContext context, RiwayatModel item) {
  switch (item.status) {
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
        _buildSecondaryButton("Lacak Pengiriman", onPressed: () {}),
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
        child: Text("Belum ada riwayat", style: TextStyle(fontSize: 16)),
      );
    }

    return ListView.builder(
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final item = filteredData[index];
        final products = item.items ?? [];

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
                  /// ===== HEADER =====
                  Row(
                    children: [
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: getServiceColor(item.type).withAlpha(90),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: SvgPicture.asset(
                            getServiceIconPath(item.type),
                            colorFilter: ColorFilter.mode(
                              getServiceColor(item.type),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColor(item.status),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          getStatusLabel(item.status),
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),

                      SizedBox(width: 10),

                      Text(
                        DateFormat('dd MMM yyyy').format(item.date),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  /// ===== BODY =====
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),

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
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          Text(
                                            "x${cartItem.quantity}",
                                            style: TextStyle(fontSize: 10),
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
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                            ],

                            if (item.type == OrderType.renovasi &&
                                item.progress != null)
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  "Progress: ${item.progress}%",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      SizedBox(width: 10),

                      if (item.type == OrderType.material &&
                          products.isNotEmpty)
                        Container(
                          height: 65,
                          width: 65,
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
                    ],
                  ),
                  SizedBox(height: 5),

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
                            fontSize: 12,
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
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),

                  SizedBox(height: 5),

                  /// ===== BUTTON =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _buildActionButtons(context, item),
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
    child: Text(text, style: TextStyle(fontSize: 10)),
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
    child: Text(text, style: TextStyle(fontSize: 10)),
  );
}
