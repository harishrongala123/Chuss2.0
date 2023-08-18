import 'package:chuss/Customer-side/Home/MapScreen/Map_Screen.dart';
import 'package:chuss/Customer-side/Home/homepage.dart';
import 'package:chuss/components/loginmain.dart';
import 'package:flutter/widgets.dart';
import 'package:chuss/splashscreen/splash_screen.dart';



final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginMain.routeName: (context) => LoginMain(),
  MapScreen.routeName: (context) => MapScreen(),
  HomePage.routeName: (context) => HomePage(),
};

