import 'dart:io';

import 'package:currency_converter/strings.dart';
import 'package:currency_converter/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyStrings.appName,
      theme: ThemeData(
        textTheme: GoogleFonts.quicksandTextTheme(),
        appBarTheme: AppBarTheme(
          textTheme: GoogleFonts.quicksandTextTheme(TextTheme(
              title: TextStyle(
                  fontSize: 30,
                  // color: MyColors.grey,
                  fontWeight: FontWeight.w800))),
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
