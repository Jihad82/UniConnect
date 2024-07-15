import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../AuthService/AuthController/auth_controller.dart';

class ProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<String> fullName = ''.obs;
  Rx<String> studentId = ''.obs;
  Rx<String> department = ''.obs;
  Rx<String> email = ''.obs;
  Rx<String> phoneNumber = ''.obs;
  Rx<String> profilePictureUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    ever(Get.find<AuthController>().firebaseUser, (User? user) {
      if (user != null) {
        fetchUserProfile();
      } else {
        resetProfile();
      }
    });
  }

  Future<void> fetchUserProfile() async {
    try {
      String userId = Get.find<AuthController>().firebaseUser.value!.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('users').doc(userId).get();

      if (snapshot.exists) {
        fullName.value = snapshot.data()?['fullName'] ?? '';
        studentId.value = snapshot.data()?['studentId'] ?? '';
        department.value = snapshot.data()?['departmentName'] ?? '';
        email.value = snapshot.data()?['email'] ?? '';
        phoneNumber.value = snapshot.data()?['phoneNumber'] ?? '';
        profilePictureUrl.value = snapshot.data()?['profilePictureUrl'] ?? '';
      }
    } catch (e) {
      print('Error fetching user profile: ${e.toString()}');
    }
  }

  Future<void> updateProfile(
      String newFullName,
      String newStudentId,
      String newDepartment,
      String newPhoneNumber,
      List<File>? newProfilePictures,
      ) async {
    try {
      String userId = Get.find<AuthController>().firebaseUser.value!.uid;
      Map<String, dynamic> updatedData = {
        'fullName': newFullName,
        'studentId': newStudentId,
        'departmentName': newDepartment,
        'phoneNumber': newPhoneNumber,
      };

      if (newProfilePictures != null && newProfilePictures.isNotEmpty) {
        // Upload new profile pictures if provided
        List<String> downloadUrls = await uploadProfilePictures(newProfilePictures);
        updatedData['profilePictureUrl'] = downloadUrls.last; // Use the last uploaded URL as profile picture
      }

      await _firestore.collection('users').doc(userId).update(updatedData);

      fullName.value = newFullName;
      studentId.value = newStudentId;
      department.value = newDepartment;
      phoneNumber.value = newPhoneNumber;
      if (updatedData.containsKey('profilePictureUrl')) {
        profilePictureUrl.value = updatedData['profilePictureUrl'];
      }
    } catch (e) {
      print('Error updating user profile: ${e.toString()}');
    }
  }

  Future<List<String>> uploadProfilePictures(List<File> imageFiles) async {
    try {
      String userId = Get.find<AuthController>().firebaseUser.value!.uid;
      List<String> downloadUrls = [];

      for (var file in imageFiles) {
        // Determine the file extension
        String fileExtension = file.path.split('.').last.toLowerCase();

        // Compress the image
        var result = await FlutterImageCompress.compressWithFile(
          file.absolute.path,
          quality: 10, // Adjust quality as needed
          format: fileExtension == 'png' ? CompressFormat.png : CompressFormat.jpeg,
        );

        // Save the compressed image to a temporary file
        String tempPath = '${file.parent.path}/${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
        File compressedFile = File(tempPath)..writeAsBytesSync(result!);

        String fileName = '$userId/${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
        Reference storageRef = FirebaseStorage.instance.ref().child('profile_pictures/$fileName');
        UploadTask uploadTask = storageRef.putFile(compressedFile);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);

        // Optionally delete the temporary file
        await compressedFile.delete();
      }

      return downloadUrls;
    } catch (e) {
      print('Error uploading profile pictures: ${e.toString()}');
      return [];
    }
  }

  void resetProfile() {
    fullName.value = '';
    studentId.value = '';
    department.value = '';
    email.value = '';
    phoneNumber.value = '';
    profilePictureUrl.value = '';
  }
}
