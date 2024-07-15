import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../AuthService/AuthController/auth_controller.dart';
import 'Controller/profile_controller.dart';
import '../CustomDesign/custom_navbar.dart';
import '../utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.find<ProfileController>();

  Future<void> _launchEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch $email';
    }
  }

  Future<void> _launchFacebookGroup(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> _fetchShareLinkFromFirebase() async {
    try {
      // Initialize Firebase if not already initialized
      await Firebase.initializeApp();

      // Replace 'links' with your Firebase collection name where the link is stored
      var snapshot = await FirebaseFirestore.instance.collection('shareApplinks').doc('appLink').get();

      if (snapshot.exists) {
        return snapshot.data()?['link'] ?? 'https://www.facebook.com/groups/1055681205979060';
      } else {
        throw 'Link not found in Firebase';
      }
    } catch (e) {
      print('Error fetching link: $e');
      return 'https://www.facebook.com/groups/1055681205979060'; // Default link if fetching fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
                () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: profileController.profilePictureUrl.value.isNotEmpty
                          ? NetworkImage(profileController.profilePictureUrl.value)
                          : const AssetImage('assets/images/user.png') as ImageProvider<Object>,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileController.fullName.value,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Student ID: ${profileController.studentId.value}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Email: ${profileController.email.value}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Department: ${profileController.department.value}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.PrimaryColors,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: const Text('Account'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.toNamed('/edit_profile');
                  },
                ),
                const SizedBox(height: 10),
                // Contact Section
                _ContactItem(
                  icon: Icons.mail,
                  title: 'Mail & DMCA',
                  subtitle: 'uniconnect.gub@gmail.com',
                  onTap: () {
                    _launchEmail('uniconnect.gub@gmail.com');
                  },
                ),
                const SizedBox(height: 10),
                _ContactItem(
                  icon: Icons.facebook,
                  title: 'Facebook',
                  subtitle: 'Join our Facebook Group',
                  onTap: () {
                    _launchFacebookGroup('https://www.facebook.com/groups/1055681205979060');
                  },
                ),
                const SizedBox(height: 10),
                _ContactItem(
                  icon: Icons.share_outlined,
                  title: 'Share App',
                  subtitle: 'Share With Your Friends',
                  onTap: () async {
                    String shareLink = await _fetchShareLinkFromFirebase();
                    if (await canLaunch(shareLink)) {
                      await launch(shareLink);
                    } else {
                      throw 'Could not launch $shareLink';
                    }
                  },
                ),

                const Spacer(),
                Divider(color: Colors.green[100]),
                ListTile(
                  leading: const Icon(Icons.logout, color: AppColors.PrimaryColors),
                  title: const Text('Logout'),
                  onTap: () {
                    authController.logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.PrimaryColors,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}
