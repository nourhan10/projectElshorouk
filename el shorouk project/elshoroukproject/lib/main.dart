import 'package:elshoroukproject/screens/Collecting_data_screen.dart';
import 'package:elshoroukproject/screens/auth_screen.dart';
import 'package:elshoroukproject/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our Project',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.blue[300],
        fontFamily: 'MontserratAlternates',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else {
            if (FirebaseAuth.instance.currentUser != null) {
              return CollectingDataScreen();
            } else {
              return AuthScreen();
            }
          }
        },
      ),
      routes: {
        CollectingDataScreen.routeName: (context) => CollectingDataScreen(),
        AuthScreen.routename: (context) => AuthScreen(),
      },
    );
  }
}
