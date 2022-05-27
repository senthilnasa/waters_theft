import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Function() loader() {
  BotToast.removeAll();
  return BotToast.showLoading();
  // return () {
  //   BotToast.removeAll();
  // };
}
