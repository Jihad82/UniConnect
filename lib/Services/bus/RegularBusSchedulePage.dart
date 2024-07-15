import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniconnect/utils/colors.dart';
import '../../CustomDesign/custom_navbar.dart'; // Ensure this file exists

class RegularBusSchedulePage extends StatelessWidget {
  final List<Map<String, String>> routes = [
    {"routeName": "Route-1", "routeDetails": "Shewrapara", "pickupTime": "7:00 AM"},
    {"routeName": "Route-2", "routeDetails": "Shawrapara", "pickupTime": "7:10 AM"},
    {"routeName": "Route-3", "routeDetails": "Shymoli ", "pickupTime": "6:45 AM"},
    {"routeName": "Route-4", "routeDetails": "Azimpur ", "pickupTime": "6:45 AM"},
    {"routeName": "Route-5", "routeDetails": "Motijheel | Malibag ", "pickupTime": "6:45 AM"},
    {"routeName": "Route-6", "routeDetails": "Gulistan ", "pickupTime": "6:45 AM"},
    {"routeName": "Route-7", "routeDetails": "Shanir Akhra ", "pickupTime": "6:45 AM"},
    {"routeName": "Route-8", "routeDetails": "Chashara ", "pickupTime": "6:45 AM"},
    {"routeName": "Route-9", "routeDetails": "Narshingdi ", "pickupTime": "6:45 AM"},
    {"routeName": "Route-10", "routeDetails": "Gazipur | Abdullahpur", "pickupTime": "6:45 AM"},
    {"routeName": "Route-11", "routeDetails": "Mograpara", "pickupTime": "7:20 AM"},
    {"routeName": "Route-11", "routeDetails": "Bishnondi Taltola ", "pickupTime": "7:20 AM"},
  ];

  RegularBusSchedulePage({super.key});

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
          'Regular Transportation Routes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Container(
          height: 100, // Ensuring consistent size
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset('assets/images/busicon.png', width: 50), // Replace with your image path
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      routeName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.share_location_sharp, size: 16, color: AppColors.PrimaryColors),
                        const SizedBox(width: 4),
                        Text(
                          routeDetails,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: AppColors.PrimaryColors),
                        const SizedBox(width: 4),
                        Text(
                          pickupTime,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed('/routes$routeIndex');
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View',
                      style: TextStyle(color: AppColors.PrimaryColors, fontSize: 13),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.PrimaryColors,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
