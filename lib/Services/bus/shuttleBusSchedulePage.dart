import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniconnect/utils/colors.dart';
import '../../CustomDesign/custom_navbar.dart';


class ShuttleBusSchedulePage extends StatelessWidget {
  final List<Map<String, String>> routes = [
    {"routeName": "Route-1", "routeDetails": "Gausia to GUB ", "pickupTime": " "},
    {"routeName": "Route-2", "routeDetails": "Kuril to GUB ", "pickupTime": " "},
  ];

  ShuttleBusSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.PrimaryColors),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Transportation Routes',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          return RouteCard(
            routeName: route["routeName"]!,
            routeDetails: route["routeDetails"]!,
            pickupTime: route["pickupTime"]!,
            routeIndex: index,
          );
        },
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}

class RouteCard extends StatelessWidget {
  final String routeName;
  final String routeDetails;
  final String pickupTime;
  final int routeIndex;

  const RouteCard({
    super.key,
    required this.routeName,
    required this.routeDetails,
    required this.pickupTime,
    required this.routeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Image.asset('assets/images/busicon.png', width: 50), // Replace with your image path
        title: Text(
          routeName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              routeDetails,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              'Pickup Time: $pickupTime',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: TextButton(
          onPressed: () {
            Get.toNamed('/shuttleRoutes$routeIndex');
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View Details',
                style: TextStyle(color: AppColors.PrimaryColors),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.PrimaryColors,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
