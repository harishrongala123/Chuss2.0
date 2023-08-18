import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF1C1C1C),
  // ignore: deprecated_member_use
  accentColor: Color(0xFFF2F2F2),
  canvasColor: Color(0xFF1C1C1C),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: GoogleFonts.muktaVaaniTextTheme(),

);