import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Keranjang_Page.dart';
import 'package:flutter_application_1/widgets/Product_Card.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/Category_Row.dart';

class PageMaterial extends StatefulWidget {
  @override
  State<PageMaterial> createState() => _PageMaterialState();
}

class _PageMaterialState extends State<PageMaterial> {
  int selectedIndex = 0;
  String searchQuery = '';

  final List<String> categories = [
    "All",
    "Semen",
    "Cat",
    "Keramik",
    "Pasir",
    "Pintu",
    "Batu",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black.withAlpha(77),
        titleSpacing: 15,
        automaticallyImplyLeading: false,
        toolbarHeight: 110,
        title: Column(
          children: [
            Row(
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  splashRadius: 20,
                  onPressed: () => Navigator.pop(context),
                  icon: Transform.translate(
                    offset: Offset(-9, 0),
                    child: Icon(Icons.arrow_back, size: 24),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xffEBEEF3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "Cari material",
                          hintStyle: TextStyle(
                            color: Color(0xffBDC4C8),
                            fontSize: 14,
                          ),

                          prefixIcon: Icon(
                            Icons.search,
                            size: 18,
                            color: Color(0xffBDC4C8),
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 40,
                            minHeight: 28,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0,
                          ),

                          border: InputBorder.none,
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
                      Color(0xFFFFC107),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
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
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              setState(() => selectedIndex = index);
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

                SizedBox(width: 8),

                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(26),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      "assets/icon/sort_outline.svg",
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Expanded(child: ProductCard()),
            ],
          ),
        ),
      ),
    );
  }
}
