import 'package:flutter/material.dart';
import 'package:google_maps_in_flutter/screens/hotspot_screen.dart';
import 'package:google_maps_in_flutter/screens/map_screen.dart';
import 'package:google_maps_in_flutter/screens/search_location.dart';

class GoogleMapApp extends StatelessWidget {
  const GoogleMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HotspotScreen()
    );
  }
}
