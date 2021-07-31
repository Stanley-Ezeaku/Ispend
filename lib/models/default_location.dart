import 'package:flutter/foundation.dart';

class DefaultLocation {
  final double latitude;
  final double longitude;
  final String address;

  const DefaultLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}
