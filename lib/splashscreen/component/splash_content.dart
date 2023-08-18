import 'package:chuss/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:chuss/size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
}) : super(key: key);
  final String text,image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "CHUSS",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(36),
            color: PrimaryYellow,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: Theme.of(context).accentColor
          ),
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width: getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
