import 'package:chuss/Customer-side/Home/components/services.dart';
import 'package:flutter/material.dart';
import 'carousel.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:(20)),
            SizedBox(
              height: 200.0,
              width: double.infinity,
              child: CarouselSlide(),
            ),
            SizedBox(height: (20)),
            SizedBox(
              height: 400.0,
              child: Services(),
            ),
            SizedBox(height: (20)),
          ],
        ),
      ),
    );
  }
}