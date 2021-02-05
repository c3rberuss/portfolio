import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';

class RemoteConfigService extends GetxService {
  RemoteConfig _config;

  Future<void> init() async {
    if (_config == null) {
      _config = await RemoteConfig.instance;
      await _config.setDefaults(_defaults);
      await _config.fetch(expiration: Duration(seconds: 0));
      await _config.activateFetched();
    }
  }

  final Map<String, dynamic> _defaults = {
    "maintenance_android": false,
    "maintenance_ios": false,
  };

  Future<void> reload() async {
    await _config.fetch(expiration: Duration(seconds: 0));
    await _config.activateFetched();
  }

  bool isMaintenance() {
    if (Platform.isAndroid) {
      return _config.getBool("maintenance_android");
    } else if (Platform.isIOS) {
      return _config.getBool("maintenance_ios");
    }

    return false;
  }
}
