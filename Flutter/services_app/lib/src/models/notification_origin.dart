import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/utils/serializers.dart';

part 'notification_origin.g.dart';

class NotificationOrigin extends EnumClass {
  static const NotificationOrigin onMessage = _$onMessage;
  static const NotificationOrigin onResume = _$onResume;
  static const NotificationOrigin onLaunch = _$onLaunch;
  static const NotificationOrigin another = _$another;

  const NotificationOrigin._(String name) : super(name);

  static BuiltSet<NotificationOrigin> get values => _$notificationOriginValues;
  static NotificationOrigin valueOf(String name) => _$notificationOriginValueOf(name);

  String serialize() {
    return serializers.serializeWith(NotificationOrigin.serializer, this);
  }

  static NotificationOrigin deserialize(String string) {
    return serializers.deserializeWith(NotificationOrigin.serializer, string);
  }

  static Serializer<NotificationOrigin> get serializer => _$notificationOriginSerializer;
}
