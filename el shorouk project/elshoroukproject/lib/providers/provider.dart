import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserProvider extends ChangeNotifier {
  Future<bool> updateData(
      String name, String mobile, LatLng possition, String address) async {
    try {
      String userid = FirebaseAuth.instance.currentUser.uid;
      String email = FirebaseAuth.instance.currentUser.email;
      await FirebaseFirestore.instance.collection('Usres').doc(userid).set({
        'email': email,
        'userName': name,
        'mobileNumber': mobile,
        'lat': possition.latitude,
        'lng': possition.longitude,
        'address': address,
      });
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> profileCompleted() async {
    try {
      String userid = FirebaseAuth.instance.currentUser.uid;

      final document = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userid)
          .get();
      if (document.exists) {
        //load data
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
