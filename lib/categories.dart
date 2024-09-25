import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesWidget extends StatefulWidget {
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  List<dynamic> categories = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final String response =
          await rootBundle.loadString('assets/categories.json');
      final data = json.decode(response);
      setState(() {
        categories = data['categoriesItems'] ??
            []; // Fallback if categoriesItems is null
      });
    } catch (e) {
      print("Error loading categories: $e");
      // Handle error, possibly display an error message or use a fallback dataset
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 5),
            Text(
              'Categories',
              style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C2A3A)),
            ),
            Spacer(),
            Text(
              'See All',
              style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
            SizedBox(
              width: 5,
            )
          ],
        ),
        const SizedBox(height: 8.0),
        LayoutBuilder(
          builder: (context, constraints) {
            // Calculează lățimea fiecărui item (4 elemente cu spacing inclus)
            double itemWidth = (constraints.maxWidth - 3 * 16.0) / 4;

            return Wrap(
              spacing: 16.0, // Spațiul dintre elemente pe orizontală
              runSpacing: 16.0, // Spațiul dintre rânduri
              children: categories.map((category) {
                final String name = category['name'];
                final String image = category['image'];
                final String color = category['color'];

                return SizedBox(
                  width: itemWidth, // Fiecare element are lățimea fixată
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(int.parse(color)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Center(
                              child: SvgPicture.asset(
                                image,
                                width: 35,
                                height: 35,
                              ),
                            ),
                            Positioned(
                              top: -35,
                              left: -35,
                              child: Container(
                                width: 68,
                                height: 68,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFFFFFFF).withOpacity(0.2)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4B5563)),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
