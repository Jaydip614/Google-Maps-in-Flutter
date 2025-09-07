import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_in_flutter/screens/alert_zone_helper.dart';
import 'package:google_maps_in_flutter/utils/constants/locations.dart';

class HotspotScreen extends StatefulWidget {
  const HotspotScreen({super.key});

  @override
  State<HotspotScreen> createState() => _HotspotScreenState();
}

class _HotspotScreenState extends State<HotspotScreen> {

  /// Helper
  final helper = AlertZoneHelper();

  /// Marker and circles
  Set<Marker> markers ={};
  Set<Circle> circles = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final result = await helper.detectHotspots(MyLocations.testCoastalLocations);

    setState(() {
      markers = result["markers"];
      circles = result["circles"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: markers,
        circles: circles,
        initialCameraPosition: CameraPosition(
          target: MyLocations.pIndiaMap,
          zoom: 4.5,
        ),
      ),
    );
  }
}
