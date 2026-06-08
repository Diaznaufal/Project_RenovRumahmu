import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Keranjang/Pages/Keranjang_Page.dart';
import 'package:flutter_application_1/Features/Material/Widgets/Product_Card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../Widgets/Category_Row.dart';
import '../Models/product_model.dart';
import '../Provider/Product_provider.dart';

class PageMaterial extends StatefulWidget {
  @override
  State<PageMaterial> createState() => _PageMaterialState();
}

class _PageMaterialState extends State<PageMaterial> {
  int selectedIndex = 0;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductProvider>().loadProducts();
    });
  }

  List<String> get categories {
    final productProvider = context.watch<ProductProvider>();

    final allCategories = productProvider.products
        .map((product) => product.category)
        .toSet()
        .toList();

    return ["All", ...allCategories];
  }

  String get selectedCategory => categories[selectedIndex];

  List<ProductModel> get filteredProducts {
    final productProvider = context.watch<ProductProvider>();

    return productProvider.products.where((product) {
      final matchCategory =
          selectedCategory == "All" || product.category == selectedCategory;

      final matchSearch = product.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );

      return matchCategory && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black87,
        titleSpacing: 15,
        automaticallyImplyLeading: false,
        toolbarHeight: 105,
        title: Column(
          children: [
            Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  splashRadius: 10,
                  onPressed: () => Navigator.pop(context),
                  icon: Transform.translate(
                    offset: Offset(-9, 0),
                    child: Icon(Icons.arrow_back, size: 24),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xffEBEEF3),
                      border: Border.all(color: Color(0xE1C1C3C7), width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: "Inria Sans",
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Cari material",
                        hintStyle: TextStyle(
                          color: Color(0xE0B0B2B6),
                          fontFamily: "Inria Sans",
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xE0B0B2B6),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 28),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KeranjangPage()),
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/icon/shop_bag.svg",
                    width: 26,
                    height: 26,
                    colorFilter: ColorFilter.mode(
                      Color(0xffFFC107),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(categories.length, (index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: CategoryRow(
                              title: categories[index],
                              isActive: selectedIndex == index,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: productProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ProductCard(products: filteredProducts),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
