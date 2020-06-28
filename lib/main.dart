import 'package:cyberpunkkillerapp/SplashPage.dart';
import 'package:cyberpunkkillerapp/screens/ImageFilterPage.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: primaryColor,
        accentColor: accentColor,
      ),
      home: SplashPage(),
   //   home: ImageFilterPage(null),
    );
  }
}
