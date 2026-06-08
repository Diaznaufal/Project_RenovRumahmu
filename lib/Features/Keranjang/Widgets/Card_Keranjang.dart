import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Material/Models/product_model.dart';
import 'package:provider/provider.dart';
import '../Provider/Cart_Provider.dart';
import '../Models/cart_item_model.dart';
import 'package:intl/intl.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
  decimalDigits: 0,
);

class CardKeranjang extends StatelessWidget {
  final CartItemModel item;
  final String itemKey;
  final ProductModel product;

  const CardKeranjang({
    Key? key,
    required this.item,
    required this.itemKey,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  activeColor: Color(0xff0369C8),
                  value: item.isSelected,
                  onChanged: (value) {
                    context.read<CartProvider>().toggleItemSelection(
                      itemKey,
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
                              fontFamily: "Inria Sans",
                            ),
                          ),

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
                                fontFamily: "Inria Sans",
                                fontSize: 8,
                              ),
                            ),
                          ),

                          Wrap(
                            children: [
                              if (item.product.isDiscount)
                                buildBadge(
                                  "Diskon ${(product.discount.toString())}%",
                                  Colors.red,
                                ),
                            ],
                          ),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formatRupiah.format(product.finalPrice),
                                style: TextStyle(
                                  color: Color(0xff226889),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inria Sans",
                                ),
                              ),
                              Text(
                                formatRupiah.format(item.product.price),
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inria Sans",
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
                                  context.read<CartProvider>().decreaseQuantity(
                                    itemKey, // ✅ FIX
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
                                    fontFamily: "Inria Sans",
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
                                  context.read<CartProvider>().increaseQuantity(
                                    itemKey, // ✅ FIX
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
        fontFamily: "Inria Sans",
      ),
    ),
  );
}
