import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/utils/serializers.dart';

part 'user_model.g.dart';

abstract class UserModel implements Built<UserModel, UserModelBuilder> {
  @nullable
  String get name;

  @nullable
  String get phone;

  @nullable
  String get email;

  @nullable
  String get password;

  @nullable
  String get token;

  UserModel._();

  factory UserModel([void Function(UserModelBuilder) updates]) = _$UserModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(UserModel.serializer, this);
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(UserModel.serializer, json);
  }

  static Serializer<UserModel> get serializer => _$userModelSerializer;
}
