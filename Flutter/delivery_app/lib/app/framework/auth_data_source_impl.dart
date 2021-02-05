import 'package:app/core/data/auth_data_source.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/user.dart' as domain;
import 'package:app/core/exceptions/auth_exceptions.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final DioCacheManager _cache;

  AuthDataSourceImpl(this._cache);

  @override
  Future<Resource<String>> authWithEmailAndPassword(String email, String password) async {
    try {
      final userCredentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      final token = await userCredentials.user.getIdToken();
      return Success<String>(token);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Failure<String, AuthException>(
          UserNotFoundException("Cuenta de usuario no encontrada."),
        );
      } else if (e.code == 'wrong-password') {
        return Failure<String, AuthException>(
          WrongPasswordException("Contraseña incorrecta."),
        );
      } else if (e.code == "too-many-requests") {
        return Failure<String, AuthException>(
          TooManyRequestsException("Demasiados intentos, por favor espere un minutos."),
        );
      }
    }

    return Failure<String, AuthException>(
      UnknownAuthException("Ha ocurrido un error interno."),
    );
  }

  @override
  Future<Resource<String>> authWithFacebook() async {
    FacebookAuthCredential facebookCredentials;

    try {
      final AccessToken result = await FacebookAuth.instance.login();

      facebookCredentials = FacebookAuthProvider.credential(result.token);

      final userCredentials = await FirebaseAuth.instance.signInWithCredential(facebookCredentials);

      final token = await userCredentials.user.getIdToken();

      return Success<String>(token);
    } on FacebookAuthException catch (e) {
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
    } on FirebaseAuthException catch (e) {
      if (e.code == "account-exists-with-different-credential") {
        return Failure<String, AuthException>(
          AccountExistsWithDifferentCredentialException(
            "Ya existe una cuenta con este correo, por favor ingrese a su cuenta y vincule sus redes sociales.",
          ),
        );
      }
    }

    return Failure<String, AuthException>(
      UnknownAuthException("Ha ocurrido un error interno."),
    );
  }

  @override
  Future<Resource<String>> authWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return Failure<String, AuthException>(
          AuthCancelledException(),
        );
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredentials = await FirebaseAuth.instance.signInWithCredential(credential);
      final token = await userCredentials.user.getIdToken();

      return Success<String>(token);
    } catch (e) {
      print(e);

      return Failure<String, AuthException>(
        UnknownAuthException("Ha ocurrido un error interno."),
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _cache.clearExpired();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<Resource<void>> signUp(domain.User user) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      await FirebaseAuth.instance.currentUser
          .updateProfile(displayName: user.name, photoURL: user.image);

      return Success();
    } on FirebaseAuthException catch (e) {
      print("ERROR: ${e.code}");

      if (e.code == 'weak-password') {
        return Failure<void, AuthException>(
          WeakPasswordException("Contraseña demasiado débil."),
        );
      } else if (e.code == 'email-already-in-use') {
        return Failure<void, AuthException>(
          EmailAlreadyInUseException("Este correo ya está en uso."),
        );
      }
    } catch (e) {
      return Failure<void, AuthException>(
        UnknownAuthException(e.toString()),
      );
    }

    return Failure<void, AuthException>(
      UnknownAuthException("Ha ocurrido un error interno."),
    );
  }

  @override
  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(PhoneAuthCredential) onCompleted,
    Function(FirebaseAuthException) onFailed,
    Function(String, int) onCodeSent,
    Function(String) codeAutoRetrievalTimeout,
  ) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onCompleted,
      verificationFailed: onFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Future<bool> sendEmailVerification(String email) async {
    try {
      await FirebaseAuth.instance.currentUser.sendEmailVerification(
        ActionCodeSettings(
          url: 'https://llegosv.com/links/confirm-email',
          androidInstallApp: true,
          dynamicLinkDomain: "llegosv.com",
          androidPackageName: "com.c3rberuss.devilery",
          handleCodeInApp: true,
        ),
      );

      return true;
    } catch (e) {
      print("Error $e");
      return false;
    }
  }
}
