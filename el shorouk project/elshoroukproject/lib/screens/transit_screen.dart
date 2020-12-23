import 'package:elshoroukproject/providers/provider.dart';
import 'package:elshoroukproject/screens/collecting_data_screen.dart';
import 'package:elshoroukproject/screens/home_screen.dart';
import 'package:elshoroukproject/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransitScreen extends StatelessWidget {
  static const routeName = '/transit';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<UserProvider>(context, listen: false).profileCompleted(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else if (snapshot.data == true) {
          return HomeScreen();
        } else {
          return CollectingDataScreen();
        }
      },
    );
  }
}
