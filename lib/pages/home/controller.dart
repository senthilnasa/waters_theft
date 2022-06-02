import 'package:get/get.dart';
import '../../utils/services/app.dart';
import '../../utils/utils.dart';

class HomeController extends GetxController {
  var app = AppService.to;

  int selectedMenuId = 7;

  bool showDrawer = false;

  void setUI(int resourceId) {
    selectedMenuId = resourceId;
    update();
  }

  void reload() async {
    var i = selectedMenuId;
    selectedMenuId = 0;
    update();
    await delay(300);
    selectedMenuId = i;
    update();
  }
}
