import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/utils/serializers.dart';

part 'notification_type.g.dart';

class NotificationType extends EnumClass {
  @BuiltValueEnumConst(wireName: "service_finished")
  static const NotificationType serviceFinished = _$serviceFinished;

  @BuiltValueEnumConst(wireName: "service_started")
  static const NotificationType serviceStarted = _$serviceStarted;

  @BuiltValueEnumConst(fallback: true)
  static const NotificationType unknown = _$unknown;

  const NotificationType._(String name) : super(name);

  static BuiltSet<NotificationType> get values => _$notificationTypeValues;
  static NotificationType valueOf(String name) => _$notificationTypeValueOf(name);

  String serialize() {
    return serializers.serializeWith(NotificationType.serializer, this);
  }

  static NotificationType deserialize(String string) {
    return serializers.deserializeWith(NotificationType.serializer, string);
  }

  static Serializer<NotificationType> get serializer => _$notificationTypeSerializer;
}
