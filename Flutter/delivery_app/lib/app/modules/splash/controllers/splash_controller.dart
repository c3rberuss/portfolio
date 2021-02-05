import 'package:app/app/framework/services/remote_config_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final RemoteConfigService remoteConfig = Get.find();

  @override
  void onReady() {
    super.onReady();
    Firebase.initializeApp();
  }
}
