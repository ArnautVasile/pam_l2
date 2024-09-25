import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.only(left: 0),
        child: Text(
          "Location",
          style: TextStyle(
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w400,
              fontFamily: "Inter"),
        ),
      ),
      Row(
        children: [
          SvgPicture.asset(
            'assets/images/location-pin.svg',
            width: 24,
            height: 24,
          ),
          // constIcon(Icons.location_on, color: Colors.black),
          const SizedBox(width: 8),
          const Text(
            "Seattle, USA",
            style: TextStyle(
                color: Color(0xFF374151),
                fontWeight: FontWeight.w600,
                fontFamily: "Inter"),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Color(0xFF374151))
        ],
      )
    ]);
  }
}

class NotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(30),
      ),
      constraints: const BoxConstraints(
        minWidth: 35, // Inner circle size
        minHeight: 35,
      ),
      child: Stack(alignment: Alignment.center, children: [
        SvgPicture.asset(
          'assets/images/notification-bing.svg',
          width: 24,
          height: 24,
        ),
        Positioned(
          right: 7,
          top: 7,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(
              minWidth: 7,
              minHeight: 7,
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 6,
                  minHeight: 6,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class MySearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search doctor...",
          hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 20), // Adjust to fit your icon
            child: SvgPicture.asset(
              'assets/images/search-icon.svg',
              width: 30, // Adjust size as needed
              height: 30,
            ),
          ),
          border: InputBorder.none,
          // Ensures the hint text is vertically centered
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        textAlignVertical: TextAlignVertical
            .center, // Vertically centers the input text and hint
      ),
    );
  }
}
