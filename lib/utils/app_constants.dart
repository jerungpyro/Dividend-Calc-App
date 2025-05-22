// lib/utils/app_constants.dart
import 'package:unit_trust_calculator/models/author_info.dart';

class AppConstants {
  static const String appTitle = 'Unit Trust Dividend Calculator';
  static const String appIconPath = 'assets/images/app_icon.png';
  static const String copyrightNotice = '© 2023 Badrul. All Rights Reserved.';

  //Social Media Links
  static const String instagramUrl = 'https://www.instagram.com/badrul)38/'; // CHANGE THIS
  static const String linkedinUrl = 'https://www.linkedin.com/in/badrul-akasyah-244819251/'; // CHANGE THIS
  static const String githubProfileUrl = 'https://github.com/jerungpyro/';


  static const String githubRepoUrl = 'https://github.com/jerungpyro/Dividend-Calc-App'; 

  static const AuthorInfo author = AuthorInfo(
    name: 'BADRUL MUHAMMAD AKASYAH BIN BADRUL HISHAM', 
    matricNo: '2023131279', 
    course: 'NETCENTRIC COMPUTING', 
  );

  // Route Names
  static const String homeRoute = '/';
  static const String aboutRoute = '/about';
}