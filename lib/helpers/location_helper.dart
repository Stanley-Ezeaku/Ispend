import 'dart:convert';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyDMnqWbZLpDQi5lM_wZJZDzwV-nPD8CWjQ';

// reponsible for make request to google api
class LocationHelper {
// this method makes a request to the api based on the latitude and longitude
//passed in through the param.
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    // the return is the URL of a Maps Static API Image
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:green%7Clabel:L%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

// this method is use to send request to reserved geocoding Api
  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
