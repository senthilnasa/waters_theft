import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water/utils/dlog.dart';
import '../../utils/api/auth.dart';
import '../../utils/api/uri.dart';
import '../../utils/services/storage.dart';

class LoginController extends GetxController {
  var formKey = GlobalKey<FormState>();
  String? email, password;

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      var api = AuthApiService<String>(ApiConst.signin);
      if (!await api.post({"mailId": email!, "password": password!})) {
        return;
      }
      dPrint(api.data);
      await Prefs.write('token', api.data);
      Get.offAllNamed('/');
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
