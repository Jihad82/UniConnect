import 'package:flutter/material.dart';
import 'package:uniconnect/CustomDesign/AppBar.dart';
import 'package:uniconnect/CustomDesign/custom_navbar.dart';
import 'package:uniconnect/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Learningsupporthome extends StatefulWidget {
  const Learningsupporthome({super.key});

  @override
  _LearningsupporthomeState createState() => _LearningsupporthomeState();
}

class _LearningsupporthomeState extends State<Learningsupporthome> {
  String selectedFilter = 'All';
  String searchQuery = '';

  Stream<QuerySnapshot> _getFilteredCourses() {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection('courses');
    if (selectedFilter != 'All') {
      query = query.where('category', isEqualTo: selectedFilter);
    }
    if (searchQuery.isNotEmpty) {
      query = query.where('title', isGreaterThanOrEqualTo: searchQuery).where('title', isLessThanOrEqualTo: searchQuery + '\uf8ff');
    }
    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Learning Support', showBackArrow: true, actionWidgets: []),
      bottomNavigationBar: const CustomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Find Course',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),

            // Filter Section
            const Text(
              'Choose your course',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.PrimaryColors,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterChip(
                  label: const Text('All Courses'),
                  selected: selectedFilter == 'All',
                  selectedColor: AppColors.PrimaryColors.withOpacity(.2),
                  onSelected: (bool selected) {
                    setState(() {
                      selectedFilter = 'All';
                    });
                  },
                ),
                FilterChip(
                  label: const Text('Popular'),
                  selected: selectedFilter == 'Popular',
                  selectedColor: AppColors.PrimaryColors.withOpacity(.2),
                  onSelected: (bool selected) {
                    setState(() {
                      selectedFilter = 'Popular';
                    });
                  },
                ),
                FilterChip(
                  label: const Text('New'),
                  selected: selectedFilter == 'New',
                  selectedColor: AppColors.PrimaryColors.withOpacity(.2),
                  onSelected: (bool selected) {
                    setState(() {
                      selectedFilter = 'New';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Course Cards
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _getFilteredCourses(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(
                      color: AppColors.PrimaryColors,
                    ));
                  }

                  List<DocumentSnapshot> courses = snapshot.data!.docs.where((doc) {
                    var course = doc.data() as Map<String, dynamic>;
                    return course['title'].toString().toLowerCase().contains(searchQuery);
                  }).toList();

                  return ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      var course = courses[index].data() as Map<String, dynamic>;
                      return CourseCard(
                        title: course['title'],
                        subtitle: course['subtitle'],
                        price: course['price'],
                        duration: course['duration'],
                        imageUrl: course['imageUrl'],
                        downloadUrl: course['downloadUrl'],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String duration;
  final String imageUrl;
  final String downloadUrl;

  const CourseCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.duration,
    required this.imageUrl,
    required this.downloadUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.price_change_outlined, size: 14, color: Colors.green),
                      const SizedBox(width: 4),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        launch(downloadUrl);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                        backgroundColor: AppColors.PrimaryColors, // Use app's primary color
                      ),
                      child: const SizedBox(
                        width: 100,
                        height: 20, // Set your desired width here
                        child: Center(
                          child: Text(
                            'Start learning',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
