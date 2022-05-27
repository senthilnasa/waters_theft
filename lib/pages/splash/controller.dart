import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water/utils/services/app.dart';
import 'package:water/utils/utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    load();
  }

  AppService get app => AppService.to;

  Future<void> load() async {
    await Future.delayed(const Duration(seconds: 2));
    final box = GetStorage();
    if (box.read<String?>("token") == null) {
      Get.offAndToNamed("/login");
      return;
    }
    var userLoaded = await app.loadUser();

    if (!userLoaded) {
      toast("Unable to fetch user details!");
      Get.offAndToNamed("/login");
      return;
    }

    Get.offAndToNamed("/home");
    dLog("Token: ${box.read<String?>("token")}");
  }
}
