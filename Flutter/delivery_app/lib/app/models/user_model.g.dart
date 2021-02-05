// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as int,
    role: json['role'] == null
        ? null
        : UserRoleModel.fromJson(json['role'] as Map<String, dynamic>),
    uid: json['uid'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    enabled: json['enabled'] as bool,
    emailVerified: json['emailVerified'] as bool,
    phone: json['phone'] as String,
    password: json['password'] as String,
    image: json['pictureUrl'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'id': instance.id,
      'uid': instance.uid,
      'role': instance.role,
      'pictureUrl': instance.image,
      'enabled': instance.enabled,
      'emailVerified': instance.emailVerified,
    };

UserRoleModel _$UserRoleModelFromJson(Map<String, dynamic> json) {
  return UserRoleModel(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$UserRoleModelToJson(UserRoleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

UserResponseModel _$UserResponseModelFromJson(Map<String, dynamic> json) {
  return UserResponseModel(
    status: json['status'] as int,
    timestamp: json['timestamp'] as String,
    message: json['message'] as String,
    user: json['data'] == null
        ? null
        : UserModel.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserResponseModelToJson(UserResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'timestamp': instance.timestamp,
      'message': instance.message,
      'data': instance.user,
    };
