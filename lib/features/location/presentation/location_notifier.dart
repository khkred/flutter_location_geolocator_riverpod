import 'package:flutter_riverpod/flutter_riverpod.dart';

// Assuming your LocationState and LocationRepository are in the same feature directory
import '../data/location_repository.dart';
import '../data/location_state.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, GetLocationState>((ref) {
  final locationRepository = ref.read(locationRepositoryProvider);
  return LocationNotifier(locationRepository);
});

class LocationNotifier extends StateNotifier<GetLocationState> {
  final LocationRepository _locationRepository;

  LocationNotifier(this._locationRepository) : super(GetLocationState.initial());

  Future<void> getLocation() async {
    final position = await _locationRepository.getCurrentLocation();

    if (position != null) {
      state = state.copyWith(position: position);
    } else {
      // Handle location permission denied (explained below)
    }
  }
}
