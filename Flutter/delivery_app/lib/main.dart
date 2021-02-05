import 'package:app/app/framework/services/remote_config_service.dart';
import 'package:app/app/styles/app_theme.dart';
import 'package:app/app/utils/constants.dart';
import 'package:app/app/utils/crashlytics_handler.dart';
import 'package:catcher/catcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  Get.lazyPut<RemoteConfigService>(() => RemoteConfigService());

  CatcherOptions debugOptions = CatcherOptions(SilentReportMode(), [
    ConsoleHandler(),
  ]);

  CatcherOptions releaseOptions = CatcherOptions(
    SilentReportMode(),
    [
      CrashlyticsHandler(),
      SlackHandler(
        SLACK_WEBHOOK,
        "#crash-reports",
        enableDeviceParameters: true,
        enableApplicationParameters: true,
        enableCustomParameters: true,
        enableStackTrace: true,
        printLogs: true,
      ),
    ],
  );

  Catcher(
    GetMaterialApp(
      title: "Delivery App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
    ),
    //debugConfig: debugOptions,
    releaseConfig: releaseOptions,
    ensureInitialized: true,
  );
}
