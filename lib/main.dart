import 'package:flutter/material.dart';
import 'package:tapit/homepage.dart';
import 'package:tapit/wallpaper.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(appBarTheme: AppBarTheme()),
      home: Home(),
    );
  }
}
