import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final locationRepositoryProvider = Provider<LocationRepository>((ref) => LocationRepository());

class LocationRepository {
  Future<Position?> getCurrentLocation() async {
    try {
      LocationPermission permission = await _checkPermissions();
      if (permission == LocationPermission.denied) {
        return null;
      }
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<LocationPermission> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission;
  }
}
