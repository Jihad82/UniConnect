import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        // Assuming you have a CustomAppBar widget, replace if needed
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'About UniConnect-Your University Hub',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              'UniConnect-Your University Hub is a mobile app created for the Green University of Bangladesh. '
              'It aims to be a comprehensive platform connecting students, faculty, and administration, enhancing the overall academic experience. '
              'This project is part of our final year project, focusing on improving communication and collaboration within the university community.',
              style: TextStyle(
                fontSize: 16.0,
                height: 1.6,
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              'Developers',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.0),
            _DeveloperProfile(
              name: 'Abrar Jihad',
              role: 'Mobile App Developer',
              imageAsset:
                  'assets/images/devloper.jpeg', // Replace with actual asset path
              linkedIn: 'https://www.linkedin.com/in/abrar-jihad',
              github: 'https://github.com/Jihad82',
              facebook: 'https://www.facebook.com/zihadzz.zz',
            ),
          ],
        ),
      ),
    );
  }
}

class _DeveloperProfile extends StatelessWidget {
  final String name;
  final String role;
  final String imageAsset;
  final String linkedIn;
  final String github;
  final String facebook;

  const _DeveloperProfile({
    required this.name,
    required this.role,
    required this.imageAsset,
    required this.linkedIn,
    required this.github,
    required this.facebook,
  });

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 36.0,
            backgroundImage: AssetImage(imageAsset),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: <Widget>[
                    _SocialLinkButton(
                      icon: LineIcons.linkedin,
                      onPressed: () {
                        _launchUrl(linkedIn);
                      },
                    ),
                    const SizedBox(width: 8.0),
                    _SocialLinkButton(
                      icon: LineIcons.github,
                      onPressed: () {
                        _launchUrl(github);
                      },
                    ),
                    const SizedBox(width: 8.0),
                    _SocialLinkButton(
                      icon: LineIcons.facebook,
                      onPressed: () {
                        _launchUrl(facebook);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialLinkButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _SocialLinkButton({
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: Colors.blue,
    );
  }
}
