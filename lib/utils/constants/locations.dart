import 'package:google_maps_flutter/google_maps_flutter.dart';

/// List of Locations
class MyLocations {
  MyLocations._(); //private

  static const LatLng pIndiaMap = LatLng(
    20.593684,
    78.96288,
  ); //Location(Wadgaon, Maharashtra)
  static const LatLng gandhinagarLocation = LatLng(
    23.237560,
    72.647781,
  ); //Location(Gandhinagar, Gujarat)
  static const LatLng pAhemdabadMap = LatLng(
    23.237560,
    72.647781,
  ); //Location(Gandhinagar, Gujarat)
  static const LatLng pGandhinagarBusStandMap = LatLng(23.21826, 72.642592);
  static const LatLng pGecGandhinagarMap = LatLng(23.25912, 72.653756);

  /// 50 Coastal + 20 Clustered Points
  static List<LatLng> testCoastalLocations = [
    // Gujarat Coast
    LatLng(22.3039, 70.8022), // Jamnagar
    LatLng(21.6417, 69.6293), // Dwarka
    LatLng(20.7288, 70.9870), // Somnath
    LatLng(20.8890, 70.4000), // Veraval
    LatLng(22.8106, 69.8597), // Mandvi

    // Maharashtra Coast
    LatLng(18.5204, 73.8567), // Pune (not coast but near)
    LatLng(18.9600, 72.8200), // Mumbai
    LatLng(16.7050, 73.9780), // Ratnagiri
    LatLng(15.4026, 73.7856), // Sindhudurg
    LatLng(15.2993, 74.1239), // Goa (Panaji)

    // Karnataka Coast
    LatLng(14.6826, 74.0190), // Karwar
    LatLng(13.3409, 74.7421), // Udupi
    LatLng(12.9141, 74.8560), // Mangalore

    // Kerala Coast
    LatLng(11.8745, 75.3704), // Kannur
    LatLng(9.9312, 76.2673),  // Kochi
    LatLng(8.5241, 76.9366),  // Thiruvananthapuram
    LatLng(10.0889, 76.4894), // Alappuzha
    LatLng(11.2588, 75.7804), // Kozhikode

    // Tamil Nadu Coast
    LatLng(13.0827, 80.2707), // Chennai (cluster hotspot)
    LatLng(9.2876, 79.3129),  // Rameswaram
    LatLng(8.0883, 77.5385),  // Kanyakumari
    LatLng(11.6820, 79.4192), // Cuddalore
    LatLng(10.7650, 79.8420), // Nagapattinam

    // Andhra Pradesh Coast
    LatLng(17.6868, 83.2185), // Visakhapatnam
    LatLng(14.9129, 79.9946), // Nellore
    LatLng(16.3067, 80.4365), // Guntur
    LatLng(15.8281, 80.0160), // Ongole
    LatLng(18.0000, 83.0000), // Srikakulam

    // Odisha Coast
    LatLng(19.8135, 85.8312), // Puri
    LatLng(20.2961, 85.8245), // Bhubaneswar (near coast)
    LatLng(21.5000, 87.0000), // Balasore
    LatLng(20.7196, 86.9330), // Paradip
    LatLng(19.6000, 85.2000), // Gopalpur

    // West Bengal Coast
    LatLng(21.6476, 87.7440), // Digha
    LatLng(21.9000, 88.2700), // Sagar Island
    LatLng(22.0000, 88.1500), // Diamond Harbour
    LatLng(22.5726, 88.3639), // Kolkata (near Hooghly)

    // Andaman & Nicobar
    LatLng(11.6670, 92.7500), // Port Blair
    LatLng(12.0000, 93.0000), // Havelock Island
    LatLng(13.1500, 93.0000), // Neil Island
    LatLng(10.6000, 92.6000), // Little Andaman
    LatLng(12.5000, 92.8000), // Long Island

    // Lakshadweep
    LatLng(10.5667, 72.6333), // Kavaratti
    LatLng(11.1500, 72.7833), // Agatti Island
    LatLng(10.8167, 72.1667), // Minicoy

    // --- Clustered Points around Chennai (15–20 within ~3km) ---
    LatLng(13.0810, 80.2690),
    LatLng(13.0845, 80.2742),
    LatLng(13.0795, 80.2718),
    LatLng(13.0860, 80.2735),
    LatLng(13.0832, 80.2760),
    LatLng(13.0855, 80.2705),
    LatLng(13.0828, 80.2678),
    LatLng(13.0807, 80.2725),
    LatLng(13.0872, 80.2710),
    LatLng(13.0815, 80.2748),
    LatLng(13.0839, 80.2698),
    LatLng(13.0789, 80.2730),
    LatLng(13.0865, 80.2753),
    LatLng(13.0840, 80.2720),
    LatLng(13.0823, 80.2685),
    LatLng(13.0858, 80.2695),
    LatLng(13.0798, 80.2712),
    LatLng(13.0870, 80.2740),
    LatLng(13.0835, 80.2755),
    LatLng(13.0818, 80.2708),
  ];
}
