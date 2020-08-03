import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/botton_navigation_screen.dart';
import 'utilities/constants.dart';

void main() => runApp(OneValidatorDashboardApp());

class OneValidatorDashboardApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harmony (ONE) Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: kHmyMainColor,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        primaryTextTheme: TextTheme(
          headline6: GoogleFonts.nunitoSans(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            color: kHmyTitleTextColor,
          ),
          subtitle1: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            color: kHmyTitleTextColor,
          ),
          bodyText1: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            color: kHmyNormalTextColor,
          ),
          bodyText2: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            color: kHmyNormalTextColor,
          ),
          caption: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            color: kHmyNormalTextColor,
          ),
          button: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            color: kHmyNormalTextColor,
          ),
          overline: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            color: kHmyNormalTextColor,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.black,
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        primaryTextTheme: TextTheme(
          headline6: GoogleFonts.nunitoSans(
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
          subtitle1: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
          bodyText1: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
          bodyText2: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
          overline: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
          button: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
          caption: GoogleFonts.nunito(
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
      ),
      home: BottomNavigationScreen(),
    );
  }
}
