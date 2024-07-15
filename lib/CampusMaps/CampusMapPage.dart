// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'MapController.dart';
//
// class MapScreen extends StatelessWidget {
//   final MapController mapController = Get.put(MapController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Campus Map'),
//         backgroundColor: Colors.blue,
//       ),
//       body: Obx(() {
//         return GoogleMap(
//           onMapCreated: mapController.onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: mapController.userLocation.value,
//             zoom: 14.0,
//           ),
//           markers: Set<Marker>.of(mapController.markers),
//           myLocationEnabled: true,
//         );
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           mapController.mapController.animateCamera(
//             CameraUpdate.newLatLng(mapController.userLocation.value),
//           );
//         },
//         child: Icon(Icons.my_location),
//         backgroundColor: Colors.blue,
//       ),
//     );
//   }
// }
