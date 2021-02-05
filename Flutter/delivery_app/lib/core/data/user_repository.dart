import 'package:app/core/data/local_user_data_source.dart';
import 'package:app/core/data/remote_user_data_source.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/user.dart';

class UserRepository {
  final RemoteUserDataSource _remoteDataSource;
  final LocalUserDataSource _localDataSource;

  UserRepository(this._remoteDataSource, this._localDataSource);

  Future<Resource<User>> getUserInfo() => _remoteDataSource.getUserInfo();

  Future<String> getIdToken() => _localDataSource.getIdToken();

  Future<Resource> linkFacebookAccount() => _remoteDataSource.linkWithFacebook();
  Future<Resource> linkGoogleAccount() => _remoteDataSource.linkWithGoogle();
  Future<User> getLocalUserInfo() => _localDataSource.getUserInfo();
}
