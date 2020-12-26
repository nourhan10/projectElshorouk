import 'package:flutter/material.dart';
import 'package:forms/screens/Auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our project',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.blue[300],
        fontFamily: 'MontserratAlternates',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(),
    );
  }
}
