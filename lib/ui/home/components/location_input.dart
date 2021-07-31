import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ispend/helpers/location_helper.dart';
import 'package:ispend/models/default_location.dart';
import 'package:ispend/ui/map/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function selectedPlace;
  LocationInput(this.selectedPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  DefaultLocation defaultLocation;

  void _showPrevie(double lat, double lng) {
    //
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  // fetch user location when the 'current location' button is pressed
  Future<void> _getCurrentUserLocation() async {
    // Location().getLocation() is a class and method from the location package
    //that gets the current location of user device

    try {
      final locationData = await Location().getLocation();
      _showPrevie(locationData.latitude, locationData.longitude);
      widget.selectedPlace(locationData.latitude, locationData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPrevie(selectedLocation.latitude, selectedLocation.longitude);
    widget.selectedPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
            )
          ],
        )
      ],
    );
  }
}
