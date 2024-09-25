import 'package:flutter/material.dart';
import 'categories.dart';
import 'notification.dart';
import 'carousel.dart';
import 'medical_centers.dart';
import 'doctor_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Removed unnecessary const
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LocationWidget(),
                NotificationWidget(),
              ],
            ),
            SizedBox(height: 16),
            MySearchBar(),
            SizedBox(height: 10),
            Container(
              height: 163,
              child: CarouselWidget(),
            ),
            SizedBox(height: 7),
            CategoriesWidget(),
            const SizedBox(height: 20),
            MedicalCenterWidget(),
            const SizedBox(height: 20),
            DoctorListWidget(),
          ],
        ),
      ),
    );
  }
}
