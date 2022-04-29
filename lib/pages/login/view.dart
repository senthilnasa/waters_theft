import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:water/utils/utils.dart';

import 'controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        initState: (_) {},
        builder: (_) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: _.formKey,
                child: Responsive(
                  children: [
                    Div(
                      colM: 6,
                      colS: 12,
                      child: Image.asset("res/login.png"),
                    ),
                    Div(
                      colM: 6,
                      colL: 4,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  TyperAnimatedText(
                                    'Login',
                                    speed: const Duration(milliseconds: 180),
                                    textStyle: GoogleFonts.blackOpsOne(
                                      fontSize: 50,
                                      color: Colors.green,
                                      shadows: [
                                        Shadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 350),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.mail),
                                    labelText: 'Email',
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  autofocus: true,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        GetUtils.isEmail(value)) {
                                      return 'Enter a Valid Mail Id';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 350),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    labelText: 'Password',
                                  ),
                                  obscureText: true,
                                  autocorrect: false,
                                  autofocus: true,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.length < 6) {
                                      return 'Enter a Valid Password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 40),
                              ElevatedButton.icon(
                                onPressed: _.login,
                                icon: Icon(Icons.login),
                                label: Text('Login'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
