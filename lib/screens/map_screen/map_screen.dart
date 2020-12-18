import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double lat, lng;

  const MapScreen({Key key, this.lat, this.lng}) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var myMarkers = HashSet<Marker>();
  String _address = '';
  Marker marker;
  Completer<GoogleMapController> _controller = Completer();

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  @override
  void initState() {
    super.initState();
  }

  Future<void> _moveToLastScreen() async {
    if (marker != null) {
      try {
        final coordinates = new Coordinates(
            marker.position.latitude, marker.position.longitude);
        Geocoder.local
            .findAddressesFromCoordinates(coordinates)
            .then((addresses) {
          if (addresses != null) {
            var first = addresses.first;
            // print('Address Line: ${first.addressLine}');
            // print('Admin Area: ${first.adminArea}');
            // print('Country Name: ${first.countryName}');
            // print('Feature Name: ${first.featureName}');
            // print('Locality: ${first.locality}');
            // print('Sub Admin Area: ${first.subAdminArea}');
            // print('Sub Locality: ${first.subLocality}');
            // print('Thoroughfare: ${first.thoroughfare}');
            // print('Sub Thoroughfare: ${first.subThoroughfare}');
            _address = first.addressLine;
            Navigator.pop(context, _address); //Removes the current screen
          }
        });

        // "${mPlaceMark.subThoroughfare} ${mPlaceMark.thoroughfare}, "
        // "${mPlaceMark.subLocality} ${mPlaceMark.locality}, "
        // "${mPlaceMark.subAdministrativeArea} ${mPlaceMark.administrativeArea}, "
        // "${mPlaceMark.postalCode} ${mPlaceMark.country}";
      } catch (e) {
        // show error
      }
    } else {
      Navigator.pop(context, ''); //Removes the current screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _moveToLastScreen(),
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.lat, widget.lng),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: myMarkers,
          onTap: (tappedPoint) {
            setState(() {
              myMarkers = HashSet<Marker>();
              marker = Marker(
                markerId: MarkerId('1'),
                position: tappedPoint,
              );
              myMarkers.add(marker);
            });
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Add Current Location'),
          onPressed: () {
            setState(() {
              myMarkers = HashSet<Marker>();
              marker = Marker(
                markerId: MarkerId('1'),
                position: LatLng(widget.lat, widget.lng),
              );
              myMarkers.add(marker);
            });
          },
        ),
      ),
    );
  }
}
