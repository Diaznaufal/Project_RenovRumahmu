import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Detailpesanan2_page.dart';
import 'package:flutter_svg/svg.dart';
import '../models/Riwayat_Model.dart';

class StatusOrder extends StatelessWidget {
  final OrderStatuss order;

  const StatusOrder({super.key, required this.order});

  String getStatusText() {
    switch (order) {
      case OrderStatuss.menunggupembayaran:
        return "Menunggu Pembayaran";
      case OrderStatuss.disiapkan:
        return "Pesanan Disiapkan";
      case OrderStatuss.dikirim:
        return "Pesanan Dikirim";
      case OrderStatuss.selesai:
        return "Pesanan Selesai";
      case OrderStatuss.dibatalkan:
        return "Pesanan Dibatalkan";
    }
  }

  List<Widget> _buildActionButtons(BuildContext context) {
    switch (order) {
      case OrderStatuss.menunggupembayaran:
        return [_buildPrimaryButton("Bayar Sekarang", onPressed: () {})];
      case OrderStatuss.disiapkan:
      case OrderStatuss.dikirim:
      case OrderStatuss.selesai:
        return [
          _buildPrimaryButton(
            "Lacak Pengiriman",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Detailpesanan2Page()),
              );
            },
          ),
        ];
      case OrderStatuss.dibatalkan:
        return [_buildPrimaryButton("Beli Lagi", onPressed: () {})];
    }
  }

  String getIcon() {
    switch (order) {
      case OrderStatuss.menunggupembayaran:
        return "assets/icon/E-Wallet.svg";
      case OrderStatuss.disiapkan:
        return "assets/icon/Box.svg";
      case OrderStatuss.dikirim:
        return "assets/icon/Kurir.svg";
      case OrderStatuss.selesai:
        return "assets/icon/Check.svg";
      case OrderStatuss.dibatalkan:
        return "assets/icon/shop_bag.svg";
    }
  }

  Color getColor() {
    switch (order) {
      case OrderStatuss.menunggupembayaran:
        return Colors.blue;
      case OrderStatuss.disiapkan:
        return Colors.orange;
      case OrderStatuss.dikirim:
        return Colors.green;
      case OrderStatuss.selesai:
        return Colors.grey;
      case OrderStatuss.dibatalkan:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(30), blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          Row(children: [Text("Order Id: "), Text("SN-01-0000012")]),
          SizedBox(height: 8),
          Row(
            children: [
              SvgPicture.asset(
                getIcon(),
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  Color(0xff045097),
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getStatusText()),
                  Text(
                    "20 Feb 2026, 14:00 - Pesanan dikirim dari gudang",
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _buildActionButtons(context),
          ),
        ],
      ),
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
    child: Text(text, style: TextStyle(fontSize: 12)),
  );
}
