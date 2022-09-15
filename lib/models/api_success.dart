import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:personal_pjt/models/models.dart';

part 'api_success.g.dart';

abstract class ApiSuccess implements Built<ApiSuccess, ApiSuccessBuilder> {
  factory ApiSuccess([ApiSuccessBuilder updates(ApiSuccessBuilder builder)]) =
      _$ApiSuccess;

  ApiSuccess._();

  int? get status;

  String? get message;

  AccessToken? get token;

  @BuiltValueField(wireName: 'user')
  AppUser? get user;

//***************************** pagination ***********************************//
  Pagination? get meta;

//****************************** notification-module *************************///

  @BuiltValueField(wireName: 'notifications')
  BuiltList<Notifications?> get notifications;

  @BuiltValueField(wireName: 'notification')
  Notifications? get notification;

//****************************** file-upload **********************************//

  @BuiltValueField(wireName: 'uploaded_file')
  FileAttachment? get uploadedFile;
  String? get url;

  @BuiltValueField(wireName: 'url_fields')
  S3BucketResponse? get urlFields;

  static Serializer<ApiSuccess> get serializer => _$apiSuccessSerializer;
}
