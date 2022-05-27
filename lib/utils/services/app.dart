import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../../models/user.dart';
import '../api/data.dart';
import '../api/uri.dart';

import '../utils.dart';

import 'storage.dart';

class AppService extends GetxService {
  int yearId = 0;

  static AppService get to => Get.find<AppService>();

  RxBool inRequest = false.obs;

  String deviceId = 'web';

  String? get token => Prefs.read<String>('token');

  Uri? redirectUri;

  UserModel? user;

  @override
  void onInit() {
    _setDeviceId();
    super.onInit();
  }

  void _setDeviceId() async {
    if (kDebugMode) {
      deviceId = 'nasa';
      return;
    }
    if (!GetPlatform.isWeb) {
      deviceId = await PlatformDeviceId.getDeviceId ?? 'web';
      deviceId = deviceId.split(' ').first;
    }
  }

  Future<bool> loadUser() async {
    var api = DataApiService<Map>(ApiConst.me, showLoader: false);
    if (!await api.gets()) return false;
    user = UserModel.fromJson(Map<String, dynamic>.from(api.data));
    return true;
  }

  Future<void> logout() async {
    toast('Logging out...');
    try {
      DataApiService(ApiConst.logout).logout();
    } catch (e) {
      dPrint(e);
    }
    await Prefs.clear();
    user = null;
    redirectUri = null;
    Get.offAllNamed("/");
  }
}
