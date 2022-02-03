import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notifications.g.dart';

abstract class Notifications
    implements Built<Notifications, NotificationsBuilder> {
  factory Notifications(
          [NotificationsBuilder updates(NotificationsBuilder builder)]) =
      _$Notifications;

  Notifications._();

  int? get id;

  @BuiltValueField(wireName: 'created_at')
  String? get createdAT;

  String? get title;

  String? get body;

  @BuiltValueField(wireName: 'is_unread')
  bool? get isUnRead;

  static Serializer<Notifications> get serializer => _$notificationsSerializer;
}
