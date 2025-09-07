import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_in_flutter/widgets/location_searchbar.dart';

import '../utils/constants/locations.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  /// Map Controller
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  /// Initial Camera Position
  static const CameraPosition _initCameraPosition = CameraPosition(
    target: MyLocations.gandhinagarLocation,
    zoom: 13,
  );

  /// Markers
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _mapController.complete(controller),
            initialCameraPosition: _initCameraPosition,
            markers: _markers,
          ),
          PLocationSearchBar(
            onPlaceSelected: (LatLng location, String description) async {
              final controller = await _mapController.future;
              controller.animateCamera(
                CameraUpdate.newLatLngZoom(location, 13),
              );

              // Add marker for selected location
              setState(() {
                _markers.clear(); // optional: remove previous marker
                _markers.add(
                  Marker(
                    markerId: MarkerId(description),
                    position: location,
                    infoWindow: InfoWindow(title: description),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
