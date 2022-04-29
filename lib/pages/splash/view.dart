import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      initState: (_) {},
      builder: (_) {
        return Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset("res/logo.png"),
              const LinearProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
