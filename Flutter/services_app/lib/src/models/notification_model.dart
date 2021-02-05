import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/utils/serializers.dart';

part 'notification_model.g.dart';

abstract class NotificationModel implements Built<NotificationModel, NotificationModelBuilder> {
  @nullable
  String get title;
  @nullable
  String get body;

  NotificationModel._();
  factory NotificationModel([void Function(NotificationModelBuilder) updates]) =
      _$NotificationModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(NotificationModel.serializer, this);
  }

  static NotificationModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(NotificationModel.serializer, json);
  }

  static Serializer<NotificationModel> get serializer => _$notificationModelSerializer;
}
