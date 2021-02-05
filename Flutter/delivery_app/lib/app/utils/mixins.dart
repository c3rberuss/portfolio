import 'package:app/app/framework/services/remote_config_service.dart';
import 'package:get/get.dart';

mixin Maintenance {
  Future<bool> inMaintenance() async {
    RemoteConfigService remoteConfig = Get.find();
    await remoteConfig.reload();
    return remoteConfig.isMaintenance();
  }
}
