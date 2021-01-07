import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:megalibreria/src/models/locations/city_model.dart';
import 'package:megalibreria/src/models/locations/department_model.dart';
import 'package:megalibreria/src/utils/serializers.dart';

import 'address_status.dart';
import 'address_type.dart';

part 'address_model.g.dart';

abstract class AddressModel implements Built<AddressModel, AddressModelBuilder> {

  @BuiltValueField(wireName: 'direccion')
  String get address;

  @nullable
  @BuiltValueField(wireName: 'latitud')
  double get latitude;

  @nullable
  @BuiltValueField(wireName: 'longitud')
  double get longitude;

  AddressModel._();

  factory AddressModel([void Function(AddressModelBuilder) updates]) = _$AddressModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(AddressModel.serializer, this);
  }

  static AddressModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(AddressModel.serializer, json);
  }

  static Serializer<AddressModel> get serializer => _$addressModelSerializer;
}
