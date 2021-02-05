import 'package:json_annotation/json_annotation.dart';
import 'package:services/core/domain/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  @JsonKey(name: "nombre")
  String name;
  @JsonKey(name: "apellido")
  String lastName;
  @JsonKey(name: "telefono")
  String phone;
  @JsonKey(name: "correo")
  String email;
  String password;
  String token;

  UserModel({this.name, this.lastName, this.phone, this.email, this.password})
      : super(name: name, lastName: lastName, phone: phone, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson(instance) => _$UserModelToJson(this);
}

@JsonSerializable(createToJson: false)
class UserResponseModel {
  int code;
  String message;

  @JsonKey(name: "data", nullable: true, includeIfNull: true)
  UserModel user;

  UserResponseModel({this.code, this.message, this.user});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);
}
