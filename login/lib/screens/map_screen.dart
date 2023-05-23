import 'dart:async';

import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  List<MapType> types = [
    MapType.hybrid,
    MapType.normal,
    MapType.satellite,
    MapType.terrain
  ];

  int index = 0;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GoogleMap(
            mapType: types[index],
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          CircularMenu(items: [
            CircularMenuItem(
                icon: Icons.home,
                onTap: () => setState(() {
                  index=0;
                })),
            CircularMenuItem(
                icon: Icons.search,
                onTap: () => setState(() {
                  index=1;
                })),
            CircularMenuItem(
                icon: Icons.settings,
                onTap: () => setState(() {
                  index=2;
                })),
            CircularMenuItem(
                icon: Icons.star,
                onTap: () => setState(() {
                  index=3;
                })),
          ])
        ],
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
