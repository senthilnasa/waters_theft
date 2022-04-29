import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Function() loader() {
  BotToast.removeAll();
  return BotToast.showCustomLoading(
    toastBuilder: (c) => SpinKitCubeGrid(
      size: 60.0,
    ),
    allowClick: false,
    animationDuration: const Duration(milliseconds: 400),
    animationReverseDuration: const Duration(milliseconds: 400),
    backButtonBehavior: BackButtonBehavior.ignore,
    clickClose: false,
    crossPage: true,
    backgroundColor: Colors.white38,
    ignoreContentClick: true,
  );
  // return () {
  //   BotToast.removeAll();
  // };
}
