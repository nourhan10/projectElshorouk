import 'package:elshoroukproject/screens/home_screen.dart';

import 'package:elshoroukproject/widgets/auth_widgets/auth_title.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function resetpassword;
  AuthForm(this.resetpassword);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool loginmode, hidepassword, hideconfirmpassword, loading;
  String email, password, confirmpassword;
  GlobalKey fieldkey;
  double height;
  GlobalKey<FormState> form;
  FocusNode passwordNode, confirmNode;
  void initState() {
    super.initState();
    loginmode = true;
    fieldkey = GlobalKey();
    height = 0;
    hidepassword = hideconfirmpassword = true;
    form = GlobalKey<FormState>();
    passwordNode = FocusNode();
    confirmNode = FocusNode();
    loading = false;
  }

  void showError(String error) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void validateTologin() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      } on FirebaseException catch (error) {
        setState(() {
          loading = false;
        });

        switch (error.code) {
          case 'user-not-found':
            showError('User not found');
            break;
          case 'invalid-email':
            showError('invalid email or password');
            break;
          case 'wrong-password':
            showError('invalid email or password');
            break;
          case 'user-disabled':
            showError('This user has been disabled');
            break;
        }
      }
    }
  }

  void validateToregister() async {
    if (form.currentState.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      } on FirebaseException catch (error) {
        setState(() {
          loading = false;
        });

        switch (error.code) {
          case 'email-already-in-use':
            showError('Email already exist');
            break;
          case 'invalid-email':
            showError('You entered invalid email');
            break;
          default:
            showError('You entered weak password');
        }
      }
    }
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
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: (loginmode)
                    ? AuthTitle(UniqueKey(), 'Log in')
                    : AuthTitle(UniqueKey(), 'Create'),
              ),
              Form(
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      key: fieldkey,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      validator: (value) {
                        setState(() {
                          email = value;
                        });
                        if (EmailValidator.validate(email)) {
                          return null;
                        }
                        return 'invalid email address';
                      },
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        passwordNode.requestFocus();
                      },
                      decoration: InputDecoration(
                        hintText: 'Example@gmail.com',
                        hintStyle: TextStyle(
                          color: Colors.white,
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
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      obscureText: hidepassword,
                      validator: (value) {
                        setState(() {
                          password = value;
                        });
                        if (value.length >= 6) {
                          return null;
                        }
                        return 'password must be 6 character at least';
                      },
                      textInputAction: (loginmode)
                          ? TextInputAction.done
                          : TextInputAction.next,
                      onFieldSubmitted: (value) {
                        if (!loginmode) {
                          confirmNode.requestFocus();
                        }
                      },
                      focusNode: passwordNode,
                      decoration: InputDecoration(
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              hidepassword = !hidepassword;
                            });
                          },
                          child: Icon(
                            (hidepassword)
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                        ),
                        hintText: '••••••••',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                          ),
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
                    AnimatedContainer(
                      duration: Duration(seconds: 2),
                      curve: Curves.bounceOut,
                      height: height,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 400),
                        opacity: (loginmode) ? 0 : 1,
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          focusNode: confirmNode,
                          obscureText: hideconfirmpassword,
                          validator: (value) {
                            setState(() {
                              confirmpassword = value;
                            });
                            if (loginmode || value == password) {
                              return null;
                            }
                            return 'passwords don\'t match';
                          },
                          decoration: InputDecoration(
                            suffix: InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    hideconfirmpassword = !hideconfirmpassword;
                                  },
                                );
                              },
                              child: Icon(
                                (hideconfirmpassword)
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                            errorStyle: TextStyle(
                              color: Colors.redAccent,
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.redAccent,
                              ),
                            ),
                            hintText: '••••••••',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            labelText: 'Confirm Password',
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
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    widget.resetpassword();
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 45,
                child: (loading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RaisedButton(
                        shape: StadiumBorder(),
                        color: Theme.of(context).accentColor,
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 400),
                          child: (loginmode)
                              ? Text(
                                  'Login',
                                  key: UniqueKey(),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                )
                              : Text(
                                  'Register',
                                  key: UniqueKey(),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                        ),
                        onPressed: () {
                          if (loginmode) {
                            validateTologin();
                          } else {
                            validateToregister();
                          }
                        },
                      ),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: (loginmode)
                    ? Row(
                        key: UniqueKey(),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.zero,
                            child: Text(
                              'sign up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              final state = fieldkey.currentContext;
                              final box = state.findRenderObject() as RenderBox;
                              setState(() {
                                height = box.size.height;
                                loginmode = !loginmode;
                              });
                            },
                          ),
                        ],
                      )
                    : Row(
                        key: UniqueKey(),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          FlatButton(
                            padding: EdgeInsets.zero,
                            child: Text(
                              'sign in',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                loginmode = !loginmode;
                                height = 0;
                              });
                            },
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
