import 'package:flutter/material.dart';
import '../../Keranjang/Provider/Cart_Provider.dart';
import '../Provider/Product_provider.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../Models/product_model.dart';
import 'Add_ToCart.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
  decimalDigits: 0,
);

class ProductCard extends StatelessWidget {
  final List<ProductModel>? products;

  const ProductCard({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider?>(
      context,
      listen: true,
    );

    final data = products ?? productProvider?.products ?? [];

    final isLoading = productProvider?.isLoading ?? false;

    /// LOADING
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    /// EMPTY
    if (data.isEmpty) {
      return Center(child: Text("Produk kosong"));
    }

    return GridView.builder(
      padding: EdgeInsets.all(8),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ProductItemCard(product: data[index]);
      },
    );
  }
}

class ProductItemCard extends StatelessWidget {
  final ProductModel product;

  const ProductItemCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final selectedSize =
        context.select<CartProvider, String?>(
          (cart) => cart.getSelectedSize(product.name),
        ) ??
        product.size.first;

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
          /// IMAGE
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
                        "${product.discount}%",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Inria Sans",
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          /// DETAIL
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    spacing: 4,
                    children: [
                      if (product.isBestSeller)
                        buildBadge("Best Seller", Colors.green),
                      if (product.isDiscount)
                        buildBadge("Discount", Color(0xffE60032)),
                    ],
                  ),

                  Wrap(
                    spacing: 4,
                    children: product.size.map((size) {
                      final isSelected = selectedSize == size;

                      return GestureDetector(
                        onTap: () {
                          context.read<CartProvider>().setSelectedSize(
                            product.name,
                            size,
                          );
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
                              fontFamily: "Inria Sans",
                              color: isSelected
                                  ? Colors.white
                                  : Color(0xff808080),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inria Sans",
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          /// HARGA FINAL
                          Text(
                            formatRupiah.format(product.finalPrice),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inria Sans",
                              color: Color(0xff226889),
                            ),
                          ),

                          SizedBox(width: 6),

                          /// HARGA CORET
                          if (product.discount != null)
                            Text(
                              formatRupiah.format(product.price),
                              style: TextStyle(
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough,
                                fontFamily: "Inria Sans",
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),

                      Container(
                        height: 22,
                        width: 22,

                        decoration: BoxDecoration(
                          color: Color(0xff226889),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: InkWell(
                          onTap: () {
                            showMaterialModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) =>
                                  AddToCartModal(product: product),
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
        fontFamily: "Inria Sans",
        fontSize: 7,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
