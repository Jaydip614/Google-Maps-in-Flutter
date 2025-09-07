import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHelpers {
  MyHelpers._();

  /// Calculate distances manually with Haversine function
  static double haversine(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000; // Earth radius in meters
    final dLat = (lat2 - lat1) * (3.14159265359 / 180);
    final dLon = (lon2 - lon1) * (3.14159265359 / 180);

    final a =
        (sin(dLat / 2) * sin(dLat / 2)) +
            cos(lat1 * (3.14159265359 / 180)) *
                cos(lat2 * (3.14159265359 / 180)) *
                (sin(dLon / 2) * sin(dLon / 2));

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // distance in meters
  }


  /// Custom Marker
  static Future<BitmapDescriptor> createDotMarker({
    Color color = Colors.blue,
    double size = 12,
  }) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Paint paint = Paint()..color = color;

    // Draw circle
    canvas.drawCircle(
      Offset(size / 2, size / 2),
      size / 2,
      paint,
    );

    final img = await pictureRecorder
        .endRecording()
        .toImage(size.toInt(), size.toInt());
    final byteData = await img.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

}