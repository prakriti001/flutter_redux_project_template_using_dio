import 'dart:io';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_attachment.g.dart';

abstract class FileAttachment
    implements Built<FileAttachment, FileAttachmentBuilder> {
  factory FileAttachment(
          [FileAttachmentBuilder updates(FileAttachmentBuilder builder)]) =
      _$FileAttachment;

  FileAttachment._();

  @BuiltValueField(wireName: 'attachment_url')
  String? get attachmentUrl;

  int? get id;

  @BuiltValueField(wireName: 'attachment_type')
  String? get attachmentType;

  @BuiltValueField(wireName: 'attachment_name')
  String? get attachmentName;

  File? get attachmentFile;

  @BuiltValueField(wireName: 'file_type')
  String? get fileType;

  @BuiltValueField(wireName: 'thumbnail_url')
  String? get thumbnailUrl;

  static Serializer<FileAttachment> get serializer =>
      _$fileAttachmentSerializer;
}
abstract class S3BucketResponse
    implements Built<S3BucketResponse, S3BucketResponseBuilder> {
  factory S3BucketResponse(
      [S3BucketResponseBuilder Function(S3BucketResponseBuilder builder)
      updates]) = _$S3BucketResponse;

  S3BucketResponse._();

  String? get key;

  @BuiltValueField(wireName: 'success_action_status')
  String? get successActionStatus;

  String? get policy;

  @BuiltValueField(wireName: 'x-amz-credential')
  String? get xAmzCredential;

  @BuiltValueField(wireName: 'x-amz-algorithm')
  String? get xAmzAlgorithm;

  @BuiltValueField(wireName: 'x-amz-date')
  String? get xAmzDate;

  @BuiltValueField(wireName: 'x-amz-signature')
  String? get xAmzSignature;

  static Serializer<S3BucketResponse> get serializer =>
      _$s3BucketResponseSerializer;
}
