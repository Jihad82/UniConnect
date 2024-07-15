import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniconnect/Services/Department/BBA_Pages.dart';
import 'package:uniconnect/Services/Department/Clcscenter_Pages.dart';
import 'package:uniconnect/Services/Department/ENG_Pages.dart';
import 'package:uniconnect/Services/Department/JMC_Pages.dart';
import 'package:uniconnect/Services/Department/Law_Pages.dart';
import 'package:uniconnect/Services/Department/Offices_pages.dart';
import 'package:uniconnect/Services/Department/Sociology_Anthropology_Pages.dart';
import 'package:uniconnect/Services/Department/TEX_Pages.dart';
import 'package:uniconnect/utils/colors.dart';
import '../CustomDesign/custom_navbar.dart';

class FacultyStaff extends StatelessWidget {
  const FacultyStaff({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty and Staff', style: TextStyle(color: Colors.black,fontSize: 16)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.PrimaryColors),
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
              const Text(
                'Department',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DepartmentCard(
                    title: 'Computer Science and Engineering',
                    assetPath: 'assets/images/cse.png',
                    onPressed: () => Get.toNamed('/csedepartment'),
                  ),
                  DepartmentCard(
                    title: 'Electrical and Electronic Engineering',
                    assetPath: 'assets/images/eee.png',
                    onPressed: () => Get.toNamed('/eee'),
                  ),
                  DepartmentCard(
                    title: 'Department of Textile',
                    assetPath: 'assets/images/tex.png',
                    onPressed: () => Get.to(const TexPages()),
                  ),
                  DepartmentCard(
                    title: 'Department of Business Administration',
                    assetPath: 'assets/images/gbs.png',
                    onPressed: () => Get.to(const BbaPages()),
                  ),
                  DepartmentCard(
                    title: 'Department of English',
                    assetPath: 'assets/images/eng.png',
                    onPressed: () => Get.to(const ENGPages()),
                  ),
                  DepartmentCard(
                    title: 'Department of Law',
                    assetPath: 'assets/images/law.png',
                    onPressed: () => Get.to(const LawPages()),
                  ),
                  DepartmentCard(
                    title: 'Department of Sociology and Anthropology',
                    assetPath: 'assets/images/soc.png',
                    onPressed: () => Get.to(const Sociology_AnthropologyPages()),
                  ),
                  DepartmentCard(
                    title: 'Department of Journalism and Media Communication',
                    assetPath: 'assets/images/jmc.png',
                    onPressed: () => Get.to(const JMCPages()),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Center',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              DepartmentCard(
                title: 'Center for Language and Cultural Studies',
                assetPath: 'assets/images/clcs.png',
                onPressed: () => Get.to(const ClcsPages()),
              ),
              const SizedBox(height: 32),
              const Text(
                'Offices',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              DepartmentCard(
                title: 'Gub offices and Administrative officers',
                assetPath: 'assets/images/office.png',
                onPressed: () => Get.to(const Officespages()),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}

class DepartmentCard extends StatelessWidget {
  final String title;
  final String assetPath;
  final VoidCallback onPressed;

  const DepartmentCard({
    Key? key,
    required this.title,
    required this.assetPath,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Use onPressed for GestureDetector
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset(
                assetPath,
                height: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const Icon(Icons.arrow_forward, color: AppColors.PrimaryColors),
            ],
          ),
        ),
      ),
    );
  }
}