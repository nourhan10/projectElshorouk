import 'package:elshoroukproject/providers/provider.dart';
import 'package:elshoroukproject/screens/Auth_screen.dart';
import 'package:elshoroukproject/widgets/collecting_data/collecting_data_first.dart';
import 'package:elshoroukproject/widgets/collecting_data/collecting_data_second.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:elshoroukproject/screens/transit_screen.dart';

class CollectingDataScreen extends StatefulWidget {
  static const String routeName = '/collecting';
  @override
  _CollectingDataScreenState createState() => _CollectingDataScreenState();
}

class _CollectingDataScreenState extends State<CollectingDataScreen> {
  PageController controller;
  String userName, mobilrNumber;
  LatLng currentposition;
  String currentAddress;
  bool loading;

  void initState() {
    super.initState();
    controller = PageController();
    loading = false;
  }

  void dispose() {
    super.dispose();
    controller.dispose();
  }

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
                Navigator.of(context).pop(true);
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

  void nextPage(String name, String mobile) {
    this.userName = name;
    this.mobilrNumber = mobile;
    controller.nextPage(
        duration: Duration(seconds: 1), curve: Curves.decelerate);
  }

  void prevPage() {
    controller.previousPage(
        duration: Duration(seconds: 1), curve: Curves.decelerate);
  }

  void submit(LatLng position, String address) async {
    setState(() {
      currentposition = position;
      currentAddress = address;
      loading = true;
    });
    bool noError = await Provider.of<UserProvider>(context, listen: false)
        .updateData(userName, mobilrNumber, position, address);
    if (!noError) {
      setState(() {
        loading = false;
      });
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error has ocurred'),
          content: Text('please try again later'),
          actions: [
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      Navigator.of(context).pushReplacementNamed(TransitScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        bool action = await logout();
        if (action == true) {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed(AuthScreen.routename);
        }
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
                child: Container(
                  height: height - MediaQuery.of(context).padding.top - 20,
                  width: width,
                  child: PageIndicatorContainer(
                    length: 2,
                    padding: EdgeInsets.only(bottom: 30),
                    indicatorColor: Colors.grey,
                    indicatorSelectorColor: Colors.black,
                    shape: IndicatorShape.roundRectangleShape(
                      size: Size(20, 5),
                      cornerSize: Size.square(20),
                    ),
                    child: PageView(
                      controller: controller,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CollectingDataFirst(logout, nextPage),
                        CollectingSecond(prevPage, submit),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (loading)
              Container(
                color: Colors.black38,
                height: height,
                width: width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
