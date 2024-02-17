import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  Future<void> checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      bool secondCheckIsServiceEnabled = await location.requestService();
      if (!secondCheckIsServiceEnabled) {
        throw LocationServiceExecption();
      }
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw LocationPermissionExecption();
    }
    if (permissionStatus == PermissionStatus.denied) {
      PermissionStatus secondCheckPermissionStatus =
          await location.requestPermission();
      if (secondCheckPermissionStatus != PermissionStatus.granted) {
        throw LocationPermissionExecption();
      }
    }
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    location.changeSettings(
      distanceFilter: 2, // كل 2 متر
    );
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getUserLocation() async {
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    return await location.getLocation();
  }
}

class LocationServiceExecption implements Exception {}

class LocationPermissionExecption implements Exception {}
