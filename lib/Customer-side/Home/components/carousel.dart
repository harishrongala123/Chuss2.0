import 'package:carousel_pro/carousel_pro.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';

class CarouselSlide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SizedBox(height: 200,
        width: double.infinity,
        child: ClayContainer(
            color: Theme.of(context).primaryColor,
            child: Carousel(
              dotSize: 4.0,
              dotBgColor: Colors.transparent,
              dotColor: Colors.black,
              dotIncreasedColor: Colors.black,
              dotSpacing: 15.0,
              dotPosition: DotPosition.bottomRight,
              animationDuration: Duration(milliseconds: 800),
              images: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/Slider2.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/Slider1.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/Slider2.png',
                  ),
                )
              ],
            ),
          ),
      )
    );
  }
}
