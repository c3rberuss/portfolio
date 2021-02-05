// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    name: json['nombre'] as String,
    lastName: json['apellido'] as String,
    phone: json['telefono'] as String,
    email: json['correo'] as String,
    password: json['password'] as String,
  )..token = json['token'] as String;
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'nombre': instance.name,
      'apellido': instance.lastName,
      'telefono': instance.phone,
      'correo': instance.email,
      'password': instance.password,
      'token': instance.token,
    };

UserResponseModel _$UserResponseModelFromJson(Map<String, dynamic> json) {
  return UserResponseModel(
    code: json['code'] as int,
    message: json['message'] as String,
    user: json['data'] == null
        ? null
        : UserModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}
