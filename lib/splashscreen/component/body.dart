import 'package:chuss/components/constants.dart';
import 'package:chuss/components/default_button.dart';
import 'package:chuss/components/loginmain.dart';
import 'package:flutter/material.dart';
import 'package:chuss/splashscreen/component/splash_content.dart';

import '../../size_config.dart';


class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  int currentPage = 0;
  List<Map<String, String>> splashData = [

    {
      "text": "Welcome to Chuss, Let’s start!",
      "image": "assets/images/splash_3.png"
    },
    {
      "text":
             "We help people connect with Local Technicians \naround them",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to grab a technician. \nJust stay at home with us",
      "image": "assets/images/splash_1.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                            (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context,LoginMain.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


AnimatedContainer buildDot({int index}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 200),
    margin: EdgeInsets.only(right: 5),
    height: 6,
    width: currentPage == index ? 20 : 6,
    decoration: BoxDecoration(
      color: currentPage == index ? PrimaryYellow : Color(0xFFD8D8D8),
      borderRadius: BorderRadius.circular(3),
    ),
  );
 }
}