import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_guide/utils/location_service.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late LocationService locationService;
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  late Location location;
  Set<Marker> markers = {};
  bool isFirstCall = true;
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

    //checkAndRequestLocationService();
    updateMyLocation();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        onMapCreated: (controller) {
          googleMapController = controller;
          initMapStyle();
        },
      ),
      Positioned(
        bottom: 16,
        left: 55,
        right: 55,
        child: ElevatedButton(
          onPressed: () {
            googleMapController!.animateCamera(
              CameraUpdate.newLatLng(
                const LatLng(
                  30.6,
                  30.1,
                ),
              ),
            );
          },
          child: const Text(
            'Change Location',
          ),
        ),
      )
    ]);
  }

  void initMapStyle() async {
    googleMapController = googleMapController;
    var darkMapStyle = await DefaultAssetBundle.of(context).loadString(
      'assets/map_styles/dark_theme_map_style.json',
    ); // بتعمل لوود للأسيت بحيث يرجع كإسترنج عشان ابعته لميثود ال سيتماب استايل
    googleMapController!.setMapStyle(darkMapStyle);
  }

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationService.getLocationData((locationData) {
        setMyMarker(locationData);
        setMyCameraPosition(locationData);
      });
    } else {}
  }

  void setMyCameraPosition(LocationData locationData) {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: 17,
    );
    if (isFirstCall) {
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
      isFirstCall = false;
    } else {
      googleMapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!),
        ),
      );
    }
  }

  void setMyMarker(LocationData locationData) {
    Marker myMarker = Marker(
      markerId: const MarkerId(
        'my location marker',
      ),
      position: LatLng(locationData.latitude!, locationData.longitude!),
    );
    markers.add(myMarker);
    setState(() {});
  }
}

// zoom properties
// world view 0 => 3
// country view 4 => 6
// city view 10 => 12
// street view 13 => 17
// building view 18 => 20
