import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/models/notification_type.dart';
import 'package:services/src/utils/serializers.dart';

part 'notification_data_model.g.dart';

abstract class NotificationDataModel
    implements Built<NotificationDataModel, NotificationDataModelBuilder> {
  @nullable
  @BuiltValueField(wireName: 'application_id')
  String get applicationId;

  @nullable
  @BuiltValueField(wireName: 'notification_type')
  NotificationType get notificationType;
  @nullable
  String get title;
  @nullable
  String get body;

  NotificationDataModel._();
  factory NotificationDataModel([void Function(NotificationDataModelBuilder) updates]) =
      _$NotificationDataModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(NotificationDataModel.serializer, this);
  }

  static NotificationDataModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(NotificationDataModel.serializer, json);
  }

  static Serializer<NotificationDataModel> get serializer => _$notificationDataModelSerializer;
}
