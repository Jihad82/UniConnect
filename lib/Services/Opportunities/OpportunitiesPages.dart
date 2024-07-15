import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniconnect/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class OpportunitiesPages extends StatefulWidget {
  const OpportunitiesPages({Key? key}) : super(key: key);

  @override
  _OpportunitiesPagesState createState() => _OpportunitiesPagesState();
}

class _OpportunitiesPagesState extends State<OpportunitiesPages> {
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<Map<String, dynamic>> allJobs = [];
  final List<Map<String, dynamic>> allOpportunities = [];

  @override
  void initState() {
    super.initState();
    _fetchJobs();
    _fetchOpportunities();
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

  Future<void> _fetchOpportunities() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('new_opportunities').get();
      allOpportunities.clear();
      for (var doc in querySnapshot.docs) {
        allOpportunities.add(doc.data() as Map<String, dynamic>);
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
        title: const Text('Jobs and opportunities', style: TextStyle(color: AppColors.PrimaryColors)),
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
            const SizedBox(height: 5),

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
            const SizedBox(height:8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterChip('All', Icons.all_inclusive,),
                _buildFilterChip('Jobs', Icons.work),
                _buildFilterChip('Opportunities', Icons.local_activity),
              ],
            ),

            const SizedBox(height: 20),

            // Sections: Jobs, Opportunities
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

  Widget _buildFilterChip(String label, IconData icon) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 5),
          Text(label),
        ],
      ),
      selected: selectedFilter == label,
      backgroundColor:Colors.white,
      selectedColor: AppColors.PrimaryColors.withOpacity(.2), // Use if you want the chip to change color when selected
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

    List<Map<String, dynamic>> filteredOpportunities = allOpportunities.where((opportunity) {
      return opportunity['opportunityName'].toLowerCase().contains(searchQuery) ||
          opportunity['subtitle'].toLowerCase().contains(searchQuery) ||
          opportunity['description'].toLowerCase().contains(searchQuery);
    }).toList();

    switch (selectedFilter) {
      case 'All':
        return [
          ..._buildJobCards(filteredJobs),
          ..._buildOpportunitiesList(filteredOpportunities),
        ];
      case 'Jobs':
        return _buildJobCards(filteredJobs);
      case 'Opportunities':
        return _buildOpportunitiesList(filteredOpportunities);
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

  List<Widget> _buildOpportunitiesList(List<Map<String, dynamic>> opportunities) {
    return opportunities.map((opportunity) => OpportunityCard(
      title: opportunity['opportunityName'],
      subtitle: opportunity['subtitle'],
      imageUrl: opportunity['imageUrl'],
      description: opportunity['description'],
      learnMoreLink: opportunity['learnMoreLink'],
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

class OpportunityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String description;
  final String learnMoreLink;

  const OpportunityCard({
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
                    'View Details',
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
