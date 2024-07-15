import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.PrimaryColors,
      unselectedItemColor: Colors.black45,
      currentIndex: Get.currentRoute == '/home'
          ? 0
          : Get.currentRoute == '/notice'
          ? 1
          : Get.currentRoute == '/events'
          ? 2
          : Get.currentRoute == '/profile'
          ? 3
          : 0,
      onTap: (index) {
        switch (index) {
          case 0:
            Get.toNamed('/home');
            break;
          case 1:
            Get.toNamed('/notice');
            break;
          case 2:
            Get.toNamed('/events');
            break;
          case 3:
            Get.toNamed('/profile');
            break;
        }
      },
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),

        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/notice.svg',
            height: 20, // Adjust the height as needed
            width: 20, // Adjust the width as needed
            fit: BoxFit.scaleDown,
            color: Get.currentRoute == '/notice' ? AppColors.PrimaryColors : Colors.black45, // Set the color based on selection
          ),
          label: 'Notice',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/svgs/event.svg',
            height: 20, // Adjust the height as needed
            width: 20, // Adjust the width as needed
            fit: BoxFit.scaleDown,
            color: Get.currentRoute == '/events' ? AppColors.PrimaryColors : Colors.black45, // Set the color based on selection
          ),
          label: 'Events',
        ),

        const BottomNavigationBarItem(icon: Icon(Symbols.person), label: 'Profile'),
      ],
    );
  }
}