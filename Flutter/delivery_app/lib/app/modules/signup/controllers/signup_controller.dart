import 'package:app/app/utils/validators.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/user.dart';
import 'package:app/core/exceptions/auth_exceptions.dart';
import 'package:app/core/interactors/auth_interactors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  SignUpInt _signUpInt;
  VerifyEmailInt _verifyEmail;
  User _user = User();

  //Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //FocusNodes
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final RxBool isFormValid = false.obs;

  SignUpController({@required SignUpInt signUpInt, @required VerifyEmailInt verifyEmailInt}) {
    this._signUpInt = signUpInt;
    this._verifyEmail = verifyEmailInt;
  }

  @override
  void onReady() {
    super.onReady();

    nameController.addListener(_controllerListener);
    emailController.addListener(_controllerListener);
    passwordController.addListener(_controllerListener);
  }

  void _controllerListener() {
    isFormValid.value = Validators.isValidEmail(emailController.text) &&
        Validators.isValidPassword(passwordController.text) &&
        nameController.text.isNotEmpty;
  }

  Future<Resource<void>> signUpWithEmail() async {
    _user = User(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
      image: "https://i.stack.imgur.com/l60Hf.png",
    );

    final result = await _signUpInt(_user);

    if (result is Success) {
      emailController.clear();
      passwordController.clear();
      nameController.clear();

      final bool isEmailSent = await _verifyEmail(_user.email);
      if (!isEmailSent) {
        return Failure<void, AuthException>(
          UnknownAuthException("Error al enviar correo de vericación."),
        );
      }
    }

    return result;
  }
}
