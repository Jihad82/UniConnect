import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniconnect/AuthService/TermsOfServicePage/PrivacyPolicyPage.dart';
import 'package:uniconnect/AuthService/TermsOfServicePage/TermsOfServicePage.dart';
import 'package:uniconnect/utils/colors.dart';
import 'AuthController/auth_controller.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController authController = Get.put(AuthController());

  bool agreedToTerms = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  // State variables for error tracking
  bool _isFullNameError = false;
  bool _isStudentIdError = false;
  bool _isDepartmentNameError = false;
  bool _isEmailError = false;
  bool _isPhoneNumberError = false;
  bool _isPasswordError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return authController.isLoading.value
            ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.PrimaryColors,
            ))
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hey there,',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create an Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Full Name TextField
              SizedBox(
                height: 45,
                child: TextField(
                  controller: authController.fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.PrimaryColors),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              if (_isFullNameError)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Full Name cannot be empty',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 8),
              // Student ID TextField
              SizedBox(
                height: 45,
                child: TextField(
                  controller: authController.studentIdController,
                  decoration: InputDecoration(
                    labelText: 'Student ID',
                    prefixIcon: const Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.PrimaryColors),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              if (_isStudentIdError)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Student ID cannot be empty',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 8),
              // Department Name TextField
              SizedBox(
                height: 45,
                child: TextField(
                  controller: authController.departmentNameController,
                  decoration: InputDecoration(
                    labelText: 'Department Name',
                    hintText:'Department Name (CSE)',
                    prefixIcon: const Icon(Icons.school_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.PrimaryColors),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              if (_isDepartmentNameError)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Department Name cannot be empty',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 8),
              // Email TextField
              SizedBox(
                height: 45,
                child: TextField(
                  controller: authController.emailController,
                  decoration: InputDecoration(
                    labelText: 'E-Mail',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.PrimaryColors),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              if (_isEmailError)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'E-Mail cannot be empty',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 8),
              // Phone Number TextField
              SizedBox(
                height: 45,
                child: TextField(
                  controller: authController.phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.PrimaryColors),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              if (_isPhoneNumberError)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Phone Number cannot be empty',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 8),
              // Password TextField
              SizedBox(
                height: 45,
                child: TextField(
                  controller: authController.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.PrimaryColors),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: obscurePassword,
                ),
              ),
              if (_isPasswordError)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password cannot be empty',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 10),
              // Terms and Conditions
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: AppColors.PrimaryColors,
                    value: agreedToTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        agreedToTerms = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'By creating an account, you agree to our ',
                        style: const TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: 'Terms of Service',
                            style: const TextStyle(
                              color: AppColors.PrimaryColors,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Get.to(TermsOfServicePage());
                            },
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: const TextStyle(
                              color: AppColors.PrimaryColors,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Get.to(PrivacyPolicyPage());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Register Button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isFullNameError = authController.fullNameController.text.isEmpty;
                    _isStudentIdError = authController.studentIdController.text.isEmpty;
                    _isDepartmentNameError = authController.departmentNameController.text.isEmpty;
                    _isEmailError = authController.emailController.text.isEmpty;
                    _isPhoneNumberError = authController.phoneNumberController.text.isEmpty;
                    _isPasswordError = authController.passwordController.text.isEmpty;
                  });

                  if (!_isFullNameError &&
                      !_isStudentIdError &&
                      !_isDepartmentNameError &&
                      !_isEmailError &&
                      !_isPhoneNumberError &&
                      !_isPasswordError &&
                      agreedToTerms) {
                    authController.signUp();
                  } else {
                    if (!agreedToTerms) {
                      Get.snackbar(
                        'Error',
                        'Please agree to terms and conditions',
                        snackPosition: SnackPosition.TOP,
                        backgroundGradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.greenAccent,
                            AppColors.PrimaryColors,
                          ],
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.PrimaryColors,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 5),
              // Logo and Login
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(color: AppColors.PrimaryColors),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
