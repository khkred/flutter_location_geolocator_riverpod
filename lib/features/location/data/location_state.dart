import 'package:geolocator/geolocator.dart';

class GetLocationState {
  final Position? position;
  final LocationPermission permission;

  GetLocationState({
     this.position,
    required this.permission,
  });

  factory GetLocationState.initial() {
    return GetLocationState(
      permission: LocationPermission.unableToDetermine,
    );
  }

  GetLocationState copyWith({
    Position? position,
    LocationPermission? permission,
  }) {
    return GetLocationState(
      position: position ?? this.position,
      permission: permission ?? this.permission,
    );
  }
}