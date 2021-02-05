import 'package:app/core/data/user_repository.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/user.dart';

class GetAuthTokenInt {
  final UserRepository _repository;

  GetAuthTokenInt(this._repository);

  Future<String> call() => _repository.getIdToken();
}

class GetUserInfoInt {
  final UserRepository _repository;

  GetUserInfoInt(this._repository);

  Future<Resource<User>> call() => _repository.getUserInfo();
}

class GetLocalUserInfoInt {
  final UserRepository _repository;

  GetLocalUserInfoInt(this._repository);
  Future<User> call() => _repository.getLocalUserInfo();
}

class LinkFacebookAccountInt {
  final UserRepository _repository;

  LinkFacebookAccountInt(this._repository);

  Future<Resource> call() => _repository.linkFacebookAccount();
}

class LinkGoogleAccountInt {
  final UserRepository _repository;

  LinkGoogleAccountInt(this._repository);

  Future<Resource> call() => _repository.linkGoogleAccount();
}
