import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:services/src/models/user_response.dart';
import 'package:services/src/repositories/network_repository.dart';

import './auth_repository.dart';
import './spreferences_repository_impl.dart';

class AuthRepositoryImpl extends AuthRepository {
  SPreferencesRepositoryImpl _sharedPreferences;
  NetworkRepository _network;
  FirebaseMessaging fcm;

  AuthRepositoryImpl(SPreferencesRepositoryImpl prefs, NetworkRepository networkRepository,
      FirebaseMessaging fcm) {
    _sharedPreferences = prefs;
    this._network = networkRepository;
    this.fcm = fcm;
  }

  @override
  Future<UserResponse> auth(String email, String password) async {
    final deviceToken = await fcm.getToken();

    final body = {"email": email, "password": password, "token": deviceToken};
    final response = await _network.instance.post("/auth", data: body);

    return Future.value(UserResponse.fromJson(response.data));
  }

  @override
  void logout() {
    _sharedPreferences.remove("logged");
    _sharedPreferences.remove("token");
  }

  @override
  Future<UserResponse> verify() async {
    final response = await _network.instance.post("/auth/verify");

    return Future.value(UserResponse.fromJson(response.data));
  }
}
