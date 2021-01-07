import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:megalibreria/src/utils/serializers.dart';

part 'branch_model.g.dart';

abstract class BranchModel implements Built<BranchModel, BranchModelBuilder> {
  @BuiltValueField(wireName: 'id_empresa')
  int get id;
  @BuiltValueField(wireName: 'id_categoria')
  int get idCategory;
  @BuiltValueField(wireName: 'estado')
  int get status;
  @BuiltValueField(wireName: 'nombre')
  String get name;
  @BuiltValueField(wireName: 'logo')
  String get image;

  BranchModel._();
  factory BranchModel([void Function(BranchModelBuilder) updates]) = _$BranchModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(BranchModel.serializer, this);
  }

  static BranchModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(BranchModel.serializer, json);
  }

  static Serializer<BranchModel> get serializer => _$branchModelSerializer;
}