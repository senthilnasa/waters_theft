import 'package:get_storage/get_storage.dart';

Map<String, String> getHeaders() {
  var box = GetStorage();
  return {
    'Content-Type': 'application/json',
    'DeviceId': 'test',
    'Authentication': 'Bearer ${box.read('token')}',
  };
}
