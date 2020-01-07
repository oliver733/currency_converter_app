import 'dart:io';
import 'package:currency_converter/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyStrings.appName,
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(),
        appBarTheme: AppBarTheme(
          textTheme: GoogleFonts.nunitoSansTextTheme(TextTheme(
              title: TextStyle(
                  fontSize: 24,
                  // color: MyColors.grey,
                  fontWeight: FontWeight.w600))),
          iconTheme: IconThemeData(color: Colors.black),
          brightness: (Platform.isIOS ? Brightness.light : null),
          color: Colors.white,
          elevation: 0,
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: MyColors.blue,
            splashColor: Colors.transparent,
            padding: EdgeInsets.all(14),
            shape: StadiumBorder()),
      ),
      home: MyHomePage(),
    );
  }
}
