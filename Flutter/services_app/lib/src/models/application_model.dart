import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/models/application_detail.dart';
import 'package:services/src/models/application_status_model.dart';
import 'package:services/src/models/image_model.dart';
import 'package:services/src/utils/serializers.dart';

part 'application_model.g.dart';

abstract class ApplicationModel implements Built<ApplicationModel, ApplicationModelBuilder> {
  @nullable
  @BuiltValueField(wireName: 'id_application')
  int get applicationId;

  @nullable
  @BuiltValueField(wireName: 'attachments')
  BuiltList<ImageModel> get images;

  @nullable
  @BuiltValueField(wireName: 'detail')
  BuiltList<ApplicationDetail> get services;

  @nullable
  @BuiltValueField(wireName: 'state')
  ApplicationStatusModel get status;

  @nullable
  String get description;

  double get latitude;

  double get longitude;

  double get total;

  @nullable
  @BuiltValueField(wireName: 'money_paid')
  double get moneyPaid;

  @nullable
  @BuiltValueField(wireName: 'created_at')
  String get createdAt;

  ApplicationModel._();

  factory ApplicationModel([void Function(ApplicationModelBuilder) updates]) = _$ApplicationModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ApplicationModel.serializer, this);
  }

  static ApplicationModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ApplicationModel.serializer, json);
  }

  static Serializer<ApplicationModel> get serializer => _$applicationModelSerializer;
}
