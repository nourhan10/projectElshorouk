import 'package:flutter/material.dart';
import 'package:forms/auth_widgets/auth_title.dart';

class ResetPassword extends StatefulWidget {
  final Function resetpassword;
  ResetPassword(this.resetpassword);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool loading;
  String email;
  GlobalKey<FormState> form;
  void initState() {
    super.initState();
    loading = false;
    form = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30).add(
            EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthTitle(
                UniqueKey(),
                'Reset password of',
              ),
              Form(
                key: form,
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Example@gmail.com',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                width: double.infinity,
                height: 45,
                child: (loading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
                        shape: StadiumBorder(),
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Reset password',
                          key: UniqueKey(),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () {},
                      ),
              ),
              Center(
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {
                    widget.resetpassword();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
