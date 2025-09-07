import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_in_flutter/utils/helpers/helpers.dart';

class AlertZoneHelper {
  /// Detect clusters (10+ points within 5km)
  Future<Map<String, dynamic>> detectHotspots(List<LatLng> locations) async {
    final Set<Marker> markers = {};
    final Set<Circle> circles = {};
    const double radius = 5000; // 5 km
    const int minClusterSize = 10;

    final Set<int> visited = {}; // Track processed points

    for (int i = 0; i < locations.length; i++) {
      final BitmapDescriptor dotIcon = await MyHelpers.createDotMarker(color: Colors.red, size: 30);
      // Markers are always added
      markers.add(
        Marker(
          markerId: MarkerId("marker_$i"),
          // icon: dotIcon,
          position: locations[i],
        ),
      );

      if (visited.contains(i)) continue; // Skip if already clustered

      final LatLng center = locations[i];
      List<int> clusterIndices = [];

      // Count nearby points
      for (int j = 0; j < locations.length; j++) {
        final double dist = MyHelpers.haversine(
          center.latitude,
          center.longitude,
          locations[j].latitude,
          locations[j].longitude,
        );

        if (dist <= radius) {
          clusterIndices.add(j);
        }
      }

      // If cluster found (10+ nearby points)
      if (clusterIndices.length >= minClusterSize) {
        // Mark all points in this cluster as visited
        visited.addAll(clusterIndices);

        // Compute centroid
        double avgLat = clusterIndices
            .map((idx) => locations[idx].latitude)
            .reduce((a, b) => a + b) /
            clusterIndices.length;
        double avgLng = clusterIndices
            .map((idx) => locations[idx].longitude)
            .reduce((a, b) => a + b) /
            clusterIndices.length;

        circles.add(
          Circle(
            circleId: CircleId("cluster_$i"),
            center: LatLng(avgLat, avgLng),
            radius: radius,
            fillColor: Colors.red.withValues(alpha: 0.2),
            strokeColor: Colors.red,
            strokeWidth: 2,
          ),
        );
      }
    }

    return {"markers": markers, "circles": circles};
  }
}
