import 'package:flutter/material.dart';

class LeftButton extends FlatButton {
  LeftButton({@required String child, @required Function onPressed})
      : super(
          padding: EdgeInsets.only(right: 20),
          color: Colors.black,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Text(
            child,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: onPressed,
        );
}
