import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniconnect/CustomDesign/AppBar.dart';
import '../utils/colors.dart';
import '../AuthService/AuthController/auth_controller.dart';
import 'Controller/profile_controller.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  final ProfileController profileController = Get.find<ProfileController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController(text: profileController.fullName.value);
    TextEditingController studentIdController = TextEditingController(text: profileController.studentId.value);
    TextEditingController departmentController = TextEditingController(text: profileController.department.value);

    List<File>? newProfilePictures; // Define a variable to hold the new profile pictures

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Edit Profile',
        showBackArrow: true,
        actionWidgets: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.center, // Align the child widgets within the stack
                  children: [
                    // Profile picture with Facebook-like rounded border
                    Container(
                      width: 120, // Adjust width as needed
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 4,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(profileController.profilePictureUrl.value),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.7), // Set background color to white
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  List<XFile>? pickedFiles = await pickProfilePictures();
                                  if (pickedFiles != null && pickedFiles.isNotEmpty) {
                                    newProfilePictures = pickedFiles.map((file) => File(file.path)).toList();
                                  }
                                },
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: AppColors.PrimaryColors,
                                  size: 32,
                                ),
                                tooltip: 'Change Profile Picture',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Full Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextField(
                controller: fullNameController,
                onChanged: (value) {
                  profileController.fullName.value = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.PrimaryColors),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Student ID',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextField(
                controller: studentIdController,
                onChanged: (value) {
                  profileController.studentId.value = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your student ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.PrimaryColors),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Department',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextField(
                controller: departmentController,
                onChanged: (value) {
                  profileController.department.value = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your department',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.PrimaryColors),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // Prevents the dialog from being dismissed by tapping outside
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Row(
                            children: [
                              CircularProgressIndicator(
                                color: AppColors.PrimaryColors,
                              ),
                              SizedBox(width: 20),
                              Expanded(child: Text('Please wait a while, your profile is updating!')),
                            ],
                          ),
                        );
                      },
                    );

                    await profileController.updateProfile(
                      fullNameController.text,
                      studentIdController.text,
                      departmentController.text,
                      '', // Placeholder for phoneNumber
                      newProfilePictures,
                    );

                    Navigator.of(context).pop(); // Dismiss the dialog

                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: AppColors.PrimaryColors,
                    padding: const EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Example function to pick multiple profile pictures
  Future<List<XFile>?> pickProfilePictures() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickMultiImage();
  }
}
