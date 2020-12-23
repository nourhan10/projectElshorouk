import 'package:flutter/material.dart';

class RightButton extends FlatButton {
  RightButton({
    @required String child,
    @required Function onPressed,
  }) : super(
          padding: EdgeInsets.only(left: 20),
          color: Colors.black,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
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
