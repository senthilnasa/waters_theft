import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water/utils/dlog.dart';

class RegisterController extends GetxController {
  var formKey = GlobalKey<FormState>();
  String? email, password;

  @override
  void onInit() {
    load();
    super.onInit();
  }

  void load() {}

  void register() {
    if (formKey.currentState!.validate()) {
      // passwordRegister(
      //   email!,
      //   password!,
      // ).then((token) {
      //   if (token != null) {
      //     GetStorage().write('token', token);
      //     Get.offAllNamed('/');
      //   }
      // });
    }
  }

  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> gSign() async {
    var a = await googleSignIn.signIn();
    if (a == null) {
      return;
    }
    dLog(a.authentication);
  }
}
