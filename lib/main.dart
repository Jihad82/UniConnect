import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:uniconnect/Notification/NotificationScreen.dart';
import 'package:uniconnect/Services/StudentPortal/StudentPortal.dart';
import 'package:uniconnect/Services/TaskNotes/screens/home_screen.dart';
import 'package:uniconnect/utils/colors.dart';
import 'package:uniconnect/CustomDesign/custom_navbar.dart';
import 'AuthService/AuthController/auth_controller.dart';
import 'CustomDesign/WelcomeUser.dart';
import 'Drawer/drawer.dart';
import 'Notification/NotificationService.dart';
import 'Profile/Controller/profile_controller.dart';
import 'Routes/routes.dart';
import 'Services/Academic calendar/academic_calendar.dart';
import 'Services/Alumni/AlumniHomePages.dart';
import 'Services/CampusMaps/CampusMapPage.dart';
import 'Services/ELibrary/eLibrary.dart';
import 'Services/LearningSupport/LearnningSupportHome.dart';
import 'Services/Victimization/VictimizationHome.dart';
import 'Services/news/NewsandMedia.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Ensures the system UI overlays are shown
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  await NotificationService().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final ProfileController profileController = Get.put(ProfileController());

  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uniconnect',
      initialRoute: '/splash',
      getPages: AppPages.pages,
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _imageList = [];


  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('carouselImages').get();
      _imageList.clear();
      querySnapshot.docs.forEach((doc) {
        _imageList.add(doc['url']);
      });
      setState(() {});
    } catch (e) {
      // Error handling can be customized here if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon:  const Icon(Icons.menu, color: AppColors.PrimaryColors),
          onPressed: () {
            Get.to( AppDrawer());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.PrimaryColors),
            onPressed: () {
              Get.to( const NotificationPage());
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
             const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: WelcomeUser(),
            ),
            if (_imageList.isNotEmpty)
              CarouselSlider(
                items: _imageList.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.PrimaryColors,
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 150,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 7),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1100),
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                ),
              )
            else
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.PrimaryColors,
                ),
              ),
            // Add more widgets here if needed
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore Feature',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Streamline Your University Life',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(5),
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.toNamed('/transportationServices'),
                    child: const HomeIcon(
                        icon: Icons.directions_bus_sharp, label: 'Transportation'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.toNamed('/facultyStaff'),
                    child: const HomeIcon(
                        icon: Icons.my_library_books_outlined, label: 'Faculty & Staff'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.to(const TaskHomeScreen()),
                    child: const HomeIcon(icon: LineIcons.tasks, label: 'Task Manager'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.to(const AlumniHomePages()),
                    child: const HomeIcon(icon: Icons.school, label: 'Alumni'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.to(const Elibrary()),
                    child: const HomeIcon(icon: Icons.menu_book, label: 'E-Library'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.to(const CampusMapPage()),
                    child: const HomeIcon(
                        icon: FontAwesomeIcons.mapLocationDot, label: 'Campus Map'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.to(const StudentPortal()),
                    child: const HomeIcon(
                      icon: Icons.badge_outlined, label: 'Student Portal',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.to( const Learningsupporthome()),
                    child: const HomeIcon(icon: Icons.support, label: 'Learning Support'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.toNamed('/opportunitiespages'),
                    child: const HomeIcon(icon: Icons.work, label: 'Opportunities'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.to(const Newsandmedia()),
                    child: const HomeIcon(icon: Icons.language, label: 'News & Media'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.to(const Victimization()),
                    child: const HomeIcon(icon: Icons.warning, label: 'Victimization'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () => Get.to( const AcademicCalendar()),
                    child: const HomeIcon(icon: Icons.event_note_rounded, label: 'Academic Calendar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}

class HomeIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const HomeIcon({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.PrimaryColors,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
