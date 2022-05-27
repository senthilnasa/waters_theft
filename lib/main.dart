import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water/pages/splash/view.dart';

// import 'pages/home/view.dart';
import 'pages/home/controller.dart';
import 'pages/home/view.dart';
import 'pages/login/view.dart';
import 'pages/register/view.dart';
import 'utils/services/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AppService());
  Get.put(HomeController());

  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Water Theft',
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "/": (_) => const SplashView(),
        "/login": (_) => const LoginView(),
        "/register": (_) => const RegisterView(),
        "/home": (_) => const HomePage(),
      },
      scrollBehavior: MyCustomScrollBehavior(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
