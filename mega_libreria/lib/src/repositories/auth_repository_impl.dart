import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:megalibreria/src/models/users/user_response.dart';
import 'package:megalibreria/src/repositories/preferences_repository_impl.dart';

import './auth_repository.dart';
import 'network_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  PreferencesRepositoryImpl _sharedPreferences;
  NetworkRepository _network;
  FirebaseMessaging fcm;


  AuthRepositoryImpl(PreferencesRepositoryImpl prefs, NetworkRepository networkRepository, FirebaseMessaging fcm) {
    _sharedPreferences = prefs;
    this._network = networkRepository;
    this.fcm = fcm;
  }

  @override
  Future<UserResponse> auth(String email, String password) async {

    //final deviceToken = await fcm.getToken();

    //print(deviceToken);

    final body = {"email": email, "password": password};
    final response = await _network.instance.post("/clientes/api", data: body);

    return Future.value(UserResponse.fromJson(response.data));
  }

  @override
  Future<void> logout() async {
    _sharedPreferences.remove("token");
    _network.clearCache();
  }

  @override
  Future<UserResponse> verify() async {
    final response = await _network.instance.post("/clientes/api/verify");

    return Future.value(UserResponse.fromJson(response.data));
  }
}
