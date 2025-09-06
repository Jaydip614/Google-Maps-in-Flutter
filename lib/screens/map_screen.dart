import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng _pIndiaMap = LatLng(
    20.593684,
    78.96288,
  ); //Location(Wadgaon, Maharashtra)
  static const LatLng _pGandhinagarMap = LatLng(
    23.237560,
    72.647781,
  ); //Location(Gandhinagar, Gujarat)
  static const LatLng _pAhemdabadMap = LatLng(
    23.237560,
    72.647781,
  ); //Location(Gandhinagar, Gujarat)
  static const LatLng _pGandhinagarBusStandMap = LatLng(23.21826, 72.642592);
  static const LatLng _pGecGandhinagarMap = LatLng(23.25912, 72.653756);

  static const CameraPosition _kIndiaMap = CameraPosition(
    target: _pGandhinagarMap,
    zoom: 13,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kIndiaMap,
        markers: {
          Marker(
            markerId: MarkerId("_currentLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: _pGandhinagarBusStandMap,
          ),
          Marker(
            markerId: MarkerId("_sourceLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: _pGecGandhinagarMap,
          ),
        },
      ),
    );
  }
}
