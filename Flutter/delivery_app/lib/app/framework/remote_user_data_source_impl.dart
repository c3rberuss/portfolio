import 'package:app/app/framework/network.dart';
import 'package:app/app/models/user_model.dart';
import 'package:app/core/data/remote_user_data_source.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/user.dart';
import 'package:app/core/exceptions/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RemoteUserDataSourceImpl implements RemoteUserDataSource {
  final Network _network;

  RemoteUserDataSourceImpl(this._network);

  @override
  Future<Resource<User>> getUserInfo() async {
    try {
      final rawResponse = await _network.instance.get("/v1/users/");
      final response = UserResponseModel.fromJson(rawResponse.data);

      print(response.toJson());

      return Success<User>(response.user);
    } catch (e) {
      return Failure<User, Exception>(e);
    }
  }

  @override
  Future<Resource<String>> linkWithEmail(String email, String password) async {
    try {
      final credential = auth.EmailAuthProvider.credential(email: email, password: password);
      await auth.FirebaseAuth.instance.currentUser.linkWithCredential(credential);

      return Success<String>("Su cuenta de correo fue asociada exitosamente.");
    } on auth.FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == "provider-already-linked") {
        return Failure<String, AuthException>(
          AuthException("Su cuenta de correo ya se encuentra vinculada."),
        );
      } else if (e.code == "credential-already-in-use") {
        return Failure<String, AuthException>(
          AuthException("Esta cuenta ya fue vinculada a otra cuenta."),
        );
      } else if (e.code == "email-already-in-use") {
        return Failure<String, AuthException>(
          AuthException("Ya hay una cuenta registrada con ese correo"),
        );
      }

      return Failure<String, AuthException>(
        UnknownAuthException("Esta cuenta de correo ya está vinculada a su cuenta"),
      );
    }
  }

  @override
  Future<Resource<String>> linkWithFacebook() async {
    try {
      final AccessToken result = await FacebookAuth.instance.login();
      final facebookCredentials = auth.FacebookAuthProvider.credential(result.token);

      await auth.FirebaseAuth.instance.currentUser.linkWithCredential(facebookCredentials);
      return Success<String>("Su cuenta de Facebook fue asociada exitosamente.");
    } on FacebookAuthException catch (e) {
      print(e.errorCode);

      if (e.errorCode == FacebookAuthErrorCode.CANCELLED) {
        return Failure<String, AuthException>(
          AuthCancelledException(),
        );
      } else if (e.errorCode == FacebookAuthErrorCode.FAILED) {
        FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
        return Failure<String, AuthException>(
          AuthFailedException("¡Algo salió mal! Intente nuevamente más tarde"),
        );
      }
    } on auth.FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == "provider-already-linked") {
        return Failure<String, AuthException>(
          AuthException("Su cuenta de correo ya se encuentra vinculada."),
        );
      } else if (e.code == "credential-already-in-use") {
        return Failure<String, AuthException>(
          AuthException("Esta cuenta ya fue vinculada a otra cuenta."),
        );
      } else if (e.code == "email-already-in-use") {
        return Failure<String, AuthException>(
          AuthException("Ya hay una cuenta registrada con ese correo"),
        );
      }
    }

    return Failure<String, AuthException>(
      UnknownAuthException("Esta cuenta de Facebook ya está vinculada a su cuenta"),
    );
  }

  @override
  Future<Resource<String>> linkWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return Failure<String, AuthException>(
          AuthCancelledException(),
        );
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final auth.GoogleAuthCredential credential = auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.FirebaseAuth.instance.currentUser.linkWithCredential(credential);

      return Success<String>("Su cuenta de Google fue asociada exitosamente.");
    } on auth.FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == "provider-already-linked") {
        return Failure<String, AuthException>(
          AuthException("Su cuenta de correo ya se encuentra vinculada."),
        );
      } else if (e.code == "credential-already-in-use") {
        return Failure<String, AuthException>(
          AuthException("Esta cuenta ya fue vinculada a otra cuenta."),
        );
      } else if (e.code == "email-already-in-use") {
        return Failure<String, AuthException>(
          AuthException("Ya hay una cuenta registrada con ese correo"),
        );
      }
    }

    return Failure<String, AuthException>(
      UnknownAuthException("Esta cuenta de Google ya está vinculada a su cuenta"),
    );
  }
}
