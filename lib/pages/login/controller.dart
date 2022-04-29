import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  void load() {}

  void login() {
    if (formKey.currentState!.validate()) {
      print("Login");
    }
  }
}
