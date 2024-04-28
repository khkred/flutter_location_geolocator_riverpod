import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

// Assuming your LocationState and LocationRepository are in the same feature directory
import '../data/location_repository.dart';
import '../data/location_state.dart';

final locationProvider =
    StateNotifierProvider<LocationNotifier, GetLocationState>((ref) {
  final locationRepository = ref.read(locationRepositoryProvider);
  return LocationNotifier(locationRepository);
});

class LocationNotifier extends StateNotifier<GetLocationState> {
  final LocationRepository _locationRepository;

  LocationNotifier(this._locationRepository)
      : super(GetLocationState.initial());

  Future<void> getLocation(BuildContext context) async {

    final permission = await _locationRepository.checkPermissions();

if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      _showPermissionDialog(context);
      return;
    }

    final position = await _locationRepository.getCurrentLocation();

    if (position != null) {
      state = state.copyWith(position: position);
    } else {
      // Handle location permission denied (explained below)
    }
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Denied'),
        content: const Text(
            'This app needs location permission to access your location.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final status = await Geolocator.requestPermission();
              if (status == LocationPermission.whileInUse ||
                  status == LocationPermission.always) {
                getLocation(context); // Retry fetching location if permission granted
              } else {
                // Handle user refusing permission (optional)
              }
              Navigator.pop(context);
            },
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }
}
