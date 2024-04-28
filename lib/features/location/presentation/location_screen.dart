import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'location_notifier.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final locationState = ref.watch(locationProvider);
    final locationNotifier = ref.read(locationProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (locationState.position != null)
            Text('Latitude: ${locationState.position!.latitude.toStringAsFixed(4)}'),
          if (locationState.position != null)
            Text('Longitude: ${locationState.position!.longitude.toStringAsFixed(4)}'),
          ElevatedButton(
            onPressed: () => locationNotifier.getLocation(),
            child: const Text('Locate Me'),
          ),
        ],
      ),),
    );
  }
}