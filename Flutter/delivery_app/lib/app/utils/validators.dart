import 'package:get/get_utils/get_utils.dart';

class Validators {
  static String emailFormat(String email) {
    if (email.isEmail) {
      return null;
    }

    return "Ingrese un correo válido";
  }

  static String passwordLength(String password) {
    if (password.length >= 8) {
      return null;
    }

    return "Contraseña demasiado débil";
  }

  static String required(String value) {
    if (value.isNotEmpty) {
      return null;
    }

    return "Este campo es obligatorio.";
  }

  static String phoneNumber(String phoneNumber) {
    //(\+?503?)?
    if (RegExp(r"^([0-9]{4}[-]?[0-9]{4})$").hasMatch(phoneNumber)) {
      return null;
    }

    return "Número de teléfono inválido.";
  }

  static bool isValidPhoneNumber(String phone) {
    final RegExp _phoneRegExp = RegExp(r"^([0-9]{4}[-]?[0-9]{4})$");
    return phone.isNotEmpty && _phoneRegExp.hasMatch(phone);
  }

  static bool isValidEmail(String email) {
    return email.isNotEmpty && email.isEmail;
  }

  static bool isValidPassword(String password) {
    return password.isNotEmpty && password.length >= 8;
  }
}
