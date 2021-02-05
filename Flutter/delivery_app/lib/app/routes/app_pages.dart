import 'package:app/app/modules/checkout/views/checkout_view.dart';
import 'package:app/app/modules/checkout/bindings/checkout_binding.dart';
import 'package:app/app/modules/payment/views/payment_view.dart';
import 'package:app/app/modules/payment/bindings/payment_binding.dart';
import 'package:app/app/modules/payment/bindings/payment_binding.dart';
import 'package:app/app/modules/permissions/views/permissions_view.dart';
import 'package:app/app/modules/permissions/bindings/permissions_binding.dart';
import 'package:app/app/modules/address/binding/address_binding.dart';
import 'package:app/app/modules/address/views/address_view.dart';
import 'package:app/app/modules/profile/views/edit_profile_view.dart';
import 'package:app/app/modules/result/views/result_view.dart';
import 'package:app/app/modules/result/bindings/result_binding.dart';
import 'package:app/app/modules/cart/views/cart_view.dart';
import 'package:app/app/modules/cart/bindings/cart_binding.dart';
import 'package:app/app/modules/menu/views/menu_view.dart';
import 'package:app/app/modules/menu/bindings/menu_binding.dart';
import 'package:app/app/modules/addresses/bindings/addresses_binding.dart';
import 'package:app/app/modules/maintenance/views/maintenance_view.dart';
import 'package:app/app/modules/maintenance/bindings/maintenance_binding.dart';
import 'package:app/app/modules/home/bindings/home_binding.dart';
import 'package:app/app/modules/home/views/home_view.dart';
import 'package:app/app/modules/landing/bindings/landing_binding.dart';
import 'package:app/app/modules/landing/views/landing_view.dart';
import 'package:app/app/modules/location_picker/bindings/location_picker_binding.dart';
import 'package:app/app/modules/location_picker/views/location_picker_view.dart';
import 'package:app/app/modules/login/bindings/login_binding.dart';
import 'package:app/app/modules/login/views/login_view.dart';
import 'package:app/app/modules/profile/bindings/profile_binding.dart';
import 'package:app/app/modules/signup/bindings/signup_binding.dart';
import 'package:app/app/modules/signup/views/signup_view.dart';
import 'package:app/app/modules/splash/bindings/splash_binding.dart';
import 'package:app/app/modules/splash/views/splash_view.dart';
import 'package:app/app/modules/stores/bindings/stores_binding.dart';
import 'package:app/app/modules/stores/views/stores_view.dart';
import 'package:app/app/routes/app_middlewares.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      bindings: [
        HomeBinding(),
        ProfileBinding(),
        AddressesBinding(),
        CartBinding(),
      ],
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP,
      page: () => SignupView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.LANDING,
      page: () => LandingView(),
      binding: LandingBinding(),
      middlewares: [
        MaintenanceMiddleware(priority: 0),
        SessionMiddleware(priority: 1),
      ],
    ),
    GetPage(
      name: Routes.STORES,
      page: () => StoresView(),
      binding: StoresBinding(),
    ),
    GetPage(
      name: Routes.LOCATION_PICKER,
      page: () => LocationPickerView(),
      binding: LocationPickerBinding(),
    ),
    GetPage(
      name: Routes.MAINTENANCE,
      page: () => MaintenanceView(),
      binding: MaintenanceBinding(),
    ),
    GetPage(
      name: Routes.MENU,
      page: () => MenuView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => CartView(),
    ),
    GetPage(
      name: Routes.RESULT,
      page: () => ResultView(),
      binding: ResultBinding(),
      fullscreenDialog: true,
    ),
    GetPage(
      name: Routes.ADDRESS,
      page: () => AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: Routes.PERMISSIONS,
      page: () => PermissionsView(),
      binding: PermissionsBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => EditProfileView(),
    ),
    GetPage(
      name: Routes.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: Routes.CHECKOUT, 
      page:()=> CheckoutView(), 
      binding: CheckoutBinding(),
    ),
  ];
}