import 'package:app/app/framework/auth_data_source_impl.dart';
import 'package:app/app/framework/local_user_data_source_impl.dart';
import 'package:app/app/framework/network.dart';
import 'package:app/app/framework/remote_user_data_source_impl.dart';
import 'package:app/app/framework/shared_preferences_source_impl.dart';
import 'package:app/app/modules/splash/controllers/splash_controller.dart';
import 'package:app/app/utils/constants.dart';
import 'package:app/core/data/auth_repository.dart';
import 'package:app/core/data/shared_preferences_source.dart';
import 'package:app/core/data/user_repository.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );

    Get.lazyPut<SharedPreferencesSource>(
      () => SharedPreferencesSourceImpl(),
      fenix: true,
    );

    Get.lazyPut<AuthRepository>(
      () => AuthRepository(
        AuthDataSourceImpl(Get.find(tag: "api_cache")),
      ),
      fenix: true,
    );

    Get.lazyPut<UserRepository>(
      () => UserRepository(
        RemoteUserDataSourceImpl(Get.find()),
        LocalUserDataSourceImpl(),
      ),
      fenix: true,
    );

    Get.lazyPut<DioCacheManager>(
      () => DioCacheManager(
        CacheConfig(baseUrl: BASE_URL),
      ),
      tag: "api_cache",
      fenix: true,
    );

    Get.lazyPut<Network>(
      () => Network(
        baseUrl: BASE_URL,
        token: true,
        cacheManager: Get.find(tag: "api_cache"),
        getToken: () async {
          return await FirebaseAuth.instance.currentUser.getIdToken();
        },
      ),
      fenix: true,
    );
  }
}
