import 'dart:async';

import 'package:services/src/models/application_response.dart';
import 'package:services/src/models/applications_response.dart';
import 'package:services/src/models/user_model.dart';
import 'package:services/src/models/user_response.dart';

abstract class UserRepository {
  Future<ApplicationsResponse> fetchHistory([bool forceRefresh = true]);
  Future<UserResponse> register(UserModel user);
  Future<UserResponse> update(UserModel user);
}
