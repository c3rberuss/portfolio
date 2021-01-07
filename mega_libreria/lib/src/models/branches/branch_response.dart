import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:megalibreria/src/models/branches/branch_pagination.dart';
import 'package:megalibreria/src/utils/serializers.dart';

part 'branch_response.g.dart';

abstract class BranchResponse implements Built<BranchResponse, BranchResponseBuilder> {

  int get code;
  String get message;
  @nullable
  @BuiltValueField(wireName: 'data')
  BranchPagination get body;

  BranchResponse._();
  factory BranchResponse([void Function(BranchResponseBuilder) updates]) = _$BranchResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(BranchResponse.serializer, this);
  }

  static BranchResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(BranchResponse.serializer, json);
  }

  static Serializer<BranchResponse> get serializer => _$branchResponseSerializer;
}