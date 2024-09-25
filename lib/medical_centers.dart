import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For loading asset files
import 'categories.dart';
import 'notification.dart';
import 'carousel.dart';
import 'medical_centers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MedicalCenterWidget extends StatefulWidget {
  @override
  _MedicalCenterWidgetState createState() => _MedicalCenterWidgetState();
}

class _MedicalCenterWidgetState extends State<MedicalCenterWidget> {
  late Future<List<dynamic>> _medicalCenters;

  @override
  void initState() {
    super.initState();
    _medicalCenters = loadMedicalCenters();
  }

  Future<List<dynamic>> loadMedicalCenters() async {
    final String response =
        await rootBundle.loadString('assets/medical_center.json');
    final data = await json.decode(response);
    return data['medicalCenters'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _medicalCenters,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data'));
        } else {
          final centers = snapshot.data!;
          return Column(children: [
            const Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Nearby Medical Centers',
                  style: TextStyle(
                      color: Color(0xFF1C2A3A),
                      fontSize: 16.0,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700),
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
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 290,
              child: ListView.builder(
                itemCount: centers.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final center = centers[index];
                  return buildCenterCard(center);
                },
              ),
            )
          ]);
        }
      },
    );
  }

  Widget buildCenterCard(dynamic center) {
    return Container(
      width: 250,
      // height: 700,
      margin: const EdgeInsets.only(right: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage(
                      center['image']), // Poți să schimbi cu imaginea ta
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    center['name'],
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/location-pin-rev.svg',
                        width: 17,
                        height: 17,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        center['address'],
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF6B7280)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Text(
                        '${center['rating'].toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 5),
                      RatingBarIndicator(
                        rating: center[
                            'rating'], // Replace this with your rating data
                        // In your widget
                        itemBuilder: (context, index) => SvgPicture.asset(
                          'assets/images/FullStar.svg',
                          width: 16,
                          height: 16,
                        ),
                        itemCount: 5, // Number of stars in total
                        itemSize: 13.0, // Size of the star icon
                        direction: Axis.horizontal,
                      ),
                      SizedBox(width: 5),
                      Text(
                        '(${center['reviews']} Reviews)',
                        style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  const Divider(
                    color: Color(
                        0xFFE5E7EB), // Color of the line (you can match this to your desired color)
                    thickness: 2, // Thickness of the line
                    // indent: 16, // Left padding (optional)
                    // endIndent: 16, // Right padding (optional)
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      //pading
                      SvgPicture.asset(
                        'assets/images/routing.svg',
                        width: 16,
                        height: 16,
                      ),
                      Text(
                        '${center['distance']}/${center['time']}',
                        style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        'assets/images/hospital.svg',
                        width: 16,
                        height: 16,
                      ),
                      Text(
                        center['type'],
                        style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            )

            //  SizedBox(height: 5),
          ],
        ),
      ),
      //   ),
    );
  }
}
