import 'package:flutter/foundation.dart';

abstract class ApiConst {
  ApiConst._();

  ///Primary constants
  static const String webHost = "localhost";
  static const String apiHost = "water-theft-api.senthilnasa.me";
  static const String version = "V1";

  ///Auth constants
  static const String auth = 'auth/';
  static const String signin = '$auth/signin/';
  static const String signup = '$auth/signup/';

  static const String logout = 'logout';

  /// Data Constants
  ///
  static const String me = 'me';

  /// staff management
  static const String staff = 'staff';

  /// student management
  static const String student = 'student';

  /// Bus management
  static const String bus = 'bus';
}
