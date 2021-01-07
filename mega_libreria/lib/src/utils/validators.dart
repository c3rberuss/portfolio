
class FieldsValidators {
  static String email(String value) {
    final emailRegExp =
    RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    if (value == null || value.isEmpty || emailRegExp.hasMatch(value)) {
      return null;
    }

    return "Formato de correo inválido.";
  }

  static String passwordLength(String value) {
    if (value.length >= 8) {
      return null;
    }

    return "Contraseña débil, debe contener al menos 8 caracteres";
  }

  static String phoneNumber(String value) {

    //^[\+]?[(]?[0-9]{3}[)]?[\s]?[0-9]{4}[-]?[0-9]{4}$

    if (RegExp(r"^([0-9]{4}[-]?[0-9]{4})$").hasMatch(value)) {
      return null;
    }

    return "Número de teléfono inválido.";
  }

  static String required(dynamic value){
    if (value == null ||
        value == false ||
        ((value is Iterable || value is String || value is Map) &&
            value.length == 0)) {
      return "Este campo es obligatorio.";
    }
    return null;
  }
}
