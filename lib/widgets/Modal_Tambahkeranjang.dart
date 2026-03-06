import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:provider/provider.dart';
import '../Provider/Cart_Provider.dart';
import 'package:intl/intl.dart';

final formatRupiah = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp',
  decimalDigits: 0,
);

class AddToCartModal extends StatefulWidget {
  final ProductModel product;

  const AddToCartModal({super.key, required this.product});

  @override
  State<AddToCartModal> createState() => _AddToCartModalState();
}

class _AddToCartModalState extends State<AddToCartModal> {
  int quantity = 1;

  @override
  void initState() {
    super.initState();

    //
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cart = context.read<CartProvider>();
      final existing = cart.getSelectedSize(widget.product.name);

      if (existing == null) {
        cart.setSelectedSize(widget.product.name, widget.product.size.first);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    //
    final selectedSize =
        cart.getSelectedSize(widget.product.name) ?? widget.product.size.first;

    return Material(
      color: Colors.transparent,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            widget.product.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.product.discount != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  widget.product.discount!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            SizedBox(height: 6),
                            Text(
                              widget.product.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  formatRupiah.format(widget.product.price),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff226889),
                                  ),
                                ),
                                SizedBox(width: 6),
                                if (widget.product.oldPrice != null)
                                  Text(
                                    formatRupiah.format(
                                      widget.product.oldPrice,
                                    ),
                                    style: TextStyle(
                                      fontSize: 11,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    /// SIZE
                    Wrap(
                      spacing: 4,
                      children: widget.product.size.map((size) {
                        final isSelected = selectedSize == size;

                        return GestureDetector(
                          onTap: () {
                            cart.setSelectedSize(widget.product.name, size);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
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
                                fontSize: 12,
                                color: isSelected
                                    ? Colors.white
                                    : Color(0xff808080),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    /// QTY
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Color(0xff0369C8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              if (quantity > 1) setState(() => quantity--);
                            },
                            icon: Icon(
                              Icons.remove,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Color(0xff0369C8),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              setState(() => quantity++);
                            },
                            icon: Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff0369C8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          for (int i = 0; i < quantity; i++) {
                            cart.addToCart(
                              product: widget.product,
                              selectedSize: selectedSize,
                            );
                          }
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Tambahkan ke Keranjang",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
