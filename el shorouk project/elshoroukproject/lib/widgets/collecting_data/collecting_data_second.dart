import 'package:elshoroukproject/misc/left_button.dart';
import 'package:elshoroukproject/misc/right_button.dart';
import 'package:elshoroukproject/widgets/collecting_data/collecting_data_title.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart';

class CollectingSecond extends StatefulWidget {
  final Function prevPage, submit;
  CollectingSecond(this.prevPage, this.submit);
  @override
  _CollectingSecondState createState() => _CollectingSecondState();
}

class _CollectingSecondState extends State<CollectingSecond> {
  bool isLoading;
  LatLng currentPosition;
  String currentAddress;
  void initState() {
    super.initState();
    isLoading = true;
  }

  void didChangeDependencies() async {
    super.didChangeDependencies();
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    currentPosition = LatLng(_locationData.latitude, _locationData.longitude);
    currentAddress = await getAddress(currentPosition);
    setState(() {
      isLoading = false;
    });
  }

  Future<String> getAddress(currentPosition) async {
    final coordinates =
        new Coordinates(currentPosition.latitude, currentPosition.longitude);
    final addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first.addressLine;
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
              children: [
                CollectingDataTitle(
                  'One Step left,',
                  'Select your location so we can deliver to you.',
                ),
                SizedBox(height: 30),
                Expanded(
                  child: (isLoading)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Stack(
                          children: [
                            GoogleMap(
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: currentPosition,
                                zoom: 19,
                              ),
                              onCameraMove: (position) {
                                setState(() {
                                  currentPosition = position.target;
                                });
                              },
                              onCameraIdle: () async {
                                currentAddress =
                                    await getAddress(currentPosition);
                                setState(() {});
                              },
                            ),
                            Card(
                              elevation: 20,
                              margin: EdgeInsets.fromLTRB(16, 60, 16, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(currentAddress),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 35 / 2),
                                child: Icon(
                                  Icons.place,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
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
                child: 'Back',
                onPressed: () {
                  widget.prevPage();
                },
              ),
              LeftButton(
                child: 'Submit',
                onPressed: () {
                  widget.submit(currentPosition, currentAddress);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
