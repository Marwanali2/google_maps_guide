import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(
        30.78357146997099,
        30.982883674356408,
      ),
      zoom: 16,
    );

    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (controller) {
          googleMapController = controller;
          initMapStyle();
        },
        /* cameraTargetBounds: CameraTargetBounds(
          // حدود الماب اللي اليوزر ميخرجش عنها
          LatLngBounds(
            northeast: const LatLng(
              31.5,
              29.7,
            ),
            southwest: const LatLng(
              31.3,
              30.1,
            ),
          ),
        ), */
      ),
      Positioned(
        bottom: 16,
        left: 55,
        right: 55,
        child: ElevatedButton(
          onPressed: () {
            googleMapController.animateCamera(
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
    var strangerThingMapStyle = await DefaultAssetBundle.of(context).loadString(
      'assets/map_styles/Stranger_Thing_map_style.json',
    ); // بتعمل لوود للأسيت بحيث يرجع كإسترنج عشان ابعته لميثود ال سيتماب استايل
    googleMapController.setMapStyle(strangerThingMapStyle);
  }
}
// zoom properties
// world view 0 => 3
// country view 4 => 6
// city view 10 => 12
// street view 13 => 17
// building view 18 => 20