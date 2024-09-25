import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For loading asset files
import 'package:flutter_svg/flutter_svg.dart';

class DoctorListWidget extends StatefulWidget {
  @override
  _DoctorListWidgetState createState() => _DoctorListWidgetState();
}

class _DoctorListWidgetState extends State<DoctorListWidget> {
  late Future<List<dynamic>> _doctors;

  @override
  void initState() {
    super.initState();
    _doctors = loadDoctors();
  }

  Future<List<dynamic>> loadDoctors() async {
    final String response = await rootBundle.loadString('assets/doctors.json');
    final data = await json.decode(response);
    return data['doctors'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _doctors,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Adjust as needed
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading data'));
        } else {
          final doctors = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Text(
                    '${doctors.length} found', // Dynamic count
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    'Default',
                    style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    'assets/images/arrow.svg',
                    width: 14,
                    height: 14,
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Doctor List
              // Container(
              //    height: 500,
              //   child:
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                //shrinkWrap: true,
                itemCount: 5000,
                itemBuilder: (context, index) {
                  return buildDoctorCard(doctors[1]);
                },
              )
              //)
            ],
          );
        }
      },
    );
  }

  Widget buildDoctorCard(dynamic doctor) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 8.0), // Space between cards
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor's image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  doctor['image'],
                  height: 109,
                  width: 109,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Display a placeholder if the image fails to load
                    return Container(
                      height: 109,
                      width: 109,
                      color: Colors.grey[300],
                      child: Icon(Icons.error, color: Colors.red),
                    );
                  },
                ),
              ),
              SizedBox(width: 10), // Space between image and column
              // Wrap the Column in Expanded
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Heart Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          doctor['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2A37),
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/images/heart.svg',
                          width: 16,
                          height: 16,
                          semanticsLabel: 'Favorite',
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color(0xFFE5E7EB),
                      thickness: 1,
                    ),
                    // Specialization
                    Text(
                      doctor['specialization'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                    // Location
                    SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/location-pin-rev.svg',
                          width: 16,
                          height: 16,
                          semanticsLabel: 'Location',
                        ),
                        SizedBox(width: 4),
                        Text(
                          doctor['location'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    // Ratings and Reviews
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/FullStar.svg',
                          width: 12,
                          height: 12,
                          semanticsLabel: 'Rating',
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${doctor['rating']}',
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        // Container with fixed height to ensure the vertical divider is visible
                        const SizedBox(
                          height: 16, // Adjust the height as needed
                          child: VerticalDivider(
                            color: Color(0xFF6B7280), // Color of the divider
                            thickness: 1, // Thickness of the divider
                            width: 20, // Space around the divider
                          ),
                        ),
                        Text(
                          ' (${doctor['reviews']} Reviews)',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
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
