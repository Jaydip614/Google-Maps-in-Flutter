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

  /// Circles
  final Set<Circle> _circles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _mapController.complete(controller),
            initialCameraPosition: _initCameraPosition,
            markers: _markers,
            circles: _circles,
          ),
          PLocationSearchBar(
            onPlaceSelected: (LatLng location, String description) async {
              final controller = await _mapController.future;
              controller.animateCamera(
                CameraUpdate.newLatLngZoom(location, 13),
              );

              // Add marker and circle
              setState(() {
                _markers.clear();
                _circles.clear();

                _markers.add(
                  Marker(
                    markerId: MarkerId(description),
                    position: location,
                    infoWindow: InfoWindow(title: description),
                    onTap: () {
                      _showPlaceBottomSheet(description, location);
                    },
                  ),
                );

                _circles.add(
                  Circle(
                    circleId: CircleId("radius_circle"),
                    center: location,
                    radius: 1000, // ✅ radius in meters (1 km)
                    fillColor: Colors.red.withValues(alpha: 0.2),
                    strokeColor: Colors.red,
                    strokeWidth: 2,
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  /// Show bottom sheet when marker tapped
  void _showPlaceBottomSheet(String description, LatLng location) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text("Lat: ${location.latitude}, Lng: ${location.longitude}"),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.navigation),
                label: const Text("Start Navigation"),
              ),
            ],
          ),
        );
      },
    );
  }
}