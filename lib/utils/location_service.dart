import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  Future<bool> checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      bool secondCheckIsServiceEnabled = await location.requestService();
      if (!secondCheckIsServiceEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkAndRequestLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      PermissionStatus secondCheckPermissionStatus =
          await location.requestPermission();
      return secondCheckPermissionStatus == PermissionStatus.granted;
    }
    return true;
  }

  void getLocationData(void Function(LocationData)? onData) {
     location.changeSettings(
      distanceFilter: 2, // كل 2 متر
    );
    location.onLocationChanged.listen(onData);
  }
}
