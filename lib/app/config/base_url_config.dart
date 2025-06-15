import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseUrlConfig {
  static String baseUrl = dotenv.env['BASE_URL'].toString();

  static String get signIn => '/users/mobile-login';
  static String get adminLogin => '/users/admin-login';
  static String get signUp => '/users/Create-account';
  static String get verifyOtp => '/users/verify-otp';
  static String get refreshToken => '/users/member/refresh-token';

  //Manual
  static String get manualCreate => '/manual/create';
  static String get officiatingManual => '/officiating-manuals';
  static String get officiatingCreate => '/officiating/create';
  static String get sampleManual => '/sample-manual';
  static String get officiating => '/officiating';

  //Sermon
  static String get createSermon => '/my-sermon/create';

  static String get mySermon => '/my-sermon/my-sermons';
  static String get sermon => '/my-sermon';

  static String get allSermon => '/sample-sermon/all-sermons';

  //Declaration
  static String get declaration => '/declaration';

  //Books
  static String get books => '/books';
  static String get articles => '/articles';

  //Prayers
  static String get samplePrayers => '/prayers';
  static String get myPrayers => '/my-prayers';
  static String get createPrayer => '/my-prayers/create';

  //Notes
  static String get notes => '/my-note';
  static String get createNotes => '/my-note/create';

  //Notifications
  static String get notifications => '/notifications';

  //Events
  static String get events => '/events';
}
