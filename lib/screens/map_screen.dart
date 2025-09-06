import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_in_flutter/utils/constants/api_keys.dart';
import 'package:google_maps_in_flutter/utils/constants/locations.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  ///Location Controller
  final Location _locationController = Location();

  /// Map Controller
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  /// User Current Location
  LatLng? _currentLocation;

  /// Initial Camera Position
  static const CameraPosition _initCameraPosition = CameraPosition(
    target: MyLocations.gandhinagarLocation,
    zoom: 13,
  );

  /// Source and Destination Location
  static const LatLng _sourceLocation = LatLng(23.21826, 72.642592);
  static const LatLng _destinationLocation = LatLng(23.25912, 72.653756);

  /// Polylines
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdates().then(
      (_) => {
        getPolylinePoints().then((coordinates) {
          generatePolylineFromPoints(coordinates);
        }),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          ? const Center(child: Text("Loading User Location..."))
          : GoogleMap(
              initialCameraPosition: _initCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              markers: {
                Marker(
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentLocation!,
                ),
                Marker(
                  markerId: MarkerId("_sourceLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _sourceLocation,
                ),
                Marker(
                  markerId: MarkerId("_destinationLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _destinationLocation,
                ),
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  /// Get Current Location of User
  Future<void> getLocationUpdates() async {
    bool isServiceEnabled;
    PermissionStatus permissionStatus;

    /// Check for GPS Service
    isServiceEnabled = await _locationController.serviceEnabled();
    if (isServiceEnabled) {
      isServiceEnabled = await _locationController.requestService();
    } else {
      return; // if service is not enabled
    }

    /// Check for location Access
    permissionStatus = await _locationController.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _locationController.requestPermission();
    }
    if (permissionStatus != PermissionStatus.granted) {
      return; // if permission is not granted
    }

    _locationController.onLocationChanged.listen((
      LocationData currentLocation,
    ) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentLocation = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
          log("User Current Location : $_currentLocation");

          /// Focus on User Location
          _cameraToPosition(_currentLocation!);
        });
      }
    });
  }

  /// Animate camera to user position
  Future<void> _cameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: position,
      zoom: 13,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  /// Get Polyline Points
  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    // Initialize PolylinePoints
    PolylinePoints polylinePoints = PolylinePoints(
      apiKey: MyAPIKeys.googleMapApiKey,
    );

    // Get route using legacy Directions API
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(_sourceLocation.latitude, _sourceLocation.longitude),
        destination: PointLatLng(_destinationLocation.latitude, _destinationLocation.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      // Convert to LatLng for Google Maps
      List<LatLng> polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      return polylineCoordinates;
    } else {
      log("Error : ${result.errorMessage}");
    }

    return [];
  }

  /// make polyline from coordinates
  Future<void> generatePolylineFromPoints(List<LatLng> points) async {
    PolylineId polylineId = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: polylineId,
      color: Colors.black,
      width: 8,
      points: points,
    );
    
    setState(() {
      polylines[polylineId] = polyline;
    });
  }
}
