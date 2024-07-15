import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniconnect/utils/colors.dart';

class AppDrawer extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _checkForUpdate(BuildContext context) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('app_config').doc('update_url').get();
      if (snapshot.exists && snapshot.data() != null) {
        String? url = snapshot['url'];
        if (url != null && await canLaunch(url)) {
          await launch(url);
        } else {
          _showNoUpdateAvailableDialog(context);
        }
      } else {
        _showNoUpdateAvailableDialog(context);
      }
    } catch (e) {
      _showNoUpdateAvailableDialog(context);
    }
  }

  void _showNoUpdateAvailableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.crisis_alert, color: Colors.red),
            SizedBox(width: 10),
            Text('Update Not Available'),
          ],
        ),
        content: const Text('No updates are available at the moment.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 150,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/Uniconnect_Logo-removebg-preview.png',
                  height: 60,
                  width: 60,
                ),
                const SizedBox(height: 10),
                const Text(
                  'UNICONNECT',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.PrimaryColors,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.PrimaryColors),
            title: const Text('Back to Home'),
            onTap: () {
              Get.toNamed('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people, color: AppColors.PrimaryColors),
            title: const Text('About Us'),
            onTap: () {
              Get.toNamed('/about_us');
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: AppColors.PrimaryColors),
            title: const Text('Rate The App'),
            onTap: () {
              Get.toNamed('/rate');
            },
          ),
          ListTile(
            leading: const Icon(Icons.update, color: AppColors.PrimaryColors),
            title: const Text('Updates'),
            onTap: () {
              _checkForUpdate(context);
            },
          ),
          const SizedBox(
            height: 150,
          ),
          Divider(color: Colors.green[100]),
          ListTile(
            leading:
                const Icon(Icons.exit_to_app, color: AppColors.PrimaryColors),
            title: const Text('Exit'),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
