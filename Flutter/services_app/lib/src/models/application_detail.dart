import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/utils/serializers.dart';

part 'application_detail.g.dart';

abstract class ApplicationDetail implements Built<ApplicationDetail, ApplicationDetailBuilder> {
  @nullable
  @BuiltValueField(wireName: 'id_service')
  int get serviceId;

  @BuiltValueField(serialize: true)
  String get title;

  @BuiltValueField(serialize: true)
  String get description;

  @BuiltValueField(serialize: true)
  double get price;

  @BuiltValueField(serialize: true)
  double get workforce;

  @nullable
  @BuiltValueField(compare: false, serialize: true)
  bool get selected;

  ApplicationDetail._();

  factory ApplicationDetail([void Function(ApplicationDetailBuilder) updates]) =
      _$ApplicationDetail;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ApplicationDetail.serializer, this);
  }

  static ApplicationDetail fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ApplicationDetail.serializer, json);
  }

  static Serializer<ApplicationDetail> get serializer => _$applicationDetailSerializer;
}
