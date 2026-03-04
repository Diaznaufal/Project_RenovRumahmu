import 'package:flutter/material.dart';
import '../Provider/Addres_Provider.dart';
import 'package:provider/provider.dart';

class AlamatUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final address = context.watch<AddressProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_pin, size: 15, color: Color(0xff045097)),
            SizedBox(width: 4),
            Text(
              address.selectedAddress?.name ?? "",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff045097),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          address.selectedAddress?.phone ?? "",
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(height: 5),
        Text(
          address.selectedAddress?.fullAddress ?? "",
          style: TextStyle(fontSize: 12),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
