import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:megalibreria/src/utils/serializers.dart';

part 'fare_model.g.dart';

abstract class FareModel implements Built<FareModel, FareModelBuilder> {
  @BuiltValueField(wireName: 'total')
  double get total;

  @BuiltValueField(wireName: 'tarifa')
  double get fare;

  @BuiltValueField(wireName: 'minimo')
  double get minimum;

  FareModel._();

  factory FareModel([void Function(FareModelBuilder) updates]) = _$FareModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(FareModel.serializer, this);
  }

  static FareModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(FareModel.serializer, json);
  }

  static Serializer<FareModel> get serializer => _$fareModelSerializer;
}
