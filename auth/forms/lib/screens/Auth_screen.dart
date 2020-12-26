import 'package:flutter/material.dart';
import 'package:forms/auth_widgets/auth_background.dart';
import 'package:forms/auth_widgets/auth_form.dart';
import 'package:forms/auth_widgets/reset_password.dart';

class AuthScreen extends StatefulWidget {
  static const String routename = '/auth-screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool forgotpassword;
  void initState() {
    super.initState();
    forgotpassword = false;
  }

  void resetpassword() {
    setState(() {
      forgotpassword = !forgotpassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuthBackGround(),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            curve: Curves.decelerate,
            right: (forgotpassword) ? 0 : -MediaQuery.of(context).size.width,
            child: ResetPassword(resetpassword),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            curve: Curves.decelerate,
            left: (!forgotpassword) ? 0 : -MediaQuery.of(context).size.width,
            child: AuthForm(resetpassword),
          ),
        ],
      ),
    );
  }
}
