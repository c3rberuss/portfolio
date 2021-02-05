import 'package:app/core/domain/user.dart';
import 'package:app/core/interactors/auth_interactors.dart';
import 'package:app/core/interactors/user_interactors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final GetUserInfoInt getUserInfo;
  final LinkGoogleAccountInt linkGoogleAccount;
  final LinkFacebookAccountInt linkFacebookAccount;
  final VerifyEmailInt verifyEmail;
  final GetLocalUserInfoInt getLocalUserInfo;
  final SignOutInt signOut;

  Rx<User> user = User().obs;

  ProfileController({
    @required this.getUserInfo,
    @required this.linkGoogleAccount,
    @required this.linkFacebookAccount,
    @required this.verifyEmail,
    @required this.getLocalUserInfo,
    @required this.signOut,
  });

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    getLocalUserInfo().then((_user) {
      user.value = _user;
    });
  }
}
