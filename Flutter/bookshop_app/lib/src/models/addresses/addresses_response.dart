import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'address_model.dart';

part 'addresses_response.g.dart';

abstract class AddressesResponse implements Built<AddressesResponse, AddressesResponseBuilder> {
  int get code;

  String get message;

  @nullable
  BuiltList<AddressModel> get data;

  AddressesResponse._();

  factory AddressesResponse([void Function(AddressesResponseBuilder) updates]) =
      _$AddressesResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(AddressesResponse.serializer, this);
  }

  static AddressesResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(AddressesResponse.serializer, json);
  }

  static Serializer<AddressesResponse> get serializer => _$addressesResponseSerializer;
}
