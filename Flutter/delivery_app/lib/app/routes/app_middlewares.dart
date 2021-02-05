import 'package:app/app/framework/services/remote_config_service.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MaintenanceMiddleware extends GetMiddleware {
  MaintenanceMiddleware({int priority = 0}) : super(priority: priority);

  @override
  RouteSettings redirect(String route) {
    RemoteConfigService remoteConfig = Get.find();

    bool maintenance = remoteConfig.isMaintenance();

    print("MAINTENANCE: $maintenance");

    if (maintenance) {
      return RouteSettings(name: Routes.MAINTENANCE);
    }

    return null;
  }
}

class SessionMiddleware extends GetMiddleware {
  SessionMiddleware({int priority = 0}) : super(priority: priority);

  @override
  RouteSettings redirect(String route) {
    if (FirebaseAuth.instance.currentUser != null) {
      return RouteSettings(name: Routes.HOME);
    }

    return null;
  }
}
