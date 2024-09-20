import 'package:get/get.dart';

class UserController extends GetxController {
  final username = "".obs;
  final first_name = "".obs;
  final last_name = "".obs;
  final master_key = "".obs;
  final token = "".obs;

  void fromJSON(Map<String, dynamic> json) {
    username.value = json['username'];
    first_name.value = json['first_name'];
    last_name.value = json['last_name'];
    token.value = json['token'];
  }

  void setMasterKey(String key) {
    master_key.value = key;
  }
}
