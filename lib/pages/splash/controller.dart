import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water/utils/delay.dart';
import 'package:water/utils/utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    final box = GetStorage();
    // await box.erase();
    if (box.read<String?>("token") == null) {
      await delay(1000);
      Get.offAndToNamed("/login");
      return;
    }
    dLog("Token: ${box.read<String?>("token")}");
  }
}
