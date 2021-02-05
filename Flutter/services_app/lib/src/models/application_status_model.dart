import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/utils/serializers.dart';

part 'application_status_model.g.dart';

class ApplicationStatusModel extends EnumClass {
  @BuiltValueEnumConst(wireName: 'unpaid', fallback: true)
  static const ApplicationStatusModel unpaid = _$unpaid;

  @BuiltValueEnumConst(wireName: 'paid')
  static const ApplicationStatusModel paid = _$paid;

  @BuiltValueEnumConst(wireName: 'partial_paid')
  static const ApplicationStatusModel partialPaid = _$partialPaid;

  @BuiltValueEnumConst(
    wireName: 'cancelled',
  )
  static const ApplicationStatusModel cancelled = _$cancelled;

  const ApplicationStatusModel._(String name) : super(name);

  static BuiltSet<ApplicationStatusModel> get values => _$applicationStatusModelValues;

  static ApplicationStatusModel valueOf(String name) => _$applicationStatusModelValueOf(name);

  String serialize() {
    return serializers.serializeWith(ApplicationStatusModel.serializer, this);
  }

  static ApplicationStatusModel deserialize(String string) {
    return serializers.deserializeWith(ApplicationStatusModel.serializer, string);
  }

  static Serializer<ApplicationStatusModel> get serializer => _$applicationStatusModelSerializer;
}
