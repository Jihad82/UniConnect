import 'package:get/get.dart';
import 'package:uniconnect/Home/services_page.dart';
import 'package:uniconnect/Services/Department/EeePages.dart';
import 'package:uniconnect/Services/FacultyStaff.dart';
import 'package:uniconnect/Services/StudentPortal/StudentPortal.dart';
import 'package:uniconnect/Services/bus/ExamBusRoutes/examBusRoutes0.dart';
import 'package:uniconnect/Services/bus/ExamBusSchedulePage.dart';
import 'package:uniconnect/Services/bus/ShuttleRoutes/shuttleroutes0.dart';
import 'package:uniconnect/Services/bus/ShuttleRoutes/shuttleroutes1.dart';
import 'package:uniconnect/Services/bus/SpecialBusSchedule/SpecialBusRoutes0.dart';
import 'package:uniconnect/Services/bus/SpecialBusSchedulePage.dart';
import 'package:uniconnect/Services/notice.dart';
import 'package:uniconnect/Profile/profile.dart';
import 'package:uniconnect/splash_view.dart';
import '../AuthService/TermsOfServicePage/PrivacyPolicyPage.dart';
import '../AuthService/TermsOfServicePage/TermsOfServicePage.dart';
import '../AuthService/VerifyEmailScreen.dart';
import '../AuthService/login_screen.dart';
import '../AuthService/signup_screen.dart';
import '../Drawer/about_us_screen.dart';
import '../Drawer/rate_screen.dart';
import '../Profile/EditProfilePage.dart';
import '../Services/Department/CSEpages.dart';
import '../Services/Event/EventHomePages.dart';
import '../Services/LearningSupport/LearnningSupportHome.dart';
import '../Services/Opportunities/OpportunitiesPages.dart';
import '../Services/bus/Routes/routes0.dart';
import '../Services/bus/Routes/routes1.dart';
import '../Services/bus/Routes/routes10.dart';
import '../Services/bus/Routes/routes11.dart';
import '../Services/bus/Routes/routes2.dart';
import '../Services/bus/Routes/routes3.dart';
import '../Services/bus/Routes/routes4.dart';
import '../Services/bus/Routes/routes5.dart';
import '../Services/bus/Routes/routes6.dart';
import '../Services/bus/Routes/routes7.dart';
import '../Services/bus/Routes/routes8.dart';
import '../Services/bus/Routes/routes9.dart';
import '../Services/bus/TransportationServices.dart';
import '../Services/bus/shuttleBusSchedulePage.dart';
import '../Services/news/NewsandMedia.dart';
import '../main.dart';


class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: '/splash', page: () => const SplashView()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => SignUpScreen()),
    GetPage(name: '/verify-email', page: () => VerifyEmailScreen()),
    GetPage(name: '/profile', page: () => ProfileScreen()),
    GetPage(name: '/edit_profile', page: () => EditProfileScreen()),
    GetPage(name: '/', page: () => HomePage()),
    GetPage(name: '/home', page: () => HomePage()),
    GetPage(name: '/services', page: () => const ServicesPage()),
    GetPage(name: '/notice', page: () => const NoticeBoard()),
    GetPage(name: '/newsandmedia', page: () => const Newsandmedia()),
    GetPage(name: '/opportunitiespages', page: () => const OpportunitiesPages()),
    GetPage(name: '/learningSupport', page: () =>  const Learningsupporthome()),
    GetPage(name: '/transportationServices', page: () => const TransportationServices()),
    GetPage(name: '/routes0', page: () => const Route0Page()),
    GetPage(name: '/routes1', page: () => const Route1Page()),
    GetPage(name: '/routes2', page: () => const Route2Page()),
    GetPage(name: '/routes3', page: () => const Route3Page()),
    GetPage(name: '/routes4', page: () => const Route4Page()),
    GetPage(name: '/routes5', page: () => const Route5Page()),
    GetPage(name: '/routes6', page: () => const Route6Page()),
    GetPage(name: '/routes7', page: () => const Route7Page()),
    GetPage(name: '/routes8', page: () => const Route8Page()),
    GetPage(name: '/routes9', page: () => const Route9Page()),
    GetPage(name: '/routes10', page: () => const Route10Page()),
    GetPage(name: '/routes11', page: () => const Route11Page()),
    GetPage(name: '/shuttleRoutes1', page: () => const ShuttleRoutes1()),
    GetPage(name: '/shuttleRoutes0', page: () => const ShuttleRoutes0()),
    GetPage(name: '/examBusRoutes0', page: () => const ExamBusRoutes0()),
    GetPage(name: '/examBusSchedulePage', page: () => ExamBusSchedulePage()),
    GetPage(name: '/specialBusRoutes0', page: () => const SpecialBusRoutes0()),
    GetPage(name: '/specialBusSchedulePage', page: () => SpecialBusSchedulePage()),
    GetPage(name: '/shuttleBusSchedulePage', page: () => ShuttleBusSchedulePage()),
    GetPage(name: '/facultyStaff', page: () => const FacultyStaff()),
    GetPage(name: '/csedepartment', page: () => const CSEpages()),
    GetPage(name: '/eee', page: () => const Eeepages()),
    GetPage(name: '/studentPortal', page: () => const StudentPortal()),
    GetPage(name: '/about_us', page: () => AboutUsScreen()),
    GetPage(name: '/rate', page: () => RateScreen()),
    GetPage(name: '/privacy-policy', page: () => PrivacyPolicyPage()),
    GetPage(name: '/terms-of-service', page: () => TermsOfServicePage()),
    GetPage(name: '/events', page: () => const Eventhomepages()),

  ];
}
