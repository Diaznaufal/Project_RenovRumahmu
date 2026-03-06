import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/Product_material.dart';
import 'package:flutter_application_1/Provider/Cart_Provider.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import 'Modal_Tambahkeranjang.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp ',
  decimalDigits: 0,
);

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      itemCount: productList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ProductItemCard(product: productList[index]);
      },
    );
  }
}

class ProductItemCard extends StatelessWidget {
  final ProductModel product;

  const ProductItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    final selectedSize =
        cart.getSelectedSize(product.name) ?? product.size.first;

    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //IMAGE
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(
                    product.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (product.discount != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(0xffE60032),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        product.discount!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          //DETAIL
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //BADGES
                  Wrap(
                    spacing: 4,
                    children: [
                      if (product.isBestSeller)
                        buildBadge("Best Seller", Colors.green),
                      if (product.isDiscount)
                        buildBadge("Discount", Color(0xffE60032)),
                    ],
                  ),

                  // SIZE
                  Wrap(
                    spacing: 4,
                    children: product.size.map((size) {
                      final isSelected = selectedSize == size;

                      return GestureDetector(
                        onTap: () {
                          cart.setSelectedSize(product.name, size);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color(0xff808080)
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              fontSize: 9,
                              color: isSelected
                                  ? Colors.white
                                  : Color(0xff808080),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  /// NAME
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                  ),

                  /// PRICE + ADD BUTTON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            formatRupiah.format(product.price),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff226889),
                            ),
                          ),
                          if (product.oldPrice != null)
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Text(
                                formatRupiah.format(product.oldPrice),
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                        ],
                      ),

                      //ADD BUTTON
                      Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                          color: Color(0xff226889),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: () {
                            showMaterialModalBottomSheet(
                              context: context,
                              expand: false,
                              backgroundColor: Colors.transparent,
                              builder: (_) => AddToCartModal(product: product),
                            );
                          },
                          child: Icon(Icons.add, color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 7,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
