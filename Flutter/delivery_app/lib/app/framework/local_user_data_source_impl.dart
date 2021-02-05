import 'package:app/core/data/local_user_data_source.dart';
import 'package:app/core/domain/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class LocalUserDataSourceImpl implements LocalUserDataSource {
  @override
  Future<String> getIdToken() {
    return Future.value("");
  }

  @override
  Future<User> getUserInfo() {
    final user = auth.FirebaseAuth.instance.currentUser;

    return Future.value(
      User(
        name: user.displayName,
        email: user.email,
        phone: user.phoneNumber,
        image: user.photoURL,
      ),
    );
  }
}
