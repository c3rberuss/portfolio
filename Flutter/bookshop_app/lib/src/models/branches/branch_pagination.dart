import 'package:bookshop/src/models/branches/branch_model.dart';
import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'branch_pagination.g.dart';

abstract class BranchPagination implements Built<BranchPagination, BranchPaginationBuilder> {
  @BuiltValueField(wireName: 'pages')
  int get totalPages;
  @BuiltValueField(wireName: 'actual')
  int get page;
  @nullable
  BuiltList<BranchModel> get data;

  BranchPagination._();
  factory BranchPagination([void Function(BranchPaginationBuilder) updates]) = _$BranchPagination;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(BranchPagination.serializer, this);
  }

  static BranchPagination fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(BranchPagination.serializer, json);
  }

  static Serializer<BranchPagination> get serializer => _$branchPaginationSerializer;
}
