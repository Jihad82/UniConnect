import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniconnect/utils/colors.dart';

import '../Profile/Controller/profile_controller.dart';

class WelcomeUser extends StatefulWidget {
  const WelcomeUser({super.key});

  @override
  State<WelcomeUser> createState() => _WelcomeUserState();
}

class _WelcomeUserState extends State<WelcomeUser> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Row(
              children: [
                const Text(
                  'Hello,',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.PrimaryColors),
                ),
                Image.asset(
                  'assets/images/hello.png', // Replace with your image path
                  width: 20, // Adjust the width as needed
                  height: 20, // Adjust the height as needed
                ),
                Text(
                  profileController.fullName.value,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.PrimaryColors),
                ),
              ],
            )),
            const Text(
              'Welcome to Uniconnect',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
