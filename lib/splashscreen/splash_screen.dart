import 'package:flutter/material.dart';
import 'package:chuss/splashscreen/component/body.dart';
import 'package:chuss/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splashscreen";
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Body(),
    );
  }
}
