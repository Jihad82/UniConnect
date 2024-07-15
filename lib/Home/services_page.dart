import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
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
                children: const [
                  ServiceCard(icon: Icons.computer, label: 'Tutoring and Freelance'),
                  ServiceCard(icon: Icons.support, label: 'Online Learning Support'),
                  ServiceCard(icon: Icons.work, label: 'Career and Opportunities'),
                  ServiceCard(icon: Icons.language, label: 'News and Media'),
                  ServiceCard(icon: Icons.warning, label: 'Emergency Preparedness'),
                  ServiceCard(icon: Icons.palette, label: 'Arts and Culture Events'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        dense: true,
      ),
    );
  }
}
