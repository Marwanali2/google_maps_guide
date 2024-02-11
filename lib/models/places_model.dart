import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> placesList = [
  PlaceModel(
    id: 1,
    name: 'مستشفي الحياة',
    latLng: const LatLng(
      30.791158710184114,
      30.980545478109143,
    ),
  ),
  PlaceModel(
    id: 2,
    name: 'شركة القادسية',
    latLng: const LatLng(
      30.79096414272318,
      30.986286700525568,
    ),
  ),
  PlaceModel(
    id: 3,
    name: 'حلويات دهب',
    latLng: const LatLng(
      30.816368038782773,
      30.993124024911737,
    ),
  ),
];
