import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert'; // For JSON operations
import 'package:uniconnect/CustomDesign/AppBar.dart';
import 'package:uniconnect/CustomDesign/custom_navbar.dart';
import '../../utils/colors.dart';

class Officespages extends StatefulWidget {
  const Officespages({Key? key}) : super(key: key);

  @override
  _OfficespagesState createState() => _OfficespagesState();
}

class _OfficespagesState extends State<Officespages> {
  List<dynamic> data = []; // List to hold JSON data
  List<dynamic> filteredData = []; // List for filtered data
  bool isLoading = true;
  bool isError = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    loadDataFromJson();
  }

  Future<void> loadDataFromJson() async {
    try {
      // Read JSON file from assets
      String jsonString = await rootBundle.loadString('assets/Data/Offices.json');
      setState(() {
        data = jsonDecode(jsonString)['offices'];
        filteredData = data; // Initialize filtered data with all data
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  void filterData() {
    List<dynamic> tempList = data;

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      tempList = tempList.where((item) =>
      item['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          item['designation'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          item['email'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          item['room'].toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    setState(() {
      filteredData = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offices and Administrative officers', style: TextStyle(
          fontSize: 16,
        )),
        actions: [
        ],
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.PrimaryColors))
          : isError
          ? const Center(child: Text('Error loading data. Please check your internet connection or try again later.'))
          : data.isEmpty
          ? const Center(child: Text('No data available.'))
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(Icons.search,color: AppColors.PrimaryColors,),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                                filterData();
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear,size: 16,color: AppColors.PrimaryColors,),
                          onPressed: () {
                            setState(() {
                              searchQuery = '';
                              filterData();
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> item = filteredData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(item['profile_pic']),
                      ),
                      title: Text(item['name']),
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
                              item['designation'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 4),
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
                                child: Text(item['email'], style: const TextStyle(color: AppColors.PrimaryColors)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.room, color: AppColors.PrimaryColors, size: 16),
                              const SizedBox(width: 4),
                              Text(item['room'], style: const TextStyle(color: AppColors.PrimaryColors)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
