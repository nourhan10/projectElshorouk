import 'package:elshoroukproject/screens/Auth_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> logout() async {
    bool action = await showDialog(
      context: context,
      child: AlertDialog(
        title: Text(
          'Are you sure?',
        ),
        content: Text(
          'if you logout you will come here again to complet information',
        ),
        actions: [
          FlatButton(
              child: Text(
                'logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AuthScreen.routename);
              }),
          FlatButton(
              child: Text(
                'Cancle',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              }),
        ],
      ),
    );
    return action;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Our project',
        )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Welcome to our project',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RaisedButton(
              child: Text('logout'),
              onPressed: () {
                logout();
              }),
        ],
      ),
    );
  }
}
