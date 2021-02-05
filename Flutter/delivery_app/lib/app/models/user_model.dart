import 'package:app/core/domain/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "uid")
  String uid;

  @JsonKey(name: "role")
  UserRoleModel role;

  @JsonKey(name: "pictureUrl")
  @override
  String image;

  @JsonKey(name: "enabled")
  bool enabled;

  @JsonKey(name: "emailVerified")
  bool emailVerified;

  UserModel(
      {this.id,
      this.role,
      this.uid,
      String email,
      String name,
      this.enabled,
      this.emailVerified,
      String phone,
      String password,
      this.image})
      : super(
          name: name,
          email: email,
          phone: phone,
          password: password,
          image: image,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable(nullable: true)
class UserRoleModel {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;

  UserRoleModel({this.id, this.name});

  factory UserRoleModel.fromJson(Map<String, dynamic> json) => _$UserRoleModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRoleModelToJson(this);
}

@JsonSerializable()
class UserResponseModel {
  @JsonKey(name: "status")
  int status;
  @JsonKey(name: "timestamp")
  String timestamp;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "data")
  UserModel user;

  UserResponseModel({this.status, this.timestamp, this.message, this.user});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseModelToJson(this);
}
