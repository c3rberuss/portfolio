import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  //step 1
  final TextEditingController name = Get.find(tag: "name");
  final TextEditingController lastName = Get.find(tag: "last_name");
  final TextEditingController phone = Get.find(tag: "phone");
  final FocusNode focusName = Get.find(tag: "f_name");
  final FocusNode focusLastName = Get.find(tag: "f_last_name");
  final FocusNode focusPhone = Get.find(tag: "f_phone");

  //step 2
  final TextEditingController email = Get.find(tag: "email");
  final TextEditingController password = Get.find(tag: "password");
  final TextEditingController confirmPassword = Get.find(tag: "confirm");
  final FocusNode focusEmail = Get.find(tag: "f_email");
  final FocusNode focusPassword = Get.find(tag: "f_password");
  final FocusNode focusConfirmPassword = Get.find(tag: "f_confirm");

  bool isValidPersonalInfo() {
    return name.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        name.text.isAlphabetOnly &&
        lastName.text.isAlphabetOnly &&
        phone.text.isNotEmpty;
  }

  bool isValidAccountInfo() {
    return email.text.isEmail &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        password.text.length >= 8 &&
        confirmPassword.text == password.text;
  }
}
