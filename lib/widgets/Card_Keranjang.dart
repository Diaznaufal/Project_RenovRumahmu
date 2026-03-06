import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/Cart_Provider.dart';
import '../models/product_cart.dart';
import 'package:intl/intl.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
  decimalDigits: 0,
);

class CardKeranjang extends StatelessWidget {
  final CartItemModel item;
  final String itemKey;

  const CardKeranjang({Key? key, required this.item, required this.itemKey})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Dismissible(
        key: Key(itemKey),
        direction: DismissDirection.endToStart,
        background: Container(
          padding: EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.delete, color: Colors.white),
        ),
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              contentPadding: EdgeInsets.fromLTRB(20, 12, 20, 0),
              actionsPadding: EdgeInsets.fromLTRB(20, 8, 20, 16),
              title: Text(
                "Hapus Produk?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              content: Text(
                "Apakah kamu yakin ingin menghapus item ini dari keranjang?",
                style: TextStyle(fontSize: 12),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    minimumSize: Size(0, 36),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: Text(
                    "Batal",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    minimumSize: Size(0, 36),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text(
                    "Hapus",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
        onDismissed: (direction) {
          context.read<CartProvider>().removeItem(itemKey);
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(77),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 6, right: 8, bottom: 8, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 0.7,
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    side: BorderSide(width: 0.8),
                    value: item.isSelected,
                    onChanged: (value) {
                      context.read<CartProvider>().toggleItemSelection(
                        item,
                        value ?? false,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item.product.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.product.name,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),

                            /// SIZE
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xff808080),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.selectedSize,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ),

                            Wrap(
                              spacing: 6,
                              children: [
                                if (item.product.isBestSeller)
                                  buildBadge("Best Seller", Colors.green),
                                if (item.product.isDiscount)
                                  buildBadge("Discount", Colors.red),
                              ],
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  formatRupiah.format(item.totalPrice),
                                  style: TextStyle(
                                    color: Color(0xff226889),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (item.product.oldPrice != null)
                                  Text(
                                    formatRupiah.format(item.product.oldPrice),
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.grey,
                                      decorationThickness: 2,
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 4),
                          ],
                        ),
                      ),

                      /// QTY CONTROL
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  color: Color(0xff226889),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft: Radius.circular(4),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<CartProvider>().decreaseQty(
                                      item,
                                    );
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                children: [
                                  Text(
                                    item.quantity.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 2,
                                    color: Colors.grey,
                                    margin: EdgeInsets.only(top: 1),
                                  ),
                                ],
                              ),
                              SizedBox(width: 8),
                              Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  color: Color(0xff226889),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<CartProvider>().increaseQty(
                                      item,
                                    );
                                  },
                                  child: Icon(
                                    Icons.add,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
