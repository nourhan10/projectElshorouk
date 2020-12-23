import 'package:elshoroukproject/misc/left_button.dart';
import 'package:elshoroukproject/misc/right_button.dart';
import 'package:elshoroukproject/screens/Auth_screen.dart';
import 'package:elshoroukproject/widgets/collecting_data/collecting_data_title.dart';
import 'package:flutter/material.dart';

class CollectingDataFirst extends StatefulWidget {
  final Function logout, nextPage;
  CollectingDataFirst(this.logout, this.nextPage);
  @override
  _CollectingDataFirstState createState() => _CollectingDataFirstState();
}

class _CollectingDataFirstState extends State<CollectingDataFirst> {
  String userName, mobileNumber;
  FocusNode mobileNode;
  void initState() {
    super.initState();
    mobileNode = FocusNode();
  }

  bool validateData() {
    bool valid = true;
    if (userName == null || userName.length < 3) valid = false;
    if (mobileNumber == null ||
        mobileNumber.length != 11 ||
        !mobileNumber.startsWith('01')) valid = false;

    return valid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 9,
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CollectingDataTitle(
                  'Welcome',
                  'Few steps to complet your profile',
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onSubmitted: (value) {
                    mobileNode.requestFocus();
                  },
                  onChanged: (value) {
                    userName = value;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Username',
                    hintText: 'ex: Nourhan Abd Elfattah',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  onChanged: (value) {
                    mobileNumber = value;
                  },
                  focusNode: mobileNode,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Mobile ',
                    hintText: 'Ex: 01xxxxxxxxx',
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RightButton(
                child: 'logout',
                onPressed: () async {
                  if (await widget.logout()) {
                    Navigator.of(context)
                        .pushReplacementNamed(AuthScreen.routename);
                  }
                },
              ),
              LeftButton(
                child: 'next',
                onPressed: () {
                  if (validateData()) {
                    widget.nextPage(userName, mobileNumber);
                  } else {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('invalid or missing data'),
                        content: Text(
                          'please check if you complete fields and used valied name and number',
                        ),
                        actions: [
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
