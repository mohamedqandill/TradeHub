import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> checkAndRequestLocationService() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }
    return true;
  }

  Future<bool> checkAndRequestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return false;
      }
    }
    return true;
  }

  static Stream<Position> get onLocationChanged {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 2,
      ),
    );
  }

  Future<bool> isServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<Position?> getCurrentLocation({int retries = 3}) async {
    for (int i = 0; i < retries; i++) {
      try {
        bool hasPermission = await checkAndRequestPermission();
        bool isServiceEnabled = await checkAndRequestLocationService();
        
        if (!hasPermission || !isServiceEnabled) {
          log("❌ Permission or Service denied.");
          return null;
        }

        return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 10),
        );
      } catch (e) {
        log("❌ Failed to get current location (Attempt ${i + 1}): $e");
        if (i < retries - 1) {
          await Future.delayed(const Duration(seconds: 2));
        }
      }
    }
    return null;
  }
}
