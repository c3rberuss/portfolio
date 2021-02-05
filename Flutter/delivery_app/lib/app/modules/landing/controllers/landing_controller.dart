import 'package:app/core/interactors/auth_interactors.dart';
import 'package:get/get.dart';

class LandingController extends GetxController {
  final SignInWithFacebookInt signInWithFacebook = Get.find();
  final SignInWithGoogleInt signInWithGoogle = Get.find();
}
