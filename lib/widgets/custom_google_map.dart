import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_guide/utils/location_service.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late LocationService locationService;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(
        30.78357146997099,
        30.982883674356408,
      ),
      zoom: 15,
    );
    locationService = LocationService();

    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: true,
      markers: markers,
      initialCameraPosition: initialCameraPosition,
      onMapCreated: (controller) {
        googleMapController = controller;
        updateCurrentLocation();
      },
    );
  }

  void updateCurrentLocation() async {
    try {
      var locationData = await locationService.getUserLocation();
      LatLng currentPosition =
          LatLng(locationData.latitude!, locationData.longitude!);
      CameraPosition cameraPosition =
          CameraPosition(target: currentPosition, zoom: 16);
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          cameraPosition,
        ),
      );
      Marker currentocationMarker = Marker(
        markerId: MarkerId('current location marker'),
        position: currentPosition,
      );
      markers.add(currentocationMarker);
      setState(() {});
    } on LocationServiceExecption catch (e) {
    } on LocationPermissionExecption catch (e) {
    } catch (e) {}
  }
}

// zoom properties
// world view 0 => 3
// country view 4 => 6
// city view 10 => 12
// street view 13 => 17
// building view 18 => 20
