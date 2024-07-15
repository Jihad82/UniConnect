import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniconnect/Services/bus/SpecialBusSchedulePage.dart';
import 'package:uniconnect/Services/bus/shuttleBusSchedulePage.dart';
import '../../CustomDesign/custom_navbar.dart';
import '../../utils/colors.dart';
import 'ExamBusSchedulePage.dart';
import 'RegularBusSchedulePage.dart';

class TransportationServices extends StatelessWidget {
  const TransportationServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transportation Services', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color:AppColors.PrimaryColors),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                crossAxisCount: 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 4, // Adjusted for smaller size
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  ServiceCard(
                    icon: Icons.directions_bus,
                    label: 'Regular Bus Schedule',
                    subtitle: 'Daily and frequent',
                    onTap: () {
                      Get.to(RegularBusSchedulePage());
                    },
                  ),
                  ServiceCard(
                    icon: Icons.directions_bus,
                    label: 'Shuttle Bus Schedule',
                    subtitle: 'Campus and city routes',
                    onTap: () {
                      Get.to(ShuttleBusSchedulePage());

                    },
                  ),
                  ServiceCard(
                    icon: Icons.directions_bus,
                    label: 'Exam Bus Schedule',
                    subtitle: 'Exam period timings',
                    onTap: () {
                      Get.to( ExamBusSchedulePage());
                    },
                  ),
                  ServiceCard(
                    icon: Icons.directions_bus,
                    label: 'Special Bus Schedule',
                    subtitle: 'Events and holidays',
                    onTap: () {
                      Get.to( SpecialBusSchedulePage());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.PrimaryColors,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          subtitle: Text(subtitle),
          dense: true,
        ),
      ),
    );
  }
}
