import 'package:app/app/utils/validators.dart';
import 'package:app/core/data/auth_data_source.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/user.dart';
import 'package:app/core/exceptions/auth_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AuthDataSourceMock extends Mock implements AuthDataSource {}

main() {
  group("Validators", () {
    test("Valid email format", () {
      final result = Validators.isValidEmail("test@test.com");
      expect(result, true);
    });

    test("Invalid email format", () {
      final invalidTests = ["", " ", "test", "test@", "test@an", "test@test.", "@test.com"];

      for (String test in invalidTests) {
        final result = Validators.isValidEmail(test);

        expect(result, false);
      }
    });

    test("Valid password length", () {
      final result = Validators.isValidPassword("12345678");
      expect(result, true);
    });

    test("Invalid email format", () {
      final invalidTests = ["", " ", "1234"];

      for (String test in invalidTests) {
        final result = Validators.isValidPassword(test);

        expect(result, false);
      }
    });

    test("Valid phone number format", () {
      final tests = ["6545-8560", "65458560"];

      for (String testPhone in tests) {
        final result = Validators.isValidPhoneNumber(testPhone);

        expect(result, true);
      }
    });

    test("Invalid phone number format", () {
      final invalidTests = [
        "+50365458560",
        " ",
        "",
        "50365458560",
        "+503 6545-8560",
        "+5036545-8560",
        "6545 8560"
      ];

      for (String test in invalidTests) {
        final result = Validators.isValidPhoneNumber(test);

        expect(result, false);
      }
    });
  });

  group("Auth", () {
    final AuthDataSourceMock auth = AuthDataSourceMock();
    final User testUser = User(
      name: "Jonh Doe",
      email: "test@test.com",
      image: "https://llegosv.com/test.jpg",
      password: "TestPassword",
    );

    test("Sign Up with email success", () async {
      final success = Success();

      when(auth.signUp(testUser)).thenAnswer(
        (_) => Future.delayed(
          Duration(seconds: 2),
          () => success,
        ),
      );

      expect(await auth.signUp(testUser), success);
    });

    test("Sign up with email - Password weak", () async {
      testUser.password = "12345";

      final error = Failure<void, AuthException>(
        WeakPasswordException(),
      );

      when(auth.signUp(testUser)).thenAnswer(
        (_) => Future.delayed(
          Duration(seconds: 2),
          () => error,
        ),
      );

      expect(await auth.signUp(testUser), error);
    });

    test("Sign up with email - Email already exists", () async {
      final error = Failure<void, AuthException>(EmailAlreadyExistException());

      when(auth.signUp(testUser)).thenAnswer(
        (_) => Future.delayed(
          Duration(seconds: 2),
          () => error,
        ),
      );

      expect(await auth.signUp(testUser), error);
    });
  });
}
