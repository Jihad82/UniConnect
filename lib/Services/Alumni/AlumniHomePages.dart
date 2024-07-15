import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniconnect/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AlumniHomePages extends StatefulWidget {
  const AlumniHomePages({Key? key}) : super(key: key);

  @override
  _AlumniHomePagesState createState() => _AlumniHomePagesState();
}

class _AlumniHomePagesState extends State<AlumniHomePages> {
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<Map<String, dynamic>> allJobs = [];
  final List<Map<String, dynamic>> allEvents = [];
  final List<Map<String, dynamic>> allNews = [];

  @override
  void initState() {
    super.initState();
    _fetchJobs();
    _fetchEvents();
    _fetchNews();
  }

  Future<void> _fetchJobs() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('jobs').get();
      allJobs.clear();
      for (var doc in querySnapshot.docs) {
        allJobs.add(doc.data() as Map<String, dynamic>);
      }
      setState(() {});
    } catch (e) {
      // Handle error appropriately
    }
  }

  Future<void> _fetchEvents() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('events').get();
      allEvents.clear();
      for (var doc in querySnapshot.docs) {
        allEvents.add(doc.data() as Map<String, dynamic>);
      }
      setState(() {});
    } catch (e) {
      // Handle error appropriately
    }
  }

  Future<void> _fetchNews() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('news').get();
      allNews.clear();
      for (var doc in querySnapshot.docs) {
        allNews.add(doc.data() as Map<String, dynamic>);
      }
      setState(() {});
    } catch (e) {
      // Handle error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumni', style: TextStyle(color: AppColors.PrimaryColors)),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontSize: 16,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height:5),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),

            const SizedBox(height:5),

            // Filter Section
            const Text(
              'Filter by',
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
                _buildFilterChip('All'),
                _buildFilterChip('Jobs'),
                _buildFilterChip('Events'),
                _buildFilterChip('News'),
              ],
            ),

            const SizedBox(height: 20),

            // Sections: Jobs, Events, News
            Expanded(
              child: ListView(
                children: _buildFilteredContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return FilterChip(
      
      label: Text(label),
      selected: selectedFilter == label,
      selectedColor: AppColors.PrimaryColors.withOpacity(.2),
      onSelected: (bool selected) {
        setState(() {
          selectedFilter = label;
        });
      },
    );
  }

  List<Widget> _buildFilteredContent() {
    List<Map<String, dynamic>> filteredJobs = allJobs.where((job) {
      return job['jobTitle'].toLowerCase().contains(searchQuery) ||
          job['companyName'].toLowerCase().contains(searchQuery) ||
          job['location'].toLowerCase().contains(searchQuery) ||
          job['jobType'].toLowerCase().contains(searchQuery);
    }).toList();

    List<Map<String, dynamic>> filteredEvents = allEvents.where((event) {
      return event['eventName'].toLowerCase().contains(searchQuery) ||
          event['subtitle'].toLowerCase().contains(searchQuery) ||
          event['description'].toLowerCase().contains(searchQuery);
    }).toList();

    List<Map<String, dynamic>> filteredNews = allNews.where((notice) {
      return notice['title'].toLowerCase().contains(searchQuery) ||
          notice['description'].toLowerCase().contains(searchQuery);
    }).toList();

    switch (selectedFilter) {
      case 'All':
        return [
          ..._buildJobCards(filteredJobs),
          ..._buildEventsList(filteredEvents),
          ..._buildNoticesList(filteredNews),
        ];
      case 'Jobs':
        return _buildJobCards(filteredJobs);
      case 'Events':
        return _buildEventsList(filteredEvents);
      case 'News':
        return _buildNoticesList(filteredNews);
      default:
        return [];
    }
  }

  List<Widget> _buildJobCards(List<Map<String, dynamic>> jobs) {
    return jobs.map((job) => JobCard(
      companyLogo: job['companyLogo'],
      jobTitle: job['jobTitle'],
      companyName: job['companyName'],
      location: job['location'],
      jobType: job['jobType'],
      salary: job['salary'],
      benefits: job['benefits'],
      applyLink: job['applyLink'],
    )).toList();
  }

  List<Widget> _buildEventsList(List<Map<String, dynamic>> events) {
    return events.map((event) => EventCard(
      title: event['eventName'],
      subtitle: event['subtitle'],
      imageUrl: event['imageUrl'],
      description: event['description'],
      learnMoreLink: event['learnMoreLink'],
    )).toList();
  }

  List<Widget> _buildNoticesList(List<Map<String, dynamic>> notices) {
    return notices.map((notice) => NoticeCard(
      title: notice['title'],
      date: notice['date'],
      description: notice['description'],
      imageUrl: notice['imageUrl'],
      learnMoreLink: notice['learnMoreLink'],
    )).toList();
  }
}

class JobCard extends StatelessWidget {
  final String companyLogo;
  final String jobTitle;
  final String companyName;
  final String location;
  final String jobType;
  final String? salary;
  final String? benefits;
  final String applyLink;

  const JobCard({
    required this.companyLogo,
    required this.jobTitle,
    required this.companyName,
    required this.location,
    required this.jobType,
    this.salary,
    this.benefits,
    required this.applyLink,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    companyLogo,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobTitle,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        companyName,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        location,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Job Type: $jobType',
              style: const TextStyle(fontSize: 14),
            ),
            if (salary != null)
              Text(
                'Salary: $salary',
                style: const TextStyle(fontSize: 14),
              ),
            if (benefits != null)
              Text(
                'Benefits: $benefits',
                style: const TextStyle(fontSize: 14),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.PrimaryColors,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (await canLaunch(applyLink)) {
                  await launch(applyLink);
                } else {
                  throw 'Could not launch $applyLink';
                }
              },
              child: const Text(
                'Quick Apply',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String description;
  final String learnMoreLink;

  const EventCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.description,
    required this.learnMoreLink,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.PrimaryColors,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (await canLaunch(learnMoreLink)) {
                      await launch(learnMoreLink);
                    } else {
                      throw 'Could not launch $learnMoreLink';
                    }
                  },
                  child: const Text(
                    'Learn More',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final String imageUrl;
  final String learnMoreLink;

  const NoticeCard({
    required this.title,
    required this.date,
    required this.description,
    required this.imageUrl,
    required this.learnMoreLink,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imageUrl),
              ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              date,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.PrimaryColors,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (await canLaunch(learnMoreLink)) {
                  await launch(learnMoreLink);
                } else {
                  throw 'Could not launch $learnMoreLink';
                }
              },
              child: const Text(
                'View Details',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
