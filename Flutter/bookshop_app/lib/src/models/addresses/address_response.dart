import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'address_response.g.dart';

abstract class AddressResponse implements Built<AddressResponse, AddressResponseBuilder> {
  int get code;

  String get message;

  @nullable
  int get data;

  AddressResponse._();

  factory AddressResponse([void Function(AddressResponseBuilder) updates]) = _$AddressResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(AddressResponse.serializer, this);
  }

  static AddressResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(AddressResponse.serializer, json);
  }

  static Serializer<AddressResponse> get serializer => _$addressResponseSerializer;
}
