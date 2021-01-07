import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:megalibreria/src/models/users/user_model.dart';
import 'package:megalibreria/src/utils/serializers.dart';

part 'user_response.g.dart';

abstract class UserResponse implements Built<UserResponse, UserResponseBuilder> {
  String get message;
  int get code;
  @nullable
  UserModel get data;

  UserResponse._();
  factory UserResponse([void Function(UserResponseBuilder) updates]) = _$UserResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(UserResponse.serializer, this);
  }

  static UserResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserResponse.serializer, json);
  }

  static Serializer<UserResponse> get serializer => _$userResponseSerializer;
}