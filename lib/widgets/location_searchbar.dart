import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_in_flutter/utils/constants/api_keys.dart';
import 'package:http/http.dart' as http;

class PLocationSearchBar extends StatefulWidget {
  const PLocationSearchBar({super.key, required this.onPlaceSelected});
  final Function(LatLng, String) onPlaceSelected;

  @override
  State<PLocationSearchBar> createState() => _PLocationSearchBarState();
}

class _PLocationSearchBarState extends State<PLocationSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _suggestions = [];


  Future<void> _getSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() => _suggestions = []);
      return;
    }

    final url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${MyAPIKeys.googleMapApiKey}&types=geocode";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {
      setState(() => _suggestions = data['predictions']);
    } else {
      setState(() => _suggestions = []);
    }
  }

  Future<void> _selectPlace(String placeId, String description) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${MyAPIKeys.googleMapApiKey}";

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {
      final location = data['result']['geometry']['location'];
      final LatLng latLng = LatLng(location['lat'], location['lng']);
      log("Selected Location : $latLng");
      widget.onPlaceSelected(latLng, description);
      setState(() => _suggestions = []);
      _searchController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 56,),

              /// SearchBar
              TextField(
                controller: _searchController,
                onChanged: _getSuggestions,
                decoration: InputDecoration(
                  hintText: "Search places...",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
              SizedBox(height: 8,),

              /// List of suggestions
              if (_suggestions.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = _suggestions[index];
                      final mainText = suggestion['structured_formatting']['main_text'];
                      final secondaryText = suggestion['structured_formatting']['secondary_text'];

                      return ListTile(
                        leading: const Icon(Icons.location_on_outlined, color: Colors.grey),
                        title: Text(
                          mainText,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: secondaryText == null ? null : Text(
                          secondaryText ?? "",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: const Icon(Icons.north_east, size: 18, color: Colors.grey),
                        onTap: () {
                          _selectPlace(
                            suggestion['place_id'],
                            suggestion['description'],
                          );
                        },
                      );
                    },
                  )
                  ,
                ),
            ],
          ),
        );
  }
}
