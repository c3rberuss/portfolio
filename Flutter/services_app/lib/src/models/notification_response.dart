import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/models/notification_data_model.dart';
import 'package:services/src/models/notification_model.dart';
import 'package:services/src/utils/serializers.dart';

part 'notification_response.g.dart';

abstract class NotificationResponse
    implements Built<NotificationResponse, NotificationResponseBuilder> {
  @nullable
  NotificationModel get notification;
  @nullable
  NotificationDataModel get data;

  NotificationResponse._();
  factory NotificationResponse([void Function(NotificationResponseBuilder) updates]) =
      _$NotificationResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(NotificationResponse.serializer, this);
  }

  static NotificationResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(NotificationResponse.serializer, json);
  }

  static Serializer<NotificationResponse> get serializer => _$notificationResponseSerializer;
}
