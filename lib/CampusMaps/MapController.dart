// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter/material.dart';
//
// class MapController extends GetxController {
//   var markers = <Marker>[].obs;
//   var userLocation = LatLng(0, 0).obs;
//   late GoogleMapController mapController;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _determinePosition();
//     _addMarkers();
//   }
//
//   void onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   Future<void> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled, don't continue
//       // Show an alert dialog to request the user to enable location services
//       Get.defaultDialog(
//         title: "Location Services Disabled",
//         middleText: "Please enable location services to continue.",
//         onConfirm: () => Get.back(),
//         textConfirm: "OK",
//       );
//       return;
//     }
//
//     // Request permission to access location data.
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, don't continue
//         // Show an alert dialog to request the user to grant location permission
//         Get.defaultDialog(
//           title: "Location Permission Denied",
//           middleText: "Please grant location permission to continue.",
//           onConfirm: () => Get.back(),
//           textConfirm: "OK",
//         );
//         return;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately
//       // Show an alert dialog to request the user to grant location permission
//       // in app settings
//       Get.defaultDialog(
//         title: "Location Permission Denied Forever",
//         middleText: "Please grant location permission in app settings to continue.",
//         onConfirm: () => Get.back(),
//         textConfirm: "OK",
//       );
//       return;
//     }
//
//     // Get the current location.
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     userLocation.value = LatLng(position.latitude, position.longitude);
//   }
//
//   void _addMarkers() {
//     var buildings = [
//       {'name': 'Building 1', 'lat': 37.42796133580664, 'lng': -122.085749655962},
//       {'name': 'Building 2', 'lat': 37.42896133580664, 'lng': -122.086749655962},
//       // Add more buildings here
//     ];
//
//     markers.value = buildings.map((building) {
//       // Ensure 'lat' and 'lng' are actually doubles, then cast
//       double lat = building['lat'] is double ? building['lat'] as double : 0.0;
//       double lng = building['lng'] is double ? building['lng'] as double : 0.0;
//
//       // Ensure 'name' is a String before using it
//       String? name = building['name'] is String ? building['name'] as String : null;
//
//       return Marker(
//         markerId: MarkerId(name!),  // Use the checked 'name'
//         position: LatLng(lat, lng),
//         infoWindow: InfoWindow(title: name ?? "Unknown"), // Use "Unknown" if 'name' is null
//       );
//     }).toList();
//   }
// }
