import 'package:flutter_location_geolocator_riverpod/features/location/data/location_permission_enum.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationState {
  final Position? position;
  final LocationPermissions permission;

  GetLocationState({
     this.position,
    required this.permission,
  });

  factory GetLocationState.initial() {
    return GetLocationState(
      permission: LocationPermissions.unknown,
    );
  }

  GetLocationState copyWith({
    Position? position,
    LocationPermissions? permission,
  }) {
    return GetLocationState(
      position: position ?? this.position,
      permission: permission ?? this.permission,
    );
  }
}