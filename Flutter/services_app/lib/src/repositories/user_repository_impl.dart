import 'package:services/src/models/application_response.dart';
import 'package:services/src/models/applications_response.dart';
import 'package:services/src/models/user_model.dart';
import 'package:services/src/models/user_response.dart';
import 'package:services/src/repositories/network_repository.dart';
import 'package:services/src/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final NetworkRepository network;

  UserRepositoryImpl(this.network);

  @override
  Future<ApplicationsResponse> fetchHistory([bool forceRefresh = true]) async {
    final response = await network.instance.get(
      "/applications/api",
      options: network.cacheOptions(forceRefresh: forceRefresh),
    );
    return Future.value(ApplicationsResponse.fromJson(response.data));
  }

  @override
  Future<UserResponse> register(UserModel user) async {
    final response = await network.instance.post(
      "/auth/register",
      data: user.toJson(),
    );
    return UserResponse.fromJson(response.data);
  }

  @override
  Future<UserResponse> update(UserModel user) {
    // TODO: implement update
    return null;
  }
}
