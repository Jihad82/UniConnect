import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert'; // For JSON operations
import 'package:uniconnect/CustomDesign/AppBar.dart';
import 'package:uniconnect/CustomDesign/custom_navbar.dart';
import '../../utils/colors.dart';

class Eeepages extends StatefulWidget {
  const Eeepages({Key? key}) : super(key: key);

  @override
  _EeepagesState createState() => _EeepagesState();
}

class _EeepagesState extends State<Eeepages> {
  List<dynamic> data = []; // List to hold JSON data
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDataFromJson();
  }

  Future<void> loadDataFromJson() async {
    try {
      // Read JSON file from assets
      String jsonString = await rootBundle.loadString('assets/Data/EEE_Faculty_Data.json');
      setState(() {
        data = jsonDecode(jsonString)['Eee_faculty_members'];
        isLoading = false;
      });
    } catch (e) {
      print('Error loading JSON: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'EEE Faculty',
        showBackArrow: true,
        actionWidgets: [],
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: AppColors.PrimaryColors,
        ),
      )
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> item = data[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item['image']),
                  // Provide a default image
                ),
                title: Text(item['name'] ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                      decoration: BoxDecoration(
                        color: AppColors.PrimaryColors,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item['designation'] ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.email, color: AppColors.PrimaryColors, size: 16),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: item['email']));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Email copied to clipboard')),
                            );
                          },
                          child: Text(item['email'] ?? '', style: const TextStyle(color: AppColors.PrimaryColors)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
