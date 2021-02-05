import 'package:bookshop/src/models/locations/city_model.dart';
import 'package:bookshop/src/models/locations/department_model.dart';
import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_model.g.dart';

abstract class UserModel implements Built<UserModel, UserModelBuilder> {
  @nullable
  @BuiltValueField(wireName: 'nombre')
  String get name;

  @nullable
  @BuiltValueField(wireName: 'apellido')
  String get lastName;

  @nullable
  String get email;

  @nullable
  String get password;

  @nullable
  @BuiltValueField(wireName: 'telefono')
  String get phone;

  @nullable
  @BuiltValueField(wireName: 'direccion')
  String get address;

  @nullable
  @BuiltValueField(wireName: 'referencia')
  String get reference;

  @nullable
  @BuiltValueField(wireName: 'departamento')
  DepartmentModel get department;

  @nullable
  @BuiltValueField(wireName: 'municipio')
  CityModel get city;

  @nullable
  @BuiltValueField(wireName: 'longitud')
  double get longitude;

  @nullable
  @BuiltValueField(wireName: 'latitud')
  double get latitude;

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
