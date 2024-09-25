import 'dart:convert'; // For JSON decoding
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For loading asset files
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // For dot indicators

class CarouselWidget extends StatefulWidget {
  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final PageController _pageController = PageController();
  // int _currentIndex = 0;
  List<dynamic> carouselData = [];

  @override
  void initState() {
    super.initState();
    loadCarouselData(); // Load JSON data
  }

  Future<void> loadCarouselData() async {
    final String response =
        await rootBundle.loadString('assets/carousel_data.json');
    final data = await json.decode(response);
    setState(() {
      carouselData = data['carouselItems'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return carouselData.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: [
              // Carousel container inside a PageView
              PageView.builder(
                controller: _pageController,
                itemCount: carouselData.length,
                onPageChanged: (index) {
                  setState(() {
                    //   _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = carouselData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0), // Add spacing between items
                    child: CarouselCard(
                      image: item['image'],
                      title: item['title'],
                      description: item['description'],
                    ),
                  );
                },
              ),

              Positioned(
                bottom: 24,
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: carouselData.length,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.white,
                      dotColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

class CarouselCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  CarouselCard({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 0),
      child: Container(
        width: double.infinity,
        //height: 20,
        decoration: BoxDecoration(
          color: Colors.blueGrey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 180,
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Positioned white circle
              Positioned(
                top: -50, // Adjust the positioning as needed
                left: -30,
                child: Container(
                  width: 154, // Width of the circle
                  height: 154, // Height of the circle
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFFFFF).withOpacity(0.2)),
                ),
              ),
              Positioned(
                top: 205, // Adjust the positioning as needed
                left: 90,
                child: Container(
                  width: 83, // Width of the circle
                  height: 83, // Height of the circle
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFFFFF).withOpacity(0.2)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
