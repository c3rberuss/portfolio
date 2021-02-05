import 'package:app/app/utils/validators.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/interactors/auth_interactors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final SignInWithGoogleInt signInWithGoogle;
  final SignInWithFacebookInt signInWithFacebook;
  SignInWithEmailInt _signInWithEmail;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final RxBool isValidForm = false.obs;

  LoginController({
    @required this.signInWithGoogle,
    @required this.signInWithFacebook,
    @required SignInWithEmailInt signInWithEmailInt,
  }) {
    _signInWithEmail = signInWithEmailInt;
  }

  @override
  void onReady() {
    super.onReady();
    emailController.addListener(_controllerListeners);
    passwordController.addListener(_controllerListeners);
  }

  void _controllerListeners() {
    isValidForm.value = Validators.isValidEmail(emailController.text) &&
        Validators.isValidPassword(passwordController.text);
  }

  Future<Resource<String>> signInWithEmail() async {
    final result = await _signInWithEmail(emailController.text, passwordController.text);

    return result;
  }
}
