import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Alamat_Page.dart';
import 'package:provider/provider.dart';
import '../Provider/Addres_Provider.dart';

class AlamatPengiriman extends StatelessWidget {
  const AlamatPengiriman({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlamatPage()),
        );
      },
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Consumer<AddressProvider>(
                builder: (context, addressProvider, _) {
                  final address = addressProvider.selectedAddress;

                  if (address == null) {
                    return Row(
                      children: [
                        Icon(Icons.location_pin, size: 18),
                        SizedBox(width: 8),
                        Text(
                          "Tambah Alamat Pengiriman",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_pin, size: 15),
                          SizedBox(width: 5),
                          Text(
                            address.name.isNotEmpty
                                ? address.name[0].toUpperCase() +
                                      address.name.substring(1)
                                : "",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff045097),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        address.phone,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        address.fullAddress,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
            ),

            // 🔹 Arrow kanan
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(Icons.arrow_forward_ios, size: 15),
            ),
          ],
        ),
      ),
    );
  }
}
