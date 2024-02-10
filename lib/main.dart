import 'package:flutter/material.dart';
import 'package:google_maps_guide/widgets/custom_google_map.dart';

void main() {
  runApp(const GoogleMapsGuide());
}

class GoogleMapsGuide extends StatelessWidget {
  const GoogleMapsGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CustomGoogleMap(),
    );
  }
}
