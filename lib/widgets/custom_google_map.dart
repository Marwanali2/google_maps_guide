import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_guide/models/places_model.dart';
import 'dart:ui' as ui;

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Set<Polygon> polygons = {};
  Set<Circle> circles = {};
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(
        30.78357146997099,
        30.982883674356408,
      ),
      zoom: 15,
    );
    initMarkers();
    initPolylines();
    initPolygons();
    initCircles();
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
        polylines: polylines,
        polygons: polygons,
        circles: circles,
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
        markers: markers,
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
      'assets/map_styles/dark_theme_map_style.json',
    ); // بتعمل لوود للأسيت بحيث يرجع كإسترنج عشان ابعته لميثود ال سيتماب استايل
    googleMapController.setMapStyle(strangerThingMapStyle);
  }

// بستخدم الميثود دي في حالو لو عندي صورة عايز اتحكم في حجمها
  Future<Uint8List> getImageFromRawData(String image, double width) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetWidth: width.round(),
    ); // عشان اتحكم في الصورة و ابعادها
    var imageFrameInfo =
        await imageCodec.getNextFrame(); //معلومات الصورة بتاعتنا
    var imageByteData =
        await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return imageByteData!.buffer.asUint8List();
  }

  void initMarkers() async {
    // BitmapDescriptor.fromBytes()
    var customMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        "assets/images/mod-google-maps.png"); //دي صورة حجمها نازل مظبوط فانا مش محتاج الميثود خلاص
    /*BitmapDescriptor.fromBytes( // بستخدم الميثود دي في حالو لو عندي صورة عايز اتحكم في حجمها
      await getImageFromRawData(
        "assets/images/google-maps.png",
        100,
      ),
    ); */
    var myMarkers = placesList
        .map(
          (placeModel) => Marker(
            icon: customMarker,
            markerId: MarkerId(
              placeModel.id.toString(),
            ),
            position: placeModel.latLng,
            infoWindow: InfoWindow(
              title: placeModel.name,
            ),
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }

  void initPolylines() {
    /* Polyline polyline = Polyline(
        polylineId: const PolylineId(
          '1',
        ),
        color: Colors.amber,
        width: 5,
        zIndex: 2,
        geodesic: true,
        patterns: [PatternItem.dot, PatternItem.dash(2), PatternItem.gap(3)],
        startCap: Cap.roundCap,
        points: const [
          LatLng(
            30.791158710184114,
            30.980545478109143,
          ),
          LatLng(
            30.79096414272318,
            30.986286700525568,
          ),
          LatLng(
            30.79096414272318,
            30.986286700525568,
          ),
          LatLng(
            30.816368038782773,
            30.993124024911737,
          ),
        ]);
    Polyline polyline2 = const Polyline(
        polylineId: PolylineId(
          '1',
        ),
        color: Colors.white,
        width: 5,
        zIndex: 1,
        startCap: Cap.roundCap,
        points: [
          LatLng(
            30.78357146997099,
            30.982883674356408,
          ),
          LatLng(
            30.816368038782773,
            30.993124024911737,
          ),
        ]);
    polylines.addAll({polyline, polyline2}); */
  }

  void initPolygons() {
    /*
    Polygon polygon = Polygon(
      polygonId: const PolygonId(
        '1',
      ),
      fillColor: Colors.red.withOpacity(0.5),
      strokeColor: Colors.red.withOpacity(0.8),
      strokeWidth: 5,
      
      points: const [
        LatLng(
          30.791158710184114,
          30.980545478109143,
        ),
        LatLng(
          30.79096414272318,
          30.986286700525568,
        ),
        LatLng(
          30.79096414272318,
          30.986286700525568,
        ),
        LatLng(
          30.816368038782773,
          30.993124024911737,
        ),
      ],
    );
    polygons.addAll({polygon});
  */
  }

  void initCircles() {
    Circle dahabServiceircle = Circle(
      circleId: const CircleId(
        '1',
      ),
      center: const LatLng(
        30.816368038782773,
        30.993124024911737,
      ),
      radius: 1000,
      fillColor: Colors.green.withOpacity(0.5),
      strokeColor: Colors.black.withOpacity(0.5),
      strokeWidth: 5,
    );
    circles.add(dahabServiceircle);
  }
}

// zoom properties
// world view 0 => 3
// country view 4 => 6
// city view 10 => 12
// street view 13 => 17
// building view 18 => 20
