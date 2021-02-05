import 'package:get/get.dart';
import 'package:services/app/modules/cart/bindings/cart_binding.dart';
import 'package:services/app/modules/cart/views/cart_view.dart';
import 'package:services/app/modules/checkout/bindings/checkout_binding.dart';
import 'package:services/app/modules/checkout/views/checkout_view.dart';
import 'package:services/app/modules/home/bindings/home_binding.dart';
import 'package:services/app/modules/home/views/home_view.dart';
import 'package:services/app/modules/login/bindings/login_binding.dart';
import 'package:services/app/modules/login/views/login_view.dart';
import 'package:services/app/modules/profile/bindings/profile_binding.dart';
import 'package:services/app/modules/profile/views/profile_view.dart';
import 'package:services/app/modules/services/bindings/services_binding.dart';
import 'package:services/app/modules/services/views/services_view.dart';
import 'package:services/app/modules/signup/bindings/signup_binding.dart';
import 'package:services/app/modules/signup/views/signup_view.dart';
import 'package:services/app/modules/splash/bindings/splash_binding.dart';
import 'package:services/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: Routes.SERVICES,
      page: () => ServicesView(),
      binding: ServicesBinding(),
    ),
    GetPage(
      name: Routes.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
