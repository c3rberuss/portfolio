import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:megalibreria/src/utils/serializers.dart';

part 'department_model.g.dart';

abstract class DepartmentModel implements Built<DepartmentModel, DepartmentModelBuilder> {

  @BuiltValueField(wireName: 'id')
  int get id;
  @BuiltValueField(wireName: 'nombre')
  String get name;

  DepartmentModel._();
  factory DepartmentModel([void Function(DepartmentModelBuilder) updates]) = _$DepartmentModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(DepartmentModel.serializer, this);
  }

  static DepartmentModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(DepartmentModel.serializer, json);
  }

  static Serializer<DepartmentModel> get serializer => _$departmentModelSerializer;
}